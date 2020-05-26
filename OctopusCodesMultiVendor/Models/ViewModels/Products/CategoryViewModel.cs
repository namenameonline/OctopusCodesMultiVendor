using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OctopusCodesMultiVendor.Models.ViewModels.Products
{
    public class CategoryViewModel
    {
        public Category category { get; set; }

        public List<SelectListItem> Parent { get; set; }
    }
}