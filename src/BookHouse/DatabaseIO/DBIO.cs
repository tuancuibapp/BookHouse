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
            cmd.CommandText = "SELECT * FROM BookInfor(@bid)";
            cmd.Parameters.Add(new SqlParameter("@bid", bid));
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
            bookInforUI.images = retVal.Rows[0]["Images"].ToString();
            /*cmd.CommandText = "SELECT * FROM BookComment(@bid)";
            retVal.Load(cmd.ExecuteReader());
            bookInforUI.comments = new List<Comment>();
            for (int i = 0; i <= retVal.Rows.Count; i++)
            {
                bookInforUI.comments[i].customer = retVal.Rows[i]["CustomerName"].ToString();
                bookInforUI.comments[i].content = retVal.Rows[i]["Content"].ToString();
            }*/
            return bookInforUI;
        }

        public FAQUI GetObject_FAQUI()
        {
            FAQUI faq = new FAQUI();
            faq.faqs = mydb.Database.SqlQuery<FAQ>("SELECT * FROM FAQ").ToList<FAQ>();
            return faq;
        }

        public HomepageUI GetObject_HomePageUI()
        {
            HomepageUI homepage = new HomepageUI();
            DataTable retVal = new DataTable();
            var cmd = mydb.Database.Connection.CreateCommand();
            cmd.Connection.Open();
            retVal.Load(cmd.ExecuteReader());
            homepage.bestSellingBooks = new List<BookOnHomepage>(5);
            cmd.CommandText = "SELECT * FROM BestSellerGenneral";
            for (int i = 0; i <= 4; i++)
            {
                homepage.bestSellingBooks[i] = new BookOnHomepage();
                homepage.bestSellingBooks[i].BookID = retVal.Rows[i]["BookID"].ToString();
                homepage.bestSellingBooks[i].BookName = retVal.Rows[i]["BookName"].ToString();
                homepage.bestSellingBooks[i].Price = int.Parse(retVal.Rows[i]["Price"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.bestSellingBooks[i].rating = float.Parse(retVal.Rows[i]["Rating"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.bestSellingBooks[i].images = retVal.Rows[i]["ImagePath"].ToString();
            }
            homepage.foreignLiteratureBooks = new List<BookOnHomepage>(5);
            cmd.CommandText = "SELECT * FROM BestSellerCategory(@typename)";
            cmd.Parameters.Add(new SqlParameter("@typename", "Thơ"));
            retVal.Load(cmd.ExecuteReader());
            for (int i = 0; i <= 4; i++)
            {
                homepage.foreignLiteratureBooks[i] = new BookOnHomepage();
                homepage.foreignLiteratureBooks[i].BookID = retVal.Rows[i]["BookID"].ToString();
                homepage.foreignLiteratureBooks[i].BookName = retVal.Rows[i]["BookName"].ToString();
                homepage.foreignLiteratureBooks[i].Price = int.Parse(retVal.Rows[i]["Price"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.foreignLiteratureBooks[i].rating = float.Parse(retVal.Rows[i]["Rating"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.foreignLiteratureBooks[i].images = retVal.Rows[i]["ImagePath"].ToString();
            }
            homepage.vietnameseLiteratureBooks = new List<BookOnHomepage>(5);
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new SqlParameter("@typename", "Truyện ngắn"));
            retVal.Load(cmd.ExecuteReader());
            for (int i = 0; i <= 4; i++)
            {
                homepage.vietnameseLiteratureBooks[i] = new BookOnHomepage();
                homepage.vietnameseLiteratureBooks[i].BookID = retVal.Rows[i]["BookID"].ToString();
                homepage.vietnameseLiteratureBooks[i].BookName = retVal.Rows[i]["BookName"].ToString();
                homepage.vietnameseLiteratureBooks[i].Price = int.Parse(retVal.Rows[i]["Price"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.vietnameseLiteratureBooks[i].rating = float.Parse(retVal.Rows[i]["Rating"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.vietnameseLiteratureBooks[i].images = retVal.Rows[i]["ImagePath"].ToString();
            }
            homepage.historyBooks = new List<BookOnHomepage>();
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new SqlParameter("@typename", "Lịch sử"));
            retVal.Load(cmd.ExecuteReader());
            for (int i = 0; i <= 4; i++)
            {
                homepage.historyBooks[i] = new BookOnHomepage();
                homepage.historyBooks[i].BookID = retVal.Rows[i]["BookID"].ToString();
                homepage.historyBooks[i].BookName = retVal.Rows[i]["BookName"].ToString();
                homepage.historyBooks[i].Price = int.Parse(retVal.Rows[i]["Price"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.historyBooks[i].rating = float.Parse(retVal.Rows[i]["Rating"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.historyBooks[i].images = retVal.Rows[i]["ImagePath"].ToString();
            }
            return homepage;
        }

        public ProfileUI GetObject_ProfileUI(string uid)
        {
            ProfileUI profile = new ProfileUI();
            profile.customer = new Customer();
            profile.order = mydb.Database.SqlQuery<OrderCart>("SELECT * FROM OrderCart WHERE CustomerID = @uid and Order_or_Cart = 'TRUE'", new SqlParameter("@uid", uid)).ToList();
            profile.customer = mydb.Database.SqlQuery<Customer>("SELECT * FROM Customer WHERE CustomerID = @uid", new SqlParameter("@uid", uid)).FirstOrDefault();
            return profile;
        }

        public DetailOrderUI GetObject_DetailOrderUI (string uid, string oid)
        {
            DataTable retVal = new DataTable();
            retVal = mydb.Database.SqlQuery<DataTable>("SELECT * FROM OrderDetail(@oid)", new SqlParameter("@oid", oid)).FirstOrDefault();
            DetailOrderUI detail = new DetailOrderUI();
            detail.customer = new Customer();
            detail.customer = mydb.Database.SqlQuery<Customer>("SELECT * FROM Customer WHERE CustomerID = @uid", new SqlParameter("@uid", uid)).FirstOrDefault();
            detail.order = new OrderCart();
            detail.order = mydb.Database.SqlQuery<OrderCart>("SELECT * FROM Customer WHERE OrderCart = @oid", new SqlParameter("@oid", oid)).FirstOrDefault();
            detail.bookDetailOrder = new List<BookDetailOrder>();
            for (int i = 1; i <= retVal.Rows.Count; i++)
            {
                detail.bookDetailOrder[i - 1].bookID = retVal.Rows[i]["BookID"].ToString();
                detail.bookDetailOrder[i - 1].bookName = retVal.Rows[i]["BookName"].ToString();
                detail.bookDetailOrder[i - 1].price = float.Parse(retVal.Rows[i]["Price"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                detail.bookDetailOrder[i - 1].number = int.Parse(retVal.Rows[i]["Number"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
            }
            return detail;
        }

        public List<BookDetailOrder> GetObject_CartUI(string uid)
        {
            List<BookDetailOrder> cart = new List<BookDetailOrder>();
            DataTable retVal = new DataTable();
            retVal = mydb.Database.SqlQuery<DataTable>("SELECT * FROM MyCart(@uid)", new SqlParameter("@uid", uid)).FirstOrDefault();
            for (int i = 1; i <= retVal.Rows.Count; i++)
            {
                cart[i - 1].bookID = retVal.Rows[i]["BookID"].ToString();
                cart[i - 1].bookName = retVal.Rows[i]["BookName"].ToString();
                cart[i - 1].price = float.Parse(retVal.Rows[i]["Price"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                cart[i - 1].number = int.Parse(retVal.Rows[i]["Number"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
            }
            return cart;
        }

        public OrderConfirmUI GetObject_OrderConfirmUI(string oid)
        {
            OrderConfirmUI order = new OrderConfirmUI();
            order.order = new OrderCart();
            order.order = mydb.Database.SqlQuery<OrderCart>("SELECT * FROM Customer WHERE OrderCart = @oid", new SqlParameter("@oid", oid)).FirstOrDefault();
            // sorry i don't know
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