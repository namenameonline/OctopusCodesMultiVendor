using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using OctopusCodesMultiVendor.Models;
using OctopusCodesMultiVendor.Security;
using System.IO;
using OctopusCodesMultiVendor.Helpers;

namespace OctopusCodesMultiVendor.Areas.Vendor.Controllers
{
    public class LoginController : Controller
    {
        private OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();

        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Process(FormCollection fc, string emailGoogle = "")
        {
            try
            {

                // CHECK EMAIL GOOGLE & FB
                if (!string.IsNullOrEmpty(emailGoogle))
                {
                    object result = null;


                    var emailVendor = CheckEmail(emailGoogle);

                    if (emailVendor == null)
                    {
                        ViewBag.error = Resources.Customer.Invalid_Account;
                        result = new { error = 1 };

                        return Json(result, JsonRequestBehavior.AllowGet);
                    }
                    else
                    {
                        if (!emailVendor.Status)
                        {
                            ViewBag.error = Resources.Customer.Pending_Account;
                            result = new { error = 2 };

                            return Json(result, JsonRequestBehavior.AllowGet);
                        }

                        SessionPersister.account = emailVendor;

                        result = new { error = 0 };

                        return Json(result, JsonRequestBehavior.AllowGet);
                    }
                }


                string username = fc["username"];
                string password = fc["password"];
                var vendor = login(username, password);
                if (vendor == null)
                {
                    ViewBag.error = Resources.Customer.Invalid_Account;
                    return View("Index");
                }
                else
                {
                    if(!vendor.Status)
                    {
                        ViewBag.error = Resources.Customer.Pending_Account;
                        return View("Index");
                    }    
                    SessionPersister.account = vendor;
                    return RedirectToAction("Index", "Category");
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

        [CustomAuthorize(Roles = "Vendor")]
        [HttpGet]
        public ActionResult Profile()
        {
            try
            {
                var vendor = (OctopusCodesMultiVendor.Models.Vendor)SessionPersister.account;
                vendor.defaultAddress = vendor.VendorAddresses.FirstOrDefault();
                vendor.vendorPaymentInfo = vendor.VendorPaymentInfoes.FirstOrDefault();
                ViewBag.cities = ocmde.RajaOngkir_CityMapping.OrderBy(b => b.city_name).Select(a => a.city_name);
                return View("Profile", vendor);
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Login", "Profile"));
            }
        }

        [CustomAuthorize(Roles = "Vendor")]
        [HttpPost]
        public ActionResult Profile(OctopusCodesMultiVendor.Models.Vendor vendor, HttpPostedFileBase logo)
        {
            try
            {
                var loginedAccount = (OctopusCodesMultiVendor.Models.Vendor)SessionPersister.account;
                
                var currentVendor = ocmde.Vendors.SingleOrDefault(a => a.Id == vendor.Id);

                if (vendor.Username != null && vendor.Username.Length > 0 && loginedAccount.Username != vendor.Username)
                {
                    if (Exists(vendor.Username))
                    {
                        ModelState.AddModelError("username", Resources.Customer.Username_exists);
                    }
                }

                if (vendor.Password != null && vendor.Password.Length != 0 && !PasswordHelper.IsValidPassword(vendor.Password))
                {
                    ModelState.AddModelError("Password", Resources.Vendor.Password_validate_message);
                }

                if (logo != null && logo.ContentLength > 0 && !logo.ContentType.Contains("image"))
                {
                    ViewBag.errorPhoto = Resources.Vendor.Photo_Invalid;
                    return View("Profile", loginedAccount);
                }

                if (ModelState.IsValid)
                {
                    if (vendor.Password != null && vendor.Password.Length != 0)
                    {
                        currentVendor.Password = BCrypt.Net.BCrypt.HashPassword(vendor.Password);
                    }

                    if (logo != null && logo.ContentLength > 0 && logo.ContentType.Contains("image"))
                    {
                        logo.SaveAs(Path.Combine(Server.MapPath("~/Content/User/Images"), Path.GetFileName(logo.FileName)));
                        currentVendor.Logo = Path.GetFileName(logo.FileName);
                    }
                    
                    currentVendor.Email = vendor.Email;
                    currentVendor.Name = vendor.Name;
                    currentVendor.Phone = vendor.Phone;
                    currentVendor.Username = vendor.Username;
                    if (currentVendor.VendorAddresses.Count <= 0)
                    {
                        VendorAddress acctAddress = vendor.defaultAddress;
                        acctAddress.Id = Guid.NewGuid();
                        currentVendor.VendorAddresses.Add(acctAddress);
                    }
                    else
                    {
                        VendorAddress acctAddressOriginal = currentVendor.VendorAddresses.FirstOrDefault();
                        acctAddressOriginal.LineAddress1 = vendor.defaultAddress.LineAddress1;
                        acctAddressOriginal.LineAddress2 = vendor.defaultAddress.LineAddress2;
                        acctAddressOriginal.City = vendor.defaultAddress.City;
                        acctAddressOriginal.ZipCode = vendor.defaultAddress.ZipCode;
                    }

                    if (currentVendor.VendorPaymentInfoes.Count <= 0)
                    {
                        VendorPaymentInfo paymentInfo = new VendorPaymentInfo();
                        paymentInfo.Id = Guid.NewGuid();
                        paymentInfo.AccountNo = vendor.vendorPaymentInfo.AccountNo;
                        paymentInfo.Bank = vendor.vendorPaymentInfo.Bank;
                        paymentInfo.Name = vendor.vendorPaymentInfo.Name;
                        paymentInfo.VendorId = vendor.Id;
                        currentVendor.VendorPaymentInfoes.Add(paymentInfo);
                        currentVendor.BankStatus = false;
                    }
                    else
                    {
                        bool isChanged = false;
                        VendorPaymentInfo acctPaymentOriginal = currentVendor.VendorPaymentInfoes.FirstOrDefault();
                        if (acctPaymentOriginal.AccountNo!=vendor.vendorPaymentInfo.AccountNo|| acctPaymentOriginal.Bank!= vendor.vendorPaymentInfo.Bank
                            || acctPaymentOriginal.Name != vendor.vendorPaymentInfo.Name)
                            isChanged = true;

                            acctPaymentOriginal.AccountNo = vendor.vendorPaymentInfo.AccountNo;
                            acctPaymentOriginal.Bank = vendor.vendorPaymentInfo.Bank;
                            acctPaymentOriginal.Name = vendor.vendorPaymentInfo.Name;
                            if (isChanged)
                            {
                                currentVendor.BankStatus = false;
                                string body = string.Format("Vendor:{0} requested to update bank account. Please login to admin to take action",currentVendor.Username);

                                EmailHelper.SendEmail(SettingsHelper.Email_Sender, SettingsHelper.Admin_Email, "Vendor Update Bank Account Request", body, null);
                                ocmde.SaveChanges();
                            }
                        }
                        
                    
                    ocmde.SaveChanges();
                    SessionPersister.account = ocmde.Vendors.Find(vendor.Id);
                    return RedirectToAction("Profile", "Login");
                }
                else
                {
                    return View("Profile", vendor);
                }
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Login", "Profile"));
            }
        }

        private bool Exists(string username)
        {
            try
            {
                return ocmde.Vendors.Count(a => a.Username.Equals(username)) > 0;
            }
            catch
            {
                return false;
            }
        }

        private OctopusCodesMultiVendor.Models.Vendor login(string username, string password)
        {
            try
            {
                var vendor = ocmde.Vendors.SingleOrDefault(v => v.Username.Equals(username));
                if (vendor != null)
                {
                    if (BCrypt.Net.BCrypt.Verify(password, vendor.Password) && vendor.Status)
                    {                        

                        return vendor;
                    }
                }
                return null;
            }
            catch
            {
                return null;
            }
        }

        private OctopusCodesMultiVendor.Models.Vendor CheckEmail(string email)
        {
            try
            {
                var vendor = ocmde.Vendors.SingleOrDefault(a => a.Email.Equals(email) && a.Status.Equals(true));

                if (vendor != null)
                    return vendor;

                return null;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

    }
}