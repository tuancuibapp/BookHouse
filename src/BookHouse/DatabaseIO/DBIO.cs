using DatabaseProvider.MyDB;
using DatabaseProvider.NewClassForUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
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
        
        public BookInforUI GetObject_BookInforUI(string bid)
        {
            BookInforUI bookInforUI = new BookInforUI();
            DataTable retVal = new DataTable();
            retVal = mydb.Database.SqlQuery<DataTable>("SELECT * FROM BookInfor(@bid)", new SqlParameter("@bid", bid)).FirstOrDefault();
            bookInforUI.book.BookID = bid;
            bookInforUI.book.BookName = retVal.Rows[1]["BookName"].ToString();
            bookInforUI.book.AuthorName = retVal.Rows[1]["AuthorName"].ToString();
            bookInforUI.book.Description = retVal.Rows[1]["Description"].ToString();
            bookInforUI.book.Price = int.Parse(retVal.Rows[1]["Price"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
            bookInforUI.book.Stock = short.Parse(retVal.Rows[1]["Stock"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
            bookInforUI.book.NumOfPage = short.Parse(retVal.Rows[1]["NumOfPage"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
            bookInforUI.book.PublishingCom = retVal.Rows[1]["PublishingCom"].ToString();
            bookInforUI.book.ReleaseDate = DateTime.Parse(retVal.Rows[1]["ReleaseDate"].ToString(), CultureInfo.InvariantCulture);
            bookInforUI.category = retVal.Rows[1]["CategoryName"].ToString();
            bookInforUI.rating = float.Parse(retVal.Rows[1]["Rating"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
            bookInforUI.comments = mydb.Database.SqlQuery<CommentBook>("SELECT * FROM BookComment(@bid)", new SqlParameter("@bid", bid)).ToList<CommentBook>();
            return bookInforUI;
        }

        public FAQUI GetObject_FAQUI()
        {
            FAQUI faq = new FAQUI();
            faq.faqs = mydb.Database.SqlQuery<FAQ>("SELECT * FROM FAQ").ToList<FAQ>();
            return faq;
        }

        public HomepageUI GetObject_HomePageUI(string bid)
        {

            return null;
        }

    }
}