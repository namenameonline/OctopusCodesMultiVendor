using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OctopusCodesMultiVendor.Models.ViewModels
{
    public class CategoryViewModel
    {
        public Category category { get; set; }

        public List<SelectListItem> Parent { get; set; }
    }
}