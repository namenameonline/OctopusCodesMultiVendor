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

            var smtpClient = new SmtpClient(SettingsHelper.SMTP_HOST)
            {
                Port = int.Parse(SettingsHelper.SMTP_PORT),
                Credentials = new NetworkCredential(SettingsHelper.SMTP_USER, SettingsHelper.SMTP_PASSWORD),
                EnableSsl = bool.Parse(SettingsHelper.SMTP_ENABLE_SSL)
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