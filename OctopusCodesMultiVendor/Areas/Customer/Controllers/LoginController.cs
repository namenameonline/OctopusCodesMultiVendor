using OctopusCodesMultiVendor.Helpers;
using OctopusCodesMultiVendor.Models;
using OctopusCodesMultiVendor.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OctopusCodesMultiVendor.Areas.Customer.Controllers
{
    public class LoginController : Controller
    {
        private OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();
        
        public ActionResult Index()
        {
            ViewBag.redirectUrl = "";
            return View();
        }
        [HttpGet]
        public ActionResult Index(string redirectUrl)
        {
            ViewBag.redirectUrl = redirectUrl;
            return View();
        }
        [HttpPost]
        public ActionResult Process(FormCollection fc)
        {
            try
            {
                string username = fc["username"];
                string password = fc["password"];
                string redirectUrl = fc["redirectUrl"];
                var account = login(username, password);
                if (account == null)
                {
                    ViewBag.error = Resources.Customer.Invalid_Account;
                    return View("Index");
                }
                else
                {
                    if (!account.Status)
                    {
                        ViewBag.error = Resources.Customer.Pending_Account;
                        return View("Index");
                    }
                    SessionPersister.account = account;
                    if (string.IsNullOrEmpty(redirectUrl))
                        return RedirectToAction("Index", "Orders");
                    else
                        return Redirect(redirectUrl);
                }
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Login", "Process"));
            }
        }

        public ActionResult SignOut()
        {
            try
            {
                SessionPersister.account = null;
                return RedirectToAction("Index", "Login");
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Login", "SignOut"));
            }
        }

        [CustomAuthorize(Roles = "Customer")]
        [HttpGet]
        public ActionResult Profile()
        {
            try
            {
                var account = (Account)SessionPersister.account;
                account.defaultAddress = account.AccountAddresses.FirstOrDefault();
                account.accountPaymentInfo = account.AccountPaymentInfoes.FirstOrDefault();
                return View("Profile", account);
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Login", "Profile"));
            }
        }

        [CustomAuthorize(Roles = "Customer")]
        [HttpPost]
        public ActionResult Profile(Account account)
        {
            try
            {
                var loginedAccount = (Account)SessionPersister.account;
                
                var currentAccount = ocmde.Accounts.SingleOrDefault(a => a.Id == account.Id);

                if (account.Username != null && account.Username.Length > 0 && loginedAccount.Username != account.Username)
                {
                    if (Exists(account.Username))
                    {
                        ModelState.AddModelError("username", Resources.Customer.Username_exists);
                    }
                }

                if (account.Password != null && account.Password.Length != 0 && !PasswordHelper.IsValidPassword(account.Password))
                {
                    ModelState.AddModelError("Password", Resources.Vendor.Password_validate_message);
                }

                if (ModelState.IsValid)
                {
                    if (account.Password != null && account.Password.Length != 0)
                    {
                        currentAccount.Password = BCrypt.Net.BCrypt.HashPassword(account.Password);
                    }
                    currentAccount.Email = account.Email;
                    currentAccount.FullName = account.FullName;
                    currentAccount.Phone = account.Phone;
                    currentAccount.Username = account.Username;
                    
                    if(currentAccount.AccountAddresses.Count<=0)
                    {
                        AccountAddress acctAddress = account.defaultAddress;
                        acctAddress.Id = Guid.NewGuid();                       
                        currentAccount.AccountAddresses.Add(acctAddress);
                    }
                    else
                    {
                        AccountAddress acctAddressOriginal = currentAccount.AccountAddresses.FirstOrDefault();
                        AccountAddress forUpdate=ocmde.AccountAddresses.Find(acctAddressOriginal.Id);
                        forUpdate.City = account.defaultAddress.City;
                        forUpdate.LineAddress1 = account.defaultAddress.LineAddress1;
                        forUpdate.LineAddress2 = account.defaultAddress.LineAddress2;
                        forUpdate.ZipCode = account.defaultAddress.ZipCode;

                    }
                    if (currentAccount.AccountPaymentInfoes.Count <= 0)
                    {
                        AccountPaymentInfo paymentInfo = new AccountPaymentInfo();
                        paymentInfo.CreditCardNo = account.accountPaymentInfo.CreditCardNo;
                        paymentInfo.ExpiryDate = account.accountPaymentInfo.ExpiryDate;
                        paymentInfo.FullName = account.accountPaymentInfo.FullName;
                        //paymentInfo.Id = Guid.NewGuid();
                        currentAccount.AccountPaymentInfoes.Add(paymentInfo);
                    }
                    else
                    {
                        AccountPaymentInfo acctPaymentOriginal = currentAccount.AccountPaymentInfoes.FirstOrDefault();
                        acctPaymentOriginal.CreditCardNo = account.accountPaymentInfo.CreditCardNo;
                        acctPaymentOriginal.ExpiryDate = account.accountPaymentInfo.ExpiryDate;
                        acctPaymentOriginal.FullName = account.accountPaymentInfo.FullName;
                    }
                    ocmde.SaveChanges();
                    SessionPersister.account = ocmde.Accounts.Find(account.Id);
                    return RedirectToAction("Profile", "Login");
                }
                else
                {
                    return View("Profile", account);
                }
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Login", "Profile"));
            }
        }

        private bool Exists(string username)
        {
            return ocmde.Accounts.Count(a => a.Username.Equals(username)) > 0;
        }

        private Account login(string username, string password)
        {
            try
            {
                var account = ocmde.Accounts.SingleOrDefault(a => a.Username.Equals(username) && !a.IsAdmin);
                if (account != null)
                {
                    if (BCrypt.Net.BCrypt.Verify(password, account.Password) && account.Status)
                    {
                        return account;
                    }
                }
                return null;
            }
            catch
            {
                return null;
            }
        }
    }
}