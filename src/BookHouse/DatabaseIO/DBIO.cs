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
            bookInforUI.images = retVal.Rows[1]["Image"].ToString();
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
            retVal = mydb.Database.SqlQuery<DataTable>("SELECT * FROM BestSellerGenneral()").FirstOrDefault();
            for (int i = 1; i <= 5; i++)
            {
                homepage.bestSellingBooks[i - 1] = new BookOnHomepage();
                homepage.bestSellingBooks[i - 1].BookID = retVal.Rows[i]["BookID"].ToString();
                homepage.bestSellingBooks[i - 1].BookName = retVal.Rows[i]["BookName"].ToString();
                homepage.bestSellingBooks[i - 1].Price = int.Parse(retVal.Rows[i]["Price"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.bestSellingBooks[i - 1].rating = float.Parse(retVal.Rows[i]["Rating"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.bestSellingBooks[i - 1].images = retVal.Rows[i]["ImagePath"].ToString();
            }
            homepage.foreignLiteratureBooks = new List<BookOnHomepage>(5);
            retVal = mydb.Database.SqlQuery<DataTable>("SELECT * FROM BestSellerCategory(@typename)", new SqlParameter("@typename", "Truyện ngắn")).FirstOrDefault();
            for (int i = 1; i <= 5; i++)
            {
                homepage.bestSellingBooks[i - 1] = new BookOnHomepage();
                homepage.bestSellingBooks[i - 1].BookID = retVal.Rows[i]["BookID"].ToString();
                homepage.bestSellingBooks[i - 1].BookName = retVal.Rows[i]["BookName"].ToString();
                homepage.bestSellingBooks[i - 1].Price = int.Parse(retVal.Rows[i]["Price"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.bestSellingBooks[i - 1].rating = float.Parse(retVal.Rows[i]["Rating"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.bestSellingBooks[i - 1].images = retVal.Rows[i]["ImagePath"].ToString();
            }
            homepage.vietnameseLiteratureBooks = new List<BookOnHomepage>(5);
            retVal = mydb.Database.SqlQuery<DataTable>("SELECT * FROM BestSellerCategory(@typename)", new SqlParameter("@typename", "Tiểu thuyết")).FirstOrDefault();
            for (int i = 1; i <= 5; i++)
            {
                homepage.bestSellingBooks[i - 1] = new BookOnHomepage();
                homepage.bestSellingBooks[i - 1].BookID = retVal.Rows[i]["BookID"].ToString();
                homepage.bestSellingBooks[i - 1].BookName = retVal.Rows[i]["BookName"].ToString();
                homepage.bestSellingBooks[i - 1].Price = int.Parse(retVal.Rows[i]["Price"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.bestSellingBooks[i - 1].rating = float.Parse(retVal.Rows[i]["Rating"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.bestSellingBooks[i - 1].images = retVal.Rows[i]["ImagePath"].ToString();
            }
            homepage.historyBooks = new List<BookOnHomepage>();
            retVal = mydb.Database.SqlQuery<DataTable>("SELECT * FROM BestSellerCategory(@typename)", new SqlParameter("@typename", "Lịch sử")).FirstOrDefault();
            for (int i = 1; i <= 5; i++)
            {
                homepage.bestSellingBooks[i - 1] = new BookOnHomepage();
                homepage.bestSellingBooks[i - 1].BookID = retVal.Rows[i]["BookID"].ToString();
                homepage.bestSellingBooks[i - 1].BookName = retVal.Rows[i]["BookName"].ToString();
                homepage.bestSellingBooks[i - 1].Price = int.Parse(retVal.Rows[i]["Price"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.bestSellingBooks[i - 1].rating = float.Parse(retVal.Rows[i]["Rating"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.bestSellingBooks[i - 1].images = retVal.Rows[i]["ImagePath"].ToString();
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
            for (int i = 1; i < 5; i++)
            {
                profile.order[i - 1] = new OrderCart();

            }
            return null;
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