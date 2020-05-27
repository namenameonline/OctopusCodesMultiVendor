using OctopusCodesMultiVendor.Helpers;
using OctopusCodesMultiVendor.Models;
using OctopusCodesMultiVendor.Models.ViewModels;
using OctopusCodesMultiVendor.Models.ViewModels.Login;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OctopusCodesMultiVendor.Controllers
{
    public class CustomersController : Controller
    {
        private OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();

        [HttpGet]
        public ActionResult Register()
        {
            try
            {
                ViewBag.cities = ocmde.RajaOngkir_CityMapping.OrderBy(b=>b.city_name).Select(a => a.city_name);
                return View("Register", new Account());
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Customers", "Register"));
            }
        }
        [HttpGet]
        public ActionResult Reset(string guid)
        {
            try
            {
                ForgetPassword pwd=ocmde.ForgetPasswords.Find(guid);
                if (pwd == null)
                {
                    ViewBag.errorMessage = "The Link can't be found";
                    return View("Reset");
                }
                return View("Reset", new ResetPasswordModel());
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Customers", "Reset"));
            }
        }
        [HttpPost]
        public ActionResult Reset(ResetPasswordModel resetPassword)
        {
            try
            {
                string email = "";
                ForgetPassword fp = ocmde.ForgetPasswords.Find(resetPassword.Id);
                if(fp==null)
                {
                    ViewBag.errorMessage = "Link can't be found";
                    return View("Reset");
                }
                Account acct = ocmde.Accounts.FirstOrDefault(a => a.Username == fp.Username);
                if (acct == null)
                {
                    ViewBag.errorMessage = "Link can't be found";
                    return View("Reset");
                }
                //successful update
                acct.Password = BCrypt.Net.BCrypt.HashPassword(resetPassword.Password);
                ocmde.ForgetPasswords.Remove(fp);
                ocmde.SaveChanges();
                ViewBag.infoMessage = "You have successfully reset your password";
                return View("Login", "Customer");
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Customers", "Register"));
            }
        }
        [HttpGet]
        public ActionResult Forget()
        {
            try
            {
                return View("Forget", new ForgetPasswordViewModel());
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Customers", "Forget"));
            }
        }
        [HttpPost]
        public ActionResult Forget(ForgetPasswordViewModel account)
        {
            try
            {
                string email = "";
                if (!string.IsNullOrEmpty(account.Email))
                {
                    email = ExistsEmail(account.Email);
                    if (string.IsNullOrEmpty(email))
                    {
                        ViewBag.errorMessage = "Invalid Account";
                        return View("Forget", account);
                    }
                }
                
                Account dbAccount = ocmde.Accounts.FirstOrDefault(a => a.Email.Equals(email));
                ocmde.ForgetPasswords.RemoveRange(ocmde.ForgetPasswords.Where(a => a.Username.Equals(dbAccount.Username)));
                ForgetPassword forgetPassword = new ForgetPassword();
                forgetPassword.Id = Guid.NewGuid();
                forgetPassword.Username = dbAccount.Username;
                ocmde.ForgetPasswords.Add(forgetPassword);
                ocmde.SaveChanges();
                string body = string.Format(SettingsHelper.Forget_Pwd_Content, SettingsHelper.BASE_URL + "/Customers/Reset/" + forgetPassword.Id.ToString());
                //string body = string.Format(ocmde.Settings.Find(22).Value, "/Customer/Reset/" + forgetPassword.Id.ToString()); ;
                //TODO:
                //Send email to the account for reset

                EmailHelper.SendEmail(SettingsHelper.Email_Sender, account.Email,SettingsHelper.Forget_Pwd_Subject, body, null);
                ViewBag.infoMessage = "Please check your email for the password reset link";
                return View("Forget", account);
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Customers", "Register"));
            }
        }

        [HttpPost]
        public ActionResult Register(Account account)
        {
            try {
                if (account.Username != null && account.Username.Length > 0)
                {
                    if (Exists(account.Username))
                    {
                        ModelState.AddModelError("username", Resources.Vendor.Username_already_exists);
                    }
                    if (!string.IsNullOrEmpty(ExistsEmail(account.Email)))
                    {
                        ModelState.AddModelError("email", Resources.Vendor.Email_already_exists);
                    }
                }

                if (account.Password != null && account.Password.Length != 0 && !PasswordHelper.IsValidPassword(account.Password))
                {
                    ModelState.AddModelError("Password", Resources.Vendor.Password_validate_message);
                }

                if (ModelState.IsValid)
                {
                    account.IsAdmin = false;
                    account.Status = false;
                    account.Password = BCrypt.Net.BCrypt.HashPassword(account.Password);
                    AccountAddress accountAddress = account.defaultAddress;
                    accountAddress.Id = Guid.NewGuid();
                    account.AccountAddresses.Add(accountAddress);                   

                    ocmde.Accounts.Add(account);

                    string body = "There is a new customer request. Please login to admin to take action";

                    EmailHelper.SendEmail(SettingsHelper.Email_Sender,SettingsHelper.Admin_Email,"New Customer Request", body, null);
                    ocmde.SaveChanges();
                    //return RedirectToAction("Index", "Login", new { Area = "Customer" });
                    return View("RegisterSuccess");
                }
                else
                {
                    ViewBag.cities = ocmde.RajaOngkir_CityMapping.OrderBy(b => b.city_name).Select(a => a.city_name);
                    return View("Register",account);
                }
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Customers", "Register"));
            }
        }
        private string ExistsAccount(string userName)
        {
            return ocmde.Accounts.FirstOrDefault(a => a.Username.Equals(userName)).Email;
        }
        private string ExistsEmail(string email)
        {
            
            Account acct = ocmde.Accounts.FirstOrDefault(a => a.Email.Equals(email));
            if(acct!=null)
               return acct.Email;
            
            return "";
            
        }
        private bool Exists(string username)
        {
            return ocmde.Accounts.Count(a => a.Username.Equals(username) && !a.IsAdmin) > 0;
        }
    }
}