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

        public Customer GetObject_User(string uid)
        {
            return mydb.Database.SqlQuery<Customer>("SELECT * FROM Customer WHERE CustomerPhone = @uid", new SqlParameter("@uid", uid)).FirstOrDefault();
        }

        public BookInforUI GetObject_Book(string bid)
        {
            BookInforUI u = new BookInforUI();
            DataTable retVal = new DataTable();
            var cmd = mydb.Database.Connection.CreateCommand();
            cmd.CommandText = "select BookName, BookID from Book";
            cmd.Connection.Open();
            retVal.Load(cmd.ExecuteReader());
            u.book.BookName = retVal.Rows[0]["BookName"].ToString();
            return u;
        }

        public BookInforUI GetObject_BookInforUI(string bid)
        {
            BookInforUI bookInforUI = new BookInforUI();
            DataTable retVal = new DataTable();
            var cmd = mydb.Database.Connection.CreateCommand();
            cmd.CommandText = "SELECT * FROM BookInfor('00000')";
            cmd.Connection.Open();
            retVal.Load(cmd.ExecuteReader());
            bookInforUI.book.BookID = bid;
            bookInforUI.book.BookName = retVal.Rows[0]["BookName"].ToString();
            bookInforUI.book.AuthorName = retVal.Rows[0]["AuthorName"].ToString();
            bookInforUI.book.Description = retVal.Rows[0]["Description"].ToString();
            bookInforUI.book.Price = int.Parse(retVal.Rows[0]["Price"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
            bookInforUI.book.Stock = short.Parse(retVal.Rows[0]["Stock"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
            bookInforUI.book.NumOfPage = short.Parse(retVal.Rows[0]["NumOfPage"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
            bookInforUI.book.PublishingCom = retVal.Rows[0]["PublishingCom"].ToString();
            bookInforUI.book.ReleaseDate = DateTime.Parse(retVal.Rows[0]["ReleaseDate"].ToString(), CultureInfo.InvariantCulture);
            bookInforUI.category = retVal.Rows[0]["CategoryName"].ToString();
            bookInforUI.rating = float.Parse(retVal.Rows[0]["Rating"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
            /*bookInforUI.images = retVal.Rows[0]["Image"].ToString();*/
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
            HomepageUI homepage = new HomepageUI();
            DataTable retVal = new DataTable();
            homepage.bestSellingBooks = new List<BookOnHomepage>(5);
            retVal = mydb.Database.SqlQuery<DataTable>("SELECT * FROM HomePageUI(@bid)", new SqlParameter("@bid", bid)).FirstOrDefault();
            for (int i = 0; i <= 4; i++)
            {
                homepage.bestSellingBooks[i] = new BookOnHomepage();
                homepage.bestSellingBooks[i].BookID = retVal.Rows[i]["BookID"].ToString();
                homepage.bestSellingBooks[i].BookName = retVal.Rows[i]["BookName"].ToString();
                homepage.bestSellingBooks[i].Price = int.Parse(retVal.Rows[i]["Price"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.bestSellingBooks[i].rating = float.Parse(retVal.Rows[i]["Rating"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.bestSellingBooks[i].images = retVal.Rows[i]["Imgage"].ToString();
            }
            homepage.foreignLiteratureBooks = new List<BookOnHomepage>(5);
            retVal = mydb.Database.SqlQuery<DataTable>("SELECT * FROM HomePageUI(@bid)", new SqlParameter("@bid", bid)).FirstOrDefault();
            for (int i = 0; i <= 4; i++)
            {
                homepage.bestSellingBooks[i] = new BookOnHomepage();
                homepage.bestSellingBooks[i].BookID = retVal.Rows[i]["BookID"].ToString();
                homepage.bestSellingBooks[i].BookName = retVal.Rows[i]["BookName"].ToString();
                homepage.bestSellingBooks[i].Price = int.Parse(retVal.Rows[i]["Price"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.bestSellingBooks[i].rating = float.Parse(retVal.Rows[i]["Rating"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.bestSellingBooks[i].images = retVal.Rows[i]["Imgage"].ToString();
            }
            homepage.vietnameseLiteratureBooks = new List<BookOnHomepage>(5);
            retVal = mydb.Database.SqlQuery<DataTable>("SELECT * FROM HomePageUI(@bid)", new SqlParameter("@bid", bid)).FirstOrDefault();
            for (int i = 0; i <= 4; i++)
            {
                homepage.bestSellingBooks[i] = new BookOnHomepage();
                homepage.bestSellingBooks[i].BookID = retVal.Rows[i]["BookID"].ToString();
                homepage.bestSellingBooks[i].BookName = retVal.Rows[i]["BookName"].ToString();
                homepage.bestSellingBooks[i].Price = int.Parse(retVal.Rows[i]["Price"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.bestSellingBooks[i].rating = float.Parse(retVal.Rows[i]["Rating"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.bestSellingBooks[i].images = retVal.Rows[i]["Imgage"].ToString();
            }
            homepage.historyBooks = new List<BookOnHomepage>();
            retVal = mydb.Database.SqlQuery<DataTable>("SELECT * FROM HomePageUI(@bid)", new SqlParameter("@bid", bid)).FirstOrDefault();
            for (int i = 0; i <= 4; i++)
            {
                homepage.bestSellingBooks[i] = new BookOnHomepage();
                homepage.bestSellingBooks[i].BookID = retVal.Rows[i]["BookID"].ToString();
                homepage.bestSellingBooks[i].BookName = retVal.Rows[i]["BookName"].ToString();
                homepage.bestSellingBooks[i].Price = int.Parse(retVal.Rows[i]["Price"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.bestSellingBooks[i].rating = float.Parse(retVal.Rows[i]["Rating"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.bestSellingBooks[i].images = retVal.Rows[i]["Imgage"].ToString();
            }
            return homepage;
        }

        public ProfileUI GetObject_ProfileUI(string uid)
        {
            ProfileUI profile = new ProfileUI();
            profile.customer = new Customer();
            profile.order = new List<OrderCart>();
            profile.customer = mydb.Database.SqlQuery<Customer>("SELECT * FROM Customer WHERE CustomerID = @uid", new SqlParameter("@uid", uid)).FirstOrDefault();
            DataTable retVal = new DataTable();
            retVal = mydb.Database.SqlQuery<DataTable>("").FirstOrDefault();
            return null;
        }

        public DetailOrderUI GetObject_DetailOrderUI (string uid, string oid)
        {
            DetailOrderUI detail = new DetailOrderUI();
            return null;
        }

        public CartUI GetObject_CartUI(string cid)
        {
            CartUI cart = new CartUI();
            return null;
        }

        public OrderConfirmUI GetObject_OrderConfirmUI()
        {
            OrderConfirmUI order = new OrderConfirmUI();
            return null;
        }

        public RatingUI GetObject_RatingUI()
        {
            RatingUI rating = new RatingUI();
            return null;
        }

        public List<OrderCart> GetObject_OrderManagingUI(string uid)
        {
            List<OrderCart> carts = new List<OrderCart>();
            return null;
        }
    }
}