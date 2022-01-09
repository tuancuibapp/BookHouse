using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DatabaseProvider.MyDB;
namespace DatabaseProvider.NewClassForUI
{
    public class OrderConfirmUI
    {
        public OrderCart order { get; set; }
        public string customerName { get; set; }
        public string customerPhone { get; set; }
        public string releaseDate { get; set; }
        public string address { get; set; }
        public string noteForOrder { get; set; }
        public string alternativeRecipientName { get; set; }
        public string alternativeRecipientPhone { get; set; }
    }
}
