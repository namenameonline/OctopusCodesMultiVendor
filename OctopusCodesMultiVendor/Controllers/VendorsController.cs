using OctopusCodesMultiVendor.Models;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using OctopusCodesMultiVendor.Security;
using System.IO;
using OctopusCodesMultiVendor.Paypal;
using OctopusCodesMultiVendor.Helpers;
using System.Data.Entity.Core.Metadata.Edm;
using OctopusCodesMultiVendor.Models.ViewModels;
using OctopusCodesMultiVendor.Models.ViewModels.Messages;

namespace OctopusCodesMultiVendor.Controllers
{
    public class VendorsController : Controller
    {
        private OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();

        public ActionResult Expires()
        {
            return View("Expires");
        }

        public ActionResult Detail(int id, int page = 1, int pageSize = 9)
        {
            try
            {
                if (!VendorHelper.checkExpires(id))
                {
                    return RedirectToAction("Expires", "Vendors");
                }
                else
                {
                    pageSize = int.Parse(ocmde.Settings.Find(9).Value);
                    var vendor = ocmde.Vendors.Find(id);
                    List<Product> listProducts = vendor.Products.Where(p => p.Status).ToList();
                    PagedList<Product> model = new PagedList<Product>(listProducts, page, pageSize);
                    ViewBag.vendor = vendor;
                    VendorAddress vendorAddress = vendor.VendorAddresses.FirstOrDefault();
                    ViewBag.Address = AddressHelper.GetFullAddress( vendorAddress.LineAddress1, vendorAddress.LineAddress2 ,vendorAddress.City ,vendorAddress.ZipCode);
                    ViewBag.comments = vendor.Reviews.Where(r => r.VendorId == id).OrderByDescending(r => r.Id).ToList();
                    return View("Index", model);
                }
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Vendors", "Index"));
            }
        }

        [HttpGet]
        public ActionResult SendMessage(int id)
        {
            try
            {
                if (!VendorHelper.checkExpires(id))
                {
                    return RedirectToAction("Expires", "Vendors");
                }
                else
                {
                    if (SessionPersister.account == null)
                    {

                        return RedirectToAction("Login", "Customer", new { redirectUrl = "/Vendors/SendMessage/" + id });
                    }
                    else
                    {
                        var vendor = ocmde.Vendors.Find(id);
                        ViewBag.vendor = vendor;
                        var customer = (OctopusCodesMultiVendor.Models.Account)SessionPersister.account;
                        var messageHeader = ocmde.MessageHeaders.Where(m => m.CustomerId == customer.Id && m.VendorId==vendor.Id).FirstOrDefault();
                        if (messageHeader != null)
                        {
                            if (messageHeader.VendorId != vendor.Id)
                                return View("Error", new HandleErrorInfo(new Exception("Invalid access"), "Vendors", "SendMessage"));

                            ViewBag.messages = messageHeader.MessageDetails.OrderBy(a => a.DateCreation);
                        }
                        ViewBag.senderphoto = "no-logo.jpg";
                        ViewBag.myphoto = vendor.Logo;
                        return View("SendMessage", new MessageDetailViewModel() { SendTo = id });
                    }
                }
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Vendors", "SendMessage"));
            }
        }

        [HttpPost]
        public ActionResult SendMessage(MessageDetailViewModel message)
        {
            try
            {
                var customer = (OctopusCodesMultiVendor.Models.Account)SessionPersister.account;
                MessageHeader mh = ocmde.MessageHeaders.FirstOrDefault(a => a.CustomerId == customer.Id&&a.VendorId==message.SendTo);
                bool newconversation = false;
                if(mh==null)
                {
                    mh = new MessageHeader();
                    newconversation = true;
                    mh.MsgId = Guid.NewGuid();
                    mh.VendorId =message.SendTo;
                    mh.CustomerId = customer.Id;
                    mh.SenderType = (int)SenderType.Customer;
                }
                mh.LastMessage = message.Body;
                mh.LastUpdated = DateTime.Now;
                MessageDetail messageDetail = new MessageDetail();
                messageDetail.Id = Guid.NewGuid();
                messageDetail.DateCreation = DateTime.Now;
                messageDetail.Body = message.Body;
                messageDetail.Status = true;
                messageDetail.Sender = (int)SenderType.Customer;
                mh.MessageDetails.Add(messageDetail);
                if(newconversation)
                    ocmde.MessageHeaders.Add(mh);
                ocmde.SaveChanges();
                string body =string.Format(SettingsHelper.Cust_SendMsg_Content,customer.FullName,message.Body,
                    EncryptHelper.EncryptString(SettingsHelper.Encryption_Key, mh.VendorId.ToString())
                   
                    );
                string vendorEmail = ocmde.Vendors.Find(mh.VendorId).Email;
                EmailHelper.SendEmail(SettingsHelper.Email_Sender, vendorEmail, SettingsHelper.Cust_SendMsg_Subject, body, null);
                TempData["message"] = Resources.Vendor.messages_sent_success;
                return RedirectToAction("SendMessage");
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Vendors", "SendMessage"));
            }
        }

        [HttpGet]
        public ActionResult GiveReview(int id)
        {
            try
            {
                if (!VendorHelper.checkExpires(id))
                {
                    return RedirectToAction("Expires", "Vendors");
                }
                else
                {
                    if (SessionPersister.account == null)
                    {
                        TempData["message"] = Resources.Vendor.You_need_login;
                        return RedirectToAction("Login", "Customer");
                    }
                    else
                    {
                        var customer = (OctopusCodesMultiVendor.Models.Account)SessionPersister.account;
                        if (!checkCustomerOfVendor(customer.Id, id))
                        {
                            TempData["message"] = Resources.Vendor.You_must_be_customer;
                            return RedirectToAction("Login", "Customer");
                        }
                        else
                        {
                            ViewBag.vendor = ocmde.Vendors.Find(id);
                            return View("GiveReview", new Review() { VendorId = id });
                        }
                    }
                }
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Vendors", "GiveReview"));
            }
        }

        [HttpPost]
        public ActionResult GiveReview(Review review)
        {
            try
            {
                var customer = (OctopusCodesMultiVendor.Models.Account)SessionPersister.account;
                review.CustomerId = customer.Id;
                review.DatePost = DateTime.Now;
                ocmde.Reviews.Add(review);
                ocmde.SaveChanges();
                TempData["message"] = Resources.Vendor.Your_review_sent_to_vendor;
                return RedirectToAction("GiveReview");
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Vendors", "GiveReview"));
            }
        }

        private bool checkCustomerOfVendor(int customerId, int vendorId)
        {
            return ocmde.Orders.Count(o => o.VendorId == vendorId && o.CustomerId == customerId) > 0;
        }

        public ActionResult Category(int id, int vendorId, int page = 1, int pageSize = 9)
        {
            try
            {
                if (!VendorHelper.checkExpires(vendorId))
                {
                    return RedirectToAction("Expires", "Vendors");
                }
                else
                {
                    pageSize = int.Parse(ocmde.Settings.Find(9).Value);
                    List<Product> listProducts = ocmde.Products.Where(p => p.CategoryId == id && p.Status).ToList();
                    PagedList<Product> model = new PagedList<Product>(listProducts, page, pageSize);
                    ViewBag.category = ocmde.Categories.Find(id);
                    TempData["categoryVendorSelected"] = ocmde.Categories.Find(id).Category2.Id;
                    ViewBag.vendor = ocmde.Vendors.Find(vendorId);
                    return View("Category", model);
                }
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Vendor", "Category"));
            }
        }

        public ActionResult MemberShip()
        {
            try
            {
                ViewBag.memberships = ocmde.MemberShips.Where(m => m.Status).ToList();
                ViewBag.PayPalSubmitUrl = ocmde.Settings.Find(11).Value;
                ViewBag.PayPalUsername = ocmde.Settings.Find(12).Value;
                ViewBag.ReturnUrl = ocmde.Settings.Find(13).Value;
                return View("MemberShip");
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Vendors", "MemberShip"));
            }
        }

        [HttpGet]
        public ActionResult Register()
        {
            try
            {
                ViewBag.cities = ocmde.RajaOngkir_CityMapping.OrderBy(b => b.city_name).Select(a => a.city_name);
                return View("Register", new Vendor());
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Vendors", "Register"));
            }
        }

        [HttpPost]
        public ActionResult Register(Vendor vendor, HttpPostedFileBase logo)
        {
            try
            {
                if (vendor.Username != null && Exists(vendor.Username))
                {
                    ModelState.AddModelError("Username", Resources.Vendor.Username_already_exists);
                }

                if (vendor.Password != null && !PasswordHelper.IsValidPassword(vendor.Password))
                {
                    ModelState.AddModelError("Password", "Invalid Password");
                }

                if (logo != null && logo.ContentLength > 0 && !logo.ContentType.Contains("image"))
                {
                    ViewBag.errorPhoto = Resources.Vendor.Photo_Invalid;
                    return View("Register", vendor);
                }

                if (ModelState.IsValid)
                {
                    vendor.Password = BCrypt.Net.BCrypt.HashPassword(vendor.Password);
                    vendor.Status = false;
                    if (logo != null && logo.ContentLength > 0 && logo.ContentType.Contains("image"))
                    {
                        var fileName = DateTime.Now.ToString("yyyyMMddHHmmssfff") + Path.GetFileName(logo.FileName);
                        logo.SaveAs(Path.Combine(Server.MapPath("~/Content/User/Images"), fileName));
                        vendor.Logo = fileName;
                    }
                    else
                    {
                        vendor.Logo = "no-logo.jpg";
                    }
                    VendorAddress vAddr = vendor.defaultAddress;
                    vAddr.Id = Guid.NewGuid();
                    vendor.VendorAddresses.Add(vAddr);
                    ocmde.Vendors.Add(vendor);

                    // Add Package Trial to new vendor
                    var membership = ocmde.MemberShips.Find(MemberShipHelper.TrialPackage);
                    MemberShipVendor memberShipVendor = new MemberShipVendor()
                    {
                        MemerShipId = membership.Id,
                        VendorId = vendor.Id,
                        Price = membership.Price,
                        StartDate = DateTime.Now,
                        EndDate = DateTime.Now.AddMonths(membership.Month)
                    };
                    ocmde.MemberShipVendors.Add(memberShipVendor);
                    string body = "There is a new vendor request. Please login to admin to take action";

                    EmailHelper.SendEmail(SettingsHelper.Email_Sender, SettingsHelper.Admin_Email, "New Vendor Request", body, null);
                    ocmde.SaveChanges();
                    return View("RegisterSuccess");
                    //return RedirectToAction("Index", "Login", new { Area = "Vendor" });
                }
                ViewBag.cities = ocmde.RajaOngkir_CityMapping.OrderBy(b => b.city_name).Select(a => a.city_name);
                return View("Register", vendor);
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Vendors", "Register"));
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

        public ActionResult Success()
        {
            try
            {
                var result = PDTHolder.Success(Request.QueryString.Get("tx"));
                if (result != null)
                {
                    var membership = ocmde.MemberShips.Find(result.MemberShipId);
                    var vendor = (OctopusCodesMultiVendor.Models.Vendor)SessionPersister.account;
                    MemberShipVendor memberShipVendor = new MemberShipVendor()
                    {
                        MemerShipId = membership.Id,
                        VendorId = vendor.Id,
                        Price = membership.Price,
                        StartDate = DateTime.Now,
                        EndDate = DateTime.Now.AddMonths(membership.Month)
                    };
                    ocmde.MemberShipVendors.Add(memberShipVendor);
                    ocmde.SaveChanges();
                    ViewBag.msg = "Success";
                }
                else
                {
                    ViewBag.msg = "Error";
                }
                return View("Success");
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Vendors", "Success"));
            }
        }

    }
}