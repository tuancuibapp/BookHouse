using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DatabaseProvider.MyDB;
namespace DatabaseProvider.NewClassForUI
{
    public class ProfileUI
    {
        public Customer customer { get; set; }
        public List<Order> order { get; set; }
    }
}
