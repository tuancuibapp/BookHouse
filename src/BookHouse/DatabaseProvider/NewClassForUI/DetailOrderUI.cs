using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DatabaseProvider.MyDB;
namespace DatabaseProvider.NewClassForUI
{
    public class DetailOrderUI
    {
        public OrderCart order { get; set; }
        public Customer customer { get; set; }
        public List<BookDetailOrder> bookDetailOrder { get; set; }
    }
}
