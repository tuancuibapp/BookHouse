using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DatabaseProvider.MyDB;
namespace DatabaseProvider.NewClassForUI
{
    public class CartUI
    {
        public string bookName { get; set; }
        public int quantity { get; set; }
        public float price { get; set; }
    }
}
