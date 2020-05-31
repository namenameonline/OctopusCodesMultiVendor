using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OctopusCodesMultiVendor.Helpers
{
    public class OrderStatusHelper
    {
        public static int PendingDelivery = 1;
        public static int Delivering = 4;
        public static int Received = 6;
        public static int PaymentDisbursed = 8;
        public static int Closed = 9;
        public static int Return = 10;
    }
}