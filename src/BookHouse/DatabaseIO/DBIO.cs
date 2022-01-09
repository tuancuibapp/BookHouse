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

        public Customer GetObject_Customer(string phone)
        {
            return mydb.Database.SqlQuery<Customer>("SELECT * FROM Customer WHERE CustomerPhone = @phone", new SqlParameter("@phone", phone)).FirstOrDefault();
        }

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
        public Book GetObject_Book()
        {
            return mydb.Database.SqlQuery<Book>(
                "SELECT * FROM Book"
                ).FirstOrDefault();
        }
        public List<CommentBook> GetObject_CommentBook(string bid)
        {
            return mydb.Database.SqlQuery<CommentBook>(
                "SELECT * FROM CommentBook WHERE BookID=@B",
                new SqlParameter("@B", bid)
                ).ToList();
        }
        public List<Img> GetObject_Image(string bid)
        {
            return mydb.Database.SqlQuery<Img>(
                "SELECT * FROM Img WHERE BookID=@B",
                new SqlParameter("@B", bid)
                ).ToList();

            /*public FAQUI GetObject_FAQUI(string fid)
            {
                var huhu = mydb.Database.SqlQuery<FAQUI>("EXEC tmp");
                FAQUI hhe = new FAQUI();
                return hhe; 
            }*/
        }
    }
}