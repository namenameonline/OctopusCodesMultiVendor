using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OctopusCodesMultiVendor.Helpers
{
    public class HttpUrlHelper
    {
        public static string GetBaseURL(HttpRequestBase Request,UrlHelper Url)
        {
            return string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
        }
    }
}