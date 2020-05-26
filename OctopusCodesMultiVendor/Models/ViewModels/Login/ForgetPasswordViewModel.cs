using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
namespace OctopusCodesMultiVendor.Models.ViewModels.Login
{
    public class ForgetPasswordViewModel
    {
        
        public string Username { get; set; }
        [EmailAddress]
        public string Email { get; set; }
    }
}