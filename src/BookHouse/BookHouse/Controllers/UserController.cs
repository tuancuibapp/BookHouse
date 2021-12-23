using DatabaseIO;
using DatabaseProvider;
using DatabaseProvider.MyDB;
using DatabaseProvider.NewClassForUI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BookHouse.Controllers
{
    public class UserController : Controller
    {
        DBIO db = new DBIO();
        // GET: User    
        public ActionResult HomePage()
        {
            //query for the books -_-
            BookInforUI yay = new BookInforUI
            {
                book = new Book {
                    BookName = "My life is not a joke, jokes have meaning.",
                    BookID = "1",
                    Price = 100000
                },

                rating = 4,
                images = new List<string> { "https://toplist.vn/images/800px/dac-nhan-tam-116541.jpg" }
            };

            ViewData["bestSellers"] = new List<BookInforUI>
            { 
                yay, yay, yay, yay, yay
            };

            ViewData["newBooks"] = new List<BookInforUI>
            {
                yay, yay, yay, yay, yay
            };

            ViewData["History"] = new List<BookInforUI>
            {
                yay, yay, yay, yay, yay
            };

            ViewData["Economical"] = new List<BookInforUI>
            {
                yay, yay, yay, yay, yay
            };

            return View();
        }
        public ActionResult SignIn()
        {
            return View();
        }
        public ActionResult SignUp()
        {
            return View();
        }
        public ActionResult _Profile()
        {
            return View();
        }
        public ActionResult SearchPage(string Query, int page = 1)
        {
            //create filters
            Filters filters = new Filters
            {
                categories = new List<string> {
                    "Tiểu thuyết", "Truyện ngắn", "Thơ", "Trinh thám", "Truyện tranh", "Lịch sử", "Triết học",
                    "Kinh tế", "Tâm lý học", "Tham khảo", "Viễn tưởng" },

                values = new List<bool> {
                    false, false, false, false, false,
                    false, false, false, false, false, false },

                rating = 0,
                sortBy = "sold",
                priceRange = new List<int>{ 0, 0},
                query = Query
            };

            //here is for query the books from database using filters
            BookInforUI yay = new BookInforUI
            {
                book = new Book
                {
                    BookName = "My life is not a joke, jokes have meaning.",
                    BookID = "1",
                    Price = 100000
                },

                rating = 4,
                images = new List<string> { "https://toplist.vn/images/800px/dac-nhan-tam-116541.jpg" }
            };

            List<BookInforUI> queryResult = new List<BookInforUI>
            {yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay,
            yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay,
            yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay,
            yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay,
            yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay,
            yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay,
            yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay,
            yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay,
            yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay,
            yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay,
            yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay};

            //get the info for the view
            int pageSize = 20;
            ViewData["Filters"] = filters;
            ViewBag.currentPage = page;

            int NumPage = queryResult.Count / pageSize;
            if (queryResult.Count % pageSize != 0)
                NumPage++;
            ViewBag.numPage = NumPage;
            ViewData["Query"] = Query;

            List<BookInforUI> searchData = queryResult.GetRange(pageSize * page, Math.Min(pageSize, queryResult.Count - pageSize * page));
            return View(searchData);
        }

        [HttpPost]
        public ActionResult SearchPage(string Query, Filters filters, int page = 1)
        {
            //here is for query the books from database using filters
            filters.categories = new List<string> {
                    "Tiểu thuyết", "Truyện ngắn", "Thơ", "Trinh thám", "Truyện tranh", "Lịch sử", "Triết học",
                    "Kinh tế", "Tâm lý học", "Tham khảo", "Viễn tưởng" };

            BookInforUI yay = new BookInforUI
            {
                book = new Book
                {
                    BookName = "My life is not a joke, jokes have meaning.",
                    BookID = "1",
                    Price = 100000
                },

                rating = 4,
                images = new List<string> { "https://toplist.vn/images/800px/dac-nhan-tam-116541.jpg" }
            };

            List<BookInforUI> queryResult = new List<BookInforUI>
            {yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay,
            yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay,
            yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay};

            //get the info for the view
            int pageSize = 20;
            ViewData["Filters"] = filters;
            ViewData["CurrentPage"] = page;

            int NumPage = queryResult.Count / pageSize;
            if (queryResult.Count % pageSize != 0)
                NumPage++;
            ViewData["NumPage"] = NumPage;
            ViewData["Query"] = Query;

            List<BookInforUI> searchData = queryResult.GetRange(pageSize * page, Math.Min(pageSize, queryResult.Count - pageSize * page));
            return View(searchData);
        }
        public ActionResult FAQ()
        {
            return View();
        }
        public ActionResult Cart()
        {
            return View();
        }
        /*
        public ActionResult BookInfor()
        {
            BookInforUI u = new BookInforUI();
            u.book = db.GetObject_Book();
            u.comments = db.GetObject_CommentBook(u.book.BookID);
            u.rating = 2;
            u.sold = 35;
            u.images = db.GetObject_Image(u.book.BookID);
            if (u.book == null || u.images == null)
                Response.Redirect("https://localhost:44339/User/Homepage");
            foreach(Img tmp in u.images)
            {
                tmp.ImagePath = "../Images/Book/"+tmp.ImagePath;
            }
            return View(u);
        }
        */
        public ActionResult OrderManaging()
        {
            return View();
        }
        public ActionResult DeliveryTracking()
        {
            return View();
        }
        public ActionResult Rating()
        {
            return View();
        }
        public ActionResult OrderConfirm()
        {
            return View();
        }
    }
}