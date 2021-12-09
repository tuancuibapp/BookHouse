using DatabaseProvider;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DatabaseIO
{
    public class DBIO
    {
        MyDB mydb = new MyDB();
        public TVLT_Users GetObject_User(string uid, string pass)
        {
            /*string SQL = "SELECT * FROM TVLT_USers WHERE Uid = '"+uid+"' AND Pwd='" + pass + "'";
            return mydb.Database.SqlQuery<TVLT_Users>(SQL).FirstOrDefault();*/
            return mydb.Database.SqlQuery<TVLT_Users>(
                "SELECT * FROM TVLT_Users WHERE Uid=@U AND Pwd=@P",
                new SqlParameter("@U", uid),
                new SqlParameter("@P", pass)
                ).FirstOrDefault();
        }
        
    }
}
