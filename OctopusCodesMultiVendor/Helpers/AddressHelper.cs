using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OctopusCodesMultiVendor.Helpers
{
    public class AddressHelper
    {
        public static string GetFullAddress(string addressLine1, string addressLine2, string city, string zipCode)
        {
            return addressLine1 + "<br>" + addressLine2 + "<br>" + city + "<br>" + zipCode;
        }
    }
}