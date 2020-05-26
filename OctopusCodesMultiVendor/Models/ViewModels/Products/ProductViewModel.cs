using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using OctopusCodesMultiVendor.Models;
namespace OctopusCodesMultiVendor.Models.ViewModels.Products

{
    public class ProductViewModel
    {
        public OctopusCodesMultiVendor.Models.Product product { get; set; }

        public List<SelectListItem> Categories { get; set; }

        public SelectList CategoriesMultiLevel  { get; set; }
    }
}