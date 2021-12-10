using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BookHouse.Controllers
{
    public class MenuController : Controller
    {
        // GET: Menu
        public ActionResult MainMenu()
        {
            return PartialView();
        }
        public ActionResult SubMenu()
        {
            return PartialView();
        }
    }
}