using DatabaseProvider.MyDB;
using DatabaseProvider.NewClassForUI;
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
        public Img GetObject_User()
        {
            /*string SQL = "SELECT * FROM TVLT_USers WHERE Uid = '"+uid+"' AND Pwd='" + pass + "'";
            return mydb.Database.SqlQuery<TVLT_Users>(SQL).FirstOrDefault();*/
            /*return mydb.Database.SqlQuery<Book>(
                "SELECT * FROM Img",
                new SqlParameter("@U", uid),
                new SqlParameter("@P", pass)
                ).FirstOrDefault();*/
            return mydb.Database.SqlQuery<Img>(
                "SELECT * FROM Img"
                ).FirstOrDefault();
        }
        
    }
}
