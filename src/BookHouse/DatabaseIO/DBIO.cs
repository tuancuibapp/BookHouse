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
        public Customer GetObject_Customer(string uid)
        {
            return mydb.Database.SqlQuery<Customer>("SELECT * FROM Customer WHERE CustomerID = @uid", new SqlParameter("@uid", uid)).FirstOrDefault();
        }
        
    }
}