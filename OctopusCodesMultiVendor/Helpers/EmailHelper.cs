using OctopusCodesMultiVendor.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Net.Mime;
using System.Web;

namespace OctopusCodesMultiVendor.Helpers
{
    public class EmailHelper
    {
        private static OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();
        
        public static void SendEmail(string from,string recipient, string subject,string body,string attachmentFile)
        {

            var smtpClient = new SmtpClient(ocmde.Settings.Find(15).Value)
            {
                Port = int.Parse(ocmde.Settings.Find(18).Value),
                Credentials = new NetworkCredential(ocmde.Settings.Find(16).Value, ocmde.Settings.Find(17).Value),
                EnableSsl = true,
            };
            var mailMessage = new MailMessage
            {
                From = new MailAddress(from),
                Subject = subject,
                Body = body,
                IsBodyHtml = true,
            };
            mailMessage.To.Add(recipient);
            if (!string.IsNullOrEmpty(attachmentFile))
            {
                var attachment = new Attachment(attachmentFile, MediaTypeNames.Image.Jpeg);
                mailMessage.Attachments.Add(attachment);
            }
            smtpClient.Send(mailMessage);
        }
    }
}