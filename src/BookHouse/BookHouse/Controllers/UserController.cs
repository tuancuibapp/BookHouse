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

            /*BookOnHomepage yay = new BookOnHomepage
            {
               BookName = "My life is not a joke, jokes have meaning.",
               BookID = "1",
               Price = 100000, 
                rating = 4,
                images = "https://toplist.vn/images/800px/dac-nhan-tam-116541.jpg"
            };

            ViewData["bestSellers"] = new List<BookOnHomepage>
            { 
                yay, yay, yay, yay, yay
            };

            ViewData["foreignLiteratureBooks"] = new List<BookOnHomepage>
            {
                yay, yay, yay, yay, yay
            };

            ViewData["vietnameseLiteratureBooks"] = new List<BookOnHomepage>
            {
                yay, yay, yay, yay, yay
            };

            ViewData["historyBooks"] = new List<BookOnHomepage>
            {
                yay, yay, yay, yay, yay
            };*/

            DBIO db = new DBIO();

            HomepageUI homePagedata = db.GetObject_HomePageUI();

            ViewData["bestSellers"] = homePagedata.bestSellingBooks;

            ViewData["foreignLiteratureBooks"] = homePagedata.foreignLiteratureBooks;

            ViewData["vietnameseLiteratureBooks"] = homePagedata.vietnameseLiteratureBooks;

            ViewData["historyBooks"] = homePagedata.historyBooks;

            return View();
        }
        public ActionResult BookInfor(string bid = "00000")
        {
            BookInforUI u = db.GetObject_BookInforUI(bid);
            if(u == null)
                return Redirect(String.Concat(Request.Url.Scheme, "://", Request.Url.Host, ":44339", "/user/homepage"));
            return View(u);
        }
        [HttpPost]
        public ActionResult BookInfor(FormCollection data)
        {
            JsonResult jr = new JsonResult();
            if (Session["user"] == null)
            {
                jr.Data = new
                {
                    status = "F"
                };
                return Json(jr, JsonRequestBehavior.AllowGet);
            }
            Customer tmp = (Customer)Session["user"];
            string bid = data["bid"];
            string number = data["number"];
            if (db.SaveObject_AddToCart(bid, int.Parse(number), tmp.CustomerID))
            {
                jr.Data = new
                {
                    status = "OK",
                };
            }
            else
            {
                jr.Data = new
                {
                    status = "F"
                };
            }
            return Json(jr, JsonRequestBehavior.AllowGet);
        }
        public ActionResult SignInn()
        {
            return View();
        }
        [HttpPost]
        public ActionResult SignInn(FormCollection data)
        {
            string pN = data["pN"];
            string p = data["p"];
            JsonResult jr = new JsonResult();
            Customer u = db.GetObject_User(pN);
            if (u != null && u.Password.Contains(p))
            {
                Session["user"] = u;
                jr.Data = new
                {
                    status = "OK",
                };
            }
            else
            {
                jr.Data = new
                {
                    status = "F"
                };
            }
            return Json(jr, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult Signout()
        {
            JsonResult jr = new JsonResult();
            Session["user"] = null;
            if (Session["user"] == null)
            {
                jr.Data = new
                {
                    status = "OK",
                };
            }
            else
            {
                jr.Data = new
                {
                    status = "F"
                };
            }
            return Json(jr, JsonRequestBehavior.AllowGet);
        }
        public ActionResult SignUp()
        {
            return View();
        }
        [HttpPost]
        public ActionResult SignUp(FormCollection data)
        {
            string fN = data["fN"];
            string nN = data["nN"];
            string bD = data["bD"];
            string s = data["s"];
            string e = data["e"];
            string a = data["a"];
            string pN = data["pN"];
            string p = data["p"];
            string rP = data["rP"];
            JsonResult jr = new JsonResult();
            if (e != "123" && pN == "1")
            {
                jr.Data = new
                {
                    status = "OK"
                };
            }
            else
            {
                jr.Data = new
                {
                    status = "F"
                };
            }
            return Json(jr, JsonRequestBehavior.AllowGet);
        }
        public ActionResult _Profile()
        {
            if (Session["user"] == null)
                return Redirect(String.Concat(Request.Url.Scheme, "://", Request.Url.Host, ":44339", "/user/homepage"));
            Customer tmp = (Customer)Session["user"];
            ProfileUI u = db.GetObject_ProfileUI(tmp.CustomerID);
            return View(u);
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
            /*BookInforUI yay = new BookInforUI
            {
                book = new Book
                {
                    BookName = "My life is not a joke, jokes have meaning.",
                    BookID = "1",
                    Price = 100000
                },

                rating = 4,
                images = "https://toplist.vn/images/800px/dac-nhan-tam-116541.jpg"
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
            yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay};*/

            //get the info for the view
            int pageSize = 20;
            ViewData["Filters"] = filters;
            ViewBag.currentPage = page;

            List<BookInforUI> queryResult = db.GetObject_Searching(filters);

            int NumPage = queryResult.Count / pageSize;
            if (queryResult.Count % pageSize != 0)
                NumPage++;
            ViewBag.numPage = NumPage;
            ViewData["Query"] = Query;

            /*List<BookInforUI> searchData = queryResult.GetRange(pageSize * page, Math.Min(pageSize, queryResult.Count - pageSize * page));*/
            return View(queryResult);
        }

        [HttpPost]
        public ActionResult SearchPage(string Query, Filters filters, int page = 1)
        {
            //here is for query the books from database using filters
            /*filters.categories = new List<string> {
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
                images = "https://toplist.vn/images/800px/dac-nhan-tam-116541.jpg"
            };

            List<BookInforUI> queryResult = new List<BookInforUI>
            {yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay,
            yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay,
            yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay, yay};
*/
            //get the info for the view
            int pageSize = 20;
            ViewData["Filters"] = filters;
            ViewData["CurrentPage"] = page;

            List<BookInforUI> queryResult = db.GetObject_Searching(filters);

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
            FAQUI FAQdata = db.GetObject_FAQUI();

            /*FAQUI FAQdata = new FAQUI
            {
                faqs = new List<FAQ> 
                {
                    new FAQ { Answer = "No...", Question = "U good?", QuestionID = "1"}
                }
            };*/
            return View(FAQdata);
        }
        public ActionResult Cart()
        {
            if (Session["user"] == null)
                return Redirect(String.Concat(Request.Url.Scheme, "://", Request.Url.Host, ":44339", "/user/homepage"));
            Customer tmp = (Customer)Session["user"];
            List<BookDetailOrder> u = db.GetObject_CartUI(tmp.CustomerID);
            return View(u);
        }
        [HttpPost]
        public ActionResult CartDeleteProduct(FormCollection data)
        {
            Customer u = (Customer)Session["user"];
            if (Session["user"] == null)
                return Redirect(String.Concat(Request.Url.Scheme, "://", Request.Url.Host, ":44339", "/user/homepage"));
            string bid = data["bid"];
            JsonResult jr = new JsonResult();
            if (db.DeleteObject_CartDetail(u.CustomerID, bid))
            {
                jr.Data = new
                {
                    status = "OK",
                };
            }
            else
            {
                jr.Data = new
                {
                    status = "F"
                };
            }
            return Json(jr, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult CartUpdateProduct(FormCollection data)
        {
            if (Session["user"] == null)
                return Redirect(String.Concat(Request.Url.Scheme, "://", Request.Url.Host, ":44339", "/user/homepage"));
            string bid = data["bid"];
            string number = data["number"];
            Customer u = (Customer)Session["user"];
            JsonResult jr = new JsonResult();
            if (db.SaveObject_AddToCart(bid, int.Parse(number), u.CustomerID))
            {
                jr.Data = new
                {
                    status = "OK",
                };
            }
            else
            {
                jr.Data = new
                {
                    status = "F"
                };
            }
            return Json(jr, JsonRequestBehavior.AllowGet);
        }
        public ActionResult OrderManaging()
        {
            if (Session["user"] == null)
                return Redirect(String.Concat(Request.Url.Scheme, "://", Request.Url.Host, ":44339", "/user/homepage"));
            Customer tmp = (Customer)Session["user"];
            List<Order> u = db.GetObject_ListOrder(tmp.CustomerID);            
            return View(u);
        }
        public ActionResult DeliveryTracking()
        {
            return View();
        }
        public ActionResult DetailOrder(string oid = "00000")
        {
            if (Session["user"] == null)
                return Redirect(String.Concat(Request.Url.Scheme, "://", Request.Url.Host, ":44339", "/user/homepage"));
            Customer tmp = (Customer)Session["user"];
            DetailOrderUI u = db.GetObject_DetailOrderUI(tmp.CustomerID, oid);
            return View(u);
        }
        public ActionResult Rating(string bid = "00000")
        {
            RatingUI u = db.GetObject_RatingUI(bid);
            return View(u);
        }
        [HttpPost]
        public ActionResult Rating(FormCollection data)
        {
            JsonResult jr = new JsonResult();
            if (Session["user"] == null)
            {
                jr.Data = new
                {
                    status = "F"
                };
                return Json(jr, JsonRequestBehavior.AllowGet);
            }
            Customer tmp = (Customer)Session["user"];
            string cT = data["cT"];
            string r = data["r"];
            string bid = data["bid"];
            if (db.SaveObject_AddComment(bid, tmp.CustomerID, cT) && db.SaveObject_AddRating(bid, tmp.CustomerID, int.Parse(r)))
            {
                jr.Data = new
                {
                    status = "OK",
                };
            }
            else
            {
                jr.Data = new
                {
                    status = "F"
                };
            }
            return Json(jr, JsonRequestBehavior.AllowGet);
        }
        public ActionResult OrderConfirm(string totalPrice = "0")
        {
            Customer tmp = (Customer)Session["user"];
            ViewBag.TotalPrice = totalPrice;
            return View();
        }

        [HttpPost]
        public ActionResult OrderConfirm(DetailOrderUI details)
        {
            if (Session["user"] == null)
                return Redirect(String.Concat(Request.Url.Scheme, "://", Request.Url.Host, ":44339", "/user/homepage"));
            Customer tmp = (Customer)Session["user"];
            details.order.CustomerID = tmp.CustomerID;
            details.order.TotalPrice = 500000;
            details.order.GoodsPrice = 480000;
            if (!db.SaveObject_CreateNewOrder(details))
                RedirectToAction("HomePage");
            var oid = int.Parse(db.GetCurrentOID()).ToString();
            oid = "0" + oid;
            var oidLength = 5 - oid.Length;
            for (int i = 0; i < oidLength; i++)
            {
                oid = "0" + oid;
            }
            return RedirectToAction("DetailOrder", new { oid = oid});
        }
        public ActionResult ChangePassword()
        {
            if (Session["user"] == null)
                return Redirect(String.Concat(Request.Url.Scheme, "://", Request.Url.Host, ":44339", "/user/homepage"));
            return View();
        }
        [HttpPost]
        public JsonResult ChangePassword(FormCollection data)
        {
            string pN = data["pN"];
            string oP = data["oP"];
            string nP = data["nP"];
            string rNP = data["rNP"];
            JsonResult jr = new JsonResult();
            /*Customer u = (Customer)Session["user"];
            if(u != null && u.CustomerPhone == pN && u.Password == oP)
            {
                jr.Data = new
                {
                    status = "OK"
                };
            }
            else
            {
                jr.Data = new
                {
                    status = "F"
                };
            }*/
            if (pN == "123" && oP == "a")
            {
                jr.Data = new
                {
                    status = "OK"
                };
            }
            else
            {
                jr.Data = new
                {
                    status = "F"
                };
            }
            return Json(jr, JsonRequestBehavior.AllowGet);
        }
        public ActionResult ForgotPassword(string ePN ="")
        {
            /*if (Session["user"] == null)
               RedirectToAction("HomePage");*/
            ViewBag.ePN = ePN;
            return View();
        }
        [HttpPost]
        public ActionResult ForgotPassword(FormCollection data)
        {
            string ePN = data["ePN"];
            string otpC = data["otpC"];
            string nP = data["nP"];
            string rNP = data["rNP"];
            JsonResult jr = new JsonResult();
            if (ePN == "123" && otpC == "1")
            {
                jr.Data = new
                {
                    status = "OK"
                };
            }
            else
            {
                jr.Data = new
                {
                    status = "F"
                };
            }
            return Json(jr, JsonRequestBehavior.AllowGet);
        }
    } 
}