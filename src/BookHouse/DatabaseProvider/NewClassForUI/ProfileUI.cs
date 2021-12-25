using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DatabaseProvider.MyDB;
namespace DatabaseProvider.NewClassForUI
{
    class ProfileUI
    {
        public Customer customer { get; set; }
        public List<OrderCart> order { get; set; }
    }
}
