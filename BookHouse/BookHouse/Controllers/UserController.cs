using DatabaseIO;
using DatabaseProvider;
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
        public ActionResult SignIn()
        {
            DBIO db = new DBIO();
            TVLT_Users u = db.GetObject_User("khoa", "123");
            return View(u);
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
            return View();
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