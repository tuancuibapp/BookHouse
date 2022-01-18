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

        public List<Order> GetObject_ListOrder(string uid)
        {
            return mydb.Database.SqlQuery<Order>("SELECT * FROM [Order] WHERE CustomerID = @uid", new SqlParameter("@uid", uid)).ToList<Order>();
        }

        public BookInforUI GetObject_BookInforUI(string bid)
        {
            BookInforUI bookInforUI = new BookInforUI();
            DataTable retVal = new DataTable();
            var cmd = mydb.Database.Connection.CreateCommand();
            cmd.CommandText = "SELECT * FROM BookInfor(@bid)";
            cmd.Parameters.Add(new SqlParameter("@bid", bid));
            cmd.Connection.Close();
            cmd.Connection.Open();
            retVal.Load(cmd.ExecuteReader());
            if(retVal.Rows.Count == 0)
            {
                return null;
            }
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
            if (retVal.Rows[0]["Rating"].ToString() == "")
                bookInforUI.rating = 5;
            else
                bookInforUI.rating = float.Parse(retVal.Rows[0]["Rating"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
            bookInforUI.images = retVal.Rows[0]["ImagePath"].ToString();
            cmd.CommandText = "SELECT * FROM BookComment(@bid)";
            retVal.Clear();
            retVal.Columns.Clear();
            retVal.Rows.Clear();
            retVal.Load(cmd.ExecuteReader());/**/
            bookInforUI.comments = new List<Comment>();
            for (int i = 0; i < retVal.Rows.Count; i++)
            {
                bookInforUI.comments.Add(new Comment());
                bookInforUI.comments[i].customer = retVal.Rows[i]["CustomerName"].ToString();
                bookInforUI.comments[i].content = retVal.Rows[i]["Content"].ToString();
            }
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
            cmd.CommandText = "SELECT * FROM BestSellerGenneral()";
            cmd.Connection.Open();
            retVal.Load(cmd.ExecuteReader());
            homepage.bestSellingBooks = new List<BookOnHomepage>(5);
            for (int i = 0; i < 5; i++)
            {
                homepage.bestSellingBooks.Add(new BookOnHomepage());
                homepage.bestSellingBooks[i].BookID = retVal.Rows[i]["BookID"].ToString();
                homepage.bestSellingBooks[i].BookName = retVal.Rows[i]["BookName"].ToString();
                homepage.bestSellingBooks[i].Price = int.Parse(retVal.Rows[i]["Price"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                if (retVal.Rows[i]["Rating"].ToString() == "NULL")
                    homepage.bestSellingBooks[i].rating = 5;
                else
                    homepage.bestSellingBooks[i].rating = float.Parse(retVal.Rows[i]["Rating"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.bestSellingBooks[i].images = retVal.Rows[i]["ImagePath"].ToString();
            }
            homepage.foreignLiteratureBooks = new List<BookOnHomepage>(5);
            cmd.CommandText = "SELECT * FROM BestSellerCategory(N'Thơ')";
            cmd.Parameters.Add(new SqlParameter("@typename", "N'Thơ'"));
            retVal.Clear();
            retVal.Load(cmd.ExecuteReader());
            for (int i = 0; i <= 4; i++)
            {
                homepage.foreignLiteratureBooks.Add(new BookOnHomepage());
                homepage.foreignLiteratureBooks[i].BookID = retVal.Rows[i]["BookID"].ToString();
                homepage.foreignLiteratureBooks[i].BookName = retVal.Rows[i]["BookName"].ToString();
                homepage.foreignLiteratureBooks[i].Price = int.Parse(retVal.Rows[i]["Price"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                if (retVal.Rows[i]["Rating"].ToString() == "")
                    homepage.foreignLiteratureBooks[i].rating = 5;
                else
                    homepage.foreignLiteratureBooks[i].rating = float.Parse(retVal.Rows[i]["Rating"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.foreignLiteratureBooks[i].images = retVal.Rows[i]["ImagePath"].ToString();
            }
            homepage.vietnameseLiteratureBooks = new List<BookOnHomepage>(5);

            cmd.Parameters.Clear();
            cmd.Parameters.Add(new SqlParameter("@typename", "N'Truyện ngắn'"));
            retVal.Clear();
            retVal.Load(cmd.ExecuteReader());
            for (int i = 0; i <= 4; i++)
            {
                homepage.vietnameseLiteratureBooks.Add(new BookOnHomepage());
                homepage.vietnameseLiteratureBooks[i].BookID = retVal.Rows[i]["BookID"].ToString();
                homepage.vietnameseLiteratureBooks[i].BookName = retVal.Rows[i]["BookName"].ToString();
                homepage.vietnameseLiteratureBooks[i].Price = int.Parse(retVal.Rows[i]["Price"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                if (retVal.Rows[i]["Rating"].ToString() == "")
                    homepage.vietnameseLiteratureBooks[i].rating = 5;
                else
                    homepage.vietnameseLiteratureBooks[i].rating = float.Parse(retVal.Rows[i]["Rating"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.vietnameseLiteratureBooks[i].images = retVal.Rows[i]["ImagePath"].ToString();
            }
            homepage.historyBooks = new List<BookOnHomepage>();
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new SqlParameter("@typename", "N'Lịch sử'"));
            retVal.Clear();
            retVal.Load(cmd.ExecuteReader());
            for (int i = 0; i <= 4; i++)
            {
                homepage.historyBooks.Add(new BookOnHomepage());
                homepage.historyBooks[i].BookID = retVal.Rows[i]["BookID"].ToString();
                homepage.historyBooks[i].BookName = retVal.Rows[i]["BookName"].ToString();
                homepage.historyBooks[i].Price = int.Parse(retVal.Rows[i]["Price"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                if (retVal.Rows[i]["Rating"].ToString() == "")
                    homepage.historyBooks[i].rating = 5;
                else
                    homepage.historyBooks[i].rating = float.Parse(retVal.Rows[i]["Rating"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                homepage.historyBooks[i].images = retVal.Rows[i]["ImagePath"].ToString();
            }
            return homepage;
        }

        public ProfileUI GetObject_ProfileUI(string uid)
        {
            ProfileUI profile = new ProfileUI();
            profile.customer = new Customer();
            profile.order = mydb.Database.SqlQuery<Order>("SELECT * FROM [Order] WHERE CustomerID = @uid", new SqlParameter("@uid", uid)).ToList();
            profile.customer = mydb.Database.SqlQuery<Customer>("SELECT * FROM Customer WHERE CustomerID = @uid", new SqlParameter("@uid", uid)).FirstOrDefault();
            return profile;
        }

        public DetailOrderUI GetObject_DetailOrderUI (string uid, string oid)
        {
            DetailOrderUI detail = new DetailOrderUI();
            detail.customer = new Customer();
            detail.customer = mydb.Database.SqlQuery<Customer>("SELECT * FROM Customer WHERE CustomerID = @uid", new SqlParameter("@uid", uid)).FirstOrDefault();
            detail.order = new Order();
            detail.order = mydb.Database.SqlQuery<Order>("SELECT * FROM [Order] WHERE OrderID = @oid", new SqlParameter("@oid", oid)).FirstOrDefault();
            DataTable retVal = new DataTable();
            var cmd = mydb.Database.Connection.CreateCommand();
            cmd.CommandText = "SELECT * FROM ViewOrderDetail(@oid)";
            cmd.Parameters.Add(new SqlParameter("@oid", oid));
            cmd.Connection.Open();
            retVal.Load(cmd.ExecuteReader());
            detail.bookDetailOrder = new List<BookDetailOrder>();
            for (int i = 0; i < retVal.Rows.Count; i++)
            {
                detail.bookDetailOrder.Add(new BookDetailOrder());
                detail.bookDetailOrder[i].book = GetObject_BookInforUI(retVal.Rows[i]["BookID"].ToString());
                detail.bookDetailOrder[i].number = int.Parse(retVal.Rows[i]["Quatity"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                detail.bookDetailOrder[i].price = int.Parse(retVal.Rows[i]["PriceForDetail"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                if (retVal.Rows[i]["isRating"].ToString() == "1")
                    detail.bookDetailOrder[i].rating = true;
                else
                    detail.bookDetailOrder[i].rating = false;
            }
            return detail;
        }

        public List<BookDetailOrder> GetObject_CartUI(string uid)
        {
            List<BookDetailOrder> cart = new List<BookDetailOrder>();
            DataTable retVal = new DataTable();
            var cmd = mydb.Database.Connection.CreateCommand();
            cmd.CommandText = "SELECT * FROM MyCart(@uid)";
            cmd.Parameters.Add(new SqlParameter("@uid", uid));
            cmd.Connection.Close();
            cmd.Connection.Open();
            retVal.Load(cmd.ExecuteReader());
            for (int i = 0; i < retVal.Rows.Count; i++)
            {
                cart.Add(new BookDetailOrder());
                cart[i].book = GetObject_BookInforUI(retVal.Rows[i]["BookID"].ToString());
                cart[i].number = int.Parse(retVal.Rows[i]["Quatity"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                cart[i].price = int.Parse(retVal.Rows[i]["Price"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                cart[i].rating = false;
            }
            return cart;
        }

        public RatingUI GetObject_RatingUI(string bid)
        {
            RatingUI rating = new RatingUI();
            rating.book = mydb.Database.SqlQuery<Book>("SELECT * FROM Book WHERE BookID = @bid", new SqlParameter("@bid", bid)).FirstOrDefault();
            DataTable retVal = new DataTable();
            var cmd = mydb.Database.Connection.CreateCommand();
            cmd.CommandText = "SELECT * FROM BookInforSmall(@bid)";
            cmd.Parameters.Add(new SqlParameter("@bid", bid));
            cmd.Connection.Open();
            retVal.Load(cmd.ExecuteReader());
            if (retVal.Rows[0]["Rating"].ToString() == "")
                rating.rating = 5;
            else
                rating.rating = (int)float.Parse(retVal.Rows[0]["Rating"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
            rating.image = retVal.Rows[0]["ImagePath"].ToString();
            rating.sold = int.Parse(retVal.Rows[0]["Sold"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
            return rating;
        }

        public List<BookInforUI> GetObject_Searching(Filters filters)
        {
            DataTable retVal = new DataTable();
            List<BookInforUI> books = new List<BookInforUI>();
            int idx = -1;
            bool price;
            var cmd = mydb.Database.Connection.CreateCommand();
            cmd.Connection.Open();

            if (filters.priceRange[0] >= 0 && filters.priceRange[1] > 0)
                price = true;
            else
                price = false;

            bool loop = true;
            while (loop)
            {
                idx = -1;

                for (int i = 0; i < filters.values.Count(); i++)
                {
                    if (filters.values[i] == true)
                    {
                        idx = i;
                        filters.values[i] = false;
                        loop = true;
                        break;
                    }
                    loop = false;
                }

                if(idx == -1 && books.Count != 0)
                {
                    break;
                }

                if (filters.query != null && idx != -1 && price != false)
                {
                    cmd.CommandText = "SELECT * FROM BestSellerNamePriceCategory(@name, @lowerBound, @uperBound, @bookcategoryName)";
                    cmd.Parameters.Add(new SqlParameter("@name", filters.query));
                    cmd.Parameters.Add(new SqlParameter("@lowerBound", filters.priceRange[0]));
                    cmd.Parameters.Add(new SqlParameter("@uperBound", filters.priceRange[1]));
                    cmd.Parameters.Add(new SqlParameter("@bookcategoryName", filters.categories[idx]));
                }
                else if (filters.query != null & idx != -1 && price == false)
                {
                    cmd.CommandText = "SELECT * FROM BestSellerNameCategory(@name, @bookcategoryName)";
                    cmd.Parameters.Add(new SqlParameter("@name", filters.query));
                    cmd.Parameters.Add(new SqlParameter("@bookcategoryName", filters.categories[idx]));
                }
                else if (filters.query != null && idx == -1 && price != false)
                {
                    cmd.CommandText = "SELECT * FROM BestSellerNamePrice(@name, @lowerBound, @uperBound)";
                    cmd.Parameters.Add(new SqlParameter("@name", filters.query));
                    cmd.Parameters.Add(new SqlParameter("@lowerBound", filters.priceRange[0]));
                    cmd.Parameters.Add(new SqlParameter("@uperBound", filters.priceRange[1]));
                }
                else if (filters.query == null && idx != -1 && price != false)
                {
                    cmd.CommandText = "SELECT * FROM BestSellerPriceCategory(@lowerBound, @uperBound, @bookcategoryName)";
                    cmd.Parameters.Add(new SqlParameter("@lowerBound", filters.priceRange[0]));
                    cmd.Parameters.Add(new SqlParameter("@uperBound", filters.priceRange[1]));
                    cmd.Parameters.Add(new SqlParameter("@bookcategoryName", filters.categories[idx]));
                }
                else if (filters.query == null && idx != -1 && price == false)
                {
                    cmd.CommandText = "SELECT * FROM BestSellerCategory(@bookcategoryName)";
                    cmd.Parameters.Add(new SqlParameter("@bookcategoryName", filters.categories[idx]));
                }
                else if (filters.query == null && idx == -1 && price != false)
                {
                    cmd.CommandText = "SELECT * FROM BestSellerPrice(@lowerBound, @uperBound)";
                    cmd.Parameters.Add(new SqlParameter("@lowerBound", filters.priceRange[0]));
                    cmd.Parameters.Add(new SqlParameter("@uperBound", filters.priceRange[1]));
                }
                else if (filters.query != null && idx == -1 && price == false)
                {
                    cmd.CommandText = "SELECT * FROM BestSellerName(@name)";
                    cmd.Parameters.Add(new SqlParameter("@name", filters.query));
                }

                retVal.Load(cmd.ExecuteReader());
                cmd.Parameters.Clear();
                for (int i = 0; i < retVal.Rows.Count; i++)
                {
                    books.Add(new BookInforUI());
                    books[i].book.BookID = retVal.Rows[i]["BookID"].ToString();
                    books[i].book.BookName = retVal.Rows[i]["BookName"].ToString();
                    books[i].book.Price = int.Parse(retVal.Rows[i]["Price"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                    if (retVal.Rows[i]["Rating"].ToString() == "")
                        books[i].rating = 5;
                    else
                        books[i].rating = float.Parse(retVal.Rows[i]["Rating"].ToString(), CultureInfo.InvariantCulture.NumberFormat);
                    books[i].images = retVal.Rows[i]["ImagePath"].ToString();
                }
                retVal.Clear();
                retVal.Columns.Clear();
                retVal.Rows.Clear();
            }
            return books;
        }

        public bool SaveObject_CreateAccountCustomer(Customer customer)
        {
            var cmd = mydb.Database.Connection.CreateCommand();
            cmd.CommandText = "exec sp_createAccountCustomer @name, @username, @password, @email, @phone, @address, @result";
            cmd.Parameters.Add(new SqlParameter("@name", customer.CustomerName));
            cmd.Parameters.Add(new SqlParameter("@username", customer.UserName));
            cmd.Parameters.Add(new SqlParameter("@password", customer.Password));
            cmd.Parameters.Add(new SqlParameter("@email", customer.CustomerEmail));
            cmd.Parameters.Add(new SqlParameter("@phone", customer.CustomerPhone));
            cmd.Parameters.Add(new SqlParameter("@phone", customer.CustomerPhone));
            cmd.Parameters.Add(new SqlParameter("@address", customer.Address));
            cmd.Parameters.Add(new SqlParameter("@result", 1));
            cmd.Connection.Open();
            cmd.ExecuteReader();
            if (cmd.Parameters["@result"].ToString() == "0")
                return false;
            else
                return true;
        }

        public bool SaveObject_AddComment(string bookid, string customerid, string content)
        {
            var cmd = mydb.Database.Connection.CreateCommand();
            cmd.CommandText = "exec sp_addComment @bookid, @customerid, @content, @result out";
            cmd.Parameters.Add(new SqlParameter("@bookid", bookid));
            cmd.Parameters.Add(new SqlParameter("@customerid", customerid));
            cmd.Parameters.Add(new SqlParameter("@content", content));
            cmd.Parameters.Add(new SqlParameter("@result", DBNull.Value));
            cmd.Connection.Close();
            cmd.Connection.Open();
            cmd.ExecuteReader();
            if (cmd.Parameters["@result"].ToString() == "0")
                return false;
            return true;
        }
        public bool SaveObject_AddRating(string bookid, string customerid, int star)
        {
            var cmd = mydb.Database.Connection.CreateCommand();
            cmd.CommandText = "exec sp_addrating @bookid, @customerid, @star, @result out";
            cmd.Parameters.Add(new SqlParameter("@bookid", bookid));
            cmd.Parameters.Add(new SqlParameter("@customerid", customerid));
            cmd.Parameters.Add(new SqlParameter("@star", star));
            cmd.Parameters.Add(new SqlParameter("@result", DBNull.Value));
            cmd.Connection.Close();
            cmd.Connection.Open();
            cmd.ExecuteReader();
            if (cmd.Parameters["@result"].ToString() == "0")
                return false;
            else
                return true;
        }

        public bool SaveObject_AddToCart(string bookid, int number, string uid)
        {
            var cmd = mydb.Database.Connection.CreateCommand();
            cmd.CommandText = "exec sp_addtocart @uid, @bookid, @quantity, @result";
            cmd.Parameters.Add(new SqlParameter("@uid", uid));
            cmd.Parameters.Add(new SqlParameter("@bookid", bookid));
            cmd.Parameters.Add(new SqlParameter("quantity", number));
            cmd.Parameters.Add(new SqlParameter("@result", DBNull.Value));
            cmd.Connection.Close();
            cmd.Connection.Open();
            SqlDataReader rs = null;
            try { rs = (SqlDataReader)cmd.ExecuteReader(); }
            catch (SqlException) { return false; }
            catch (Exception) { return false; }
            if (rs == null)
                return false;
            if (cmd.Parameters["@result"].ToString() == "0")
                return false;
            else
                return true;
        }

        public bool SaveObject_CreateNewOrder(DetailOrderUI detailOrder)
        {
            var cmd = mydb.Database.Connection.CreateCommand();
            cmd.CommandText = "exec sp_createnewOrder @customerid, @address, @phone, @TotalPrice, @NoteForOrder, " +
                "@OrderDate, @RecipientName, @DeliveryMethod, @DeliveryCharge, @GoodsPrice, @result out, @orderid out";
            cmd.Parameters.Add(new SqlParameter("@customerid", detailOrder.order.CustomerID));
            cmd.Parameters.Add(new SqlParameter("@address", detailOrder.order.Address));
            cmd.Parameters.Add(new SqlParameter("@phone", detailOrder.order.Phone));
            cmd.Parameters.Add(new SqlParameter("@TotalPrice", detailOrder.order.TotalPrice));
            cmd.Parameters.Add(new SqlParameter("@NoteForOrder", detailOrder.order.NoteForOrder));
            cmd.Parameters.Add(new SqlParameter("@OrderDate", DateTime.Now));
            cmd.Parameters.Add(new SqlParameter("@RecipientName", detailOrder.order.RecipientName));
            cmd.Parameters.Add(new SqlParameter("@DeliveryMethod", "COD"));
            cmd.Parameters.Add(new SqlParameter("@DeliveryCharge", 20000));
            cmd.Parameters.Add(new SqlParameter("@GoodsPrice", detailOrder.order.GoodsPrice));
            cmd.Parameters.Add(new SqlParameter("@result", DBNull.Value));
            cmd.Parameters.Add(new SqlParameter("@orderid", DbType.Int32));
            cmd.Connection.Close();
            cmd.Connection.Open();
            cmd.ExecuteReader();
            detailOrder.bookDetailOrder = GetObject_CartUI(detailOrder.order.CustomerID);
            DeleteObject_AllCartDetail(detailOrder.order.CustomerID);
            var tmp = int.Parse(GetCurrentOID()).ToString();
            tmp = "0" + tmp;
            var oidLength = 5 - tmp.Length;
            for (int i = 0; i < oidLength; i++)
            {
                tmp = "0" + tmp;
            }
            if (cmd.Parameters["@result"].ToString() == "0")
                return false;
            else
            {
                if (SaveObject_AddOrderDetail(detailOrder.bookDetailOrder, tmp) == true)
                    return true;
                else
                    return false;
            }
        }

        public string GetCurrentOID()
        {
            var cmd = mydb.Database.Connection.CreateCommand();
            cmd.CommandText = "select dbo.fn_getcurrentOid()";
            cmd.Connection.Close();
            cmd.Connection.Open();
            return (string)cmd.ExecuteScalar();
        }
        public bool SaveObject_AddOrderDetail(List<BookDetailOrder> bookDetails, string oid)
        {
            var cmd = mydb.Database.Connection.CreateCommand();
            cmd.CommandText = "exec sp_addOrderDetail @orderid, @bookid, @quantity, @result out";

            for (int i = 0; i < bookDetails.Count; i++)
            {
                cmd.Parameters.Add(new SqlParameter("@orderid", oid));
                cmd.Parameters.Add(new SqlParameter("@bookid", bookDetails[i].book.book.BookID));
                cmd.Parameters.Add(new SqlParameter("@quantity", bookDetails[i].number));
                cmd.Parameters.Add(new SqlParameter("@result", DBNull.Value));
                cmd.Connection.Close();
                cmd.Connection.Open();
                cmd.ExecuteReader();
                cmd.Parameters.Clear();
            }
            return true;
        }

        public bool DeleteObject_CartDetail(string customerid, string bookid)
        {
            var cmd = mydb.Database.Connection.CreateCommand();
            cmd.CommandText = "exec sp_deletecartdetail @customerid, @bookid, @result out";
            cmd.Parameters.Add(new SqlParameter("@customerid", customerid));
            cmd.Parameters.Add(new SqlParameter("@bookid", bookid));
            cmd.Parameters.Add(new SqlParameter("@result", DBNull.Value));
            cmd.Connection.Close();
            cmd.Connection.Open();
            cmd.ExecuteReader();
            if (cmd.Parameters["@result"].ToString() == "0")
                return false;
            else
                return true;
        }
        public bool DeleteObject_AllCartDetail(string customerid)
        {
            var cmd = mydb.Database.Connection.CreateCommand();
            cmd.CommandText = "exec sp_deleteallcartdetaill @customerid, @result out";
            cmd.Parameters.Add(new SqlParameter("@customerid", customerid));
            cmd.Parameters.Add(new SqlParameter("@result", DBNull.Value));
            cmd.Connection.Close();
            cmd.Connection.Open();
            cmd.ExecuteReader();
            if (cmd.Parameters["@result"].ToString() == "0")
                return false;
            else
                return true;
        }
    }
}