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
        public ActionResult SearchPage()
        {
<<<<<<< Updated upstream
            return View();
=======
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
                sortInc = false,
                sortDec = false,
                priceRange = new List<int>{ -1, -1 },
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
            List<BookInforUI> u = new List<BookInforUI>;
            return View(u);
>>>>>>> Stashed changes
        }
        public ActionResult FAQ()
        {
            return View();
        }
        public ActionResult Cart()
        {
            return View();
        }
        public ActionResult ProductInfor()
        {
            return View();
        }
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