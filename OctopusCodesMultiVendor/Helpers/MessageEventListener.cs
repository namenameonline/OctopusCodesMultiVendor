using OctopusCodesMultiVendor.Helpers.Interface;
using OctopusCodesMultiVendor.Models;
using RestSharp.Extensions;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using TableDependency.SqlClient;
using TableDependency.SqlClient.Base;
using TableDependency.SqlClient.Base.Abstracts;
using TableDependency.SqlClient.Base.EventArgs;
using TableDependency.SqlClient.Where;

namespace OctopusCodesMultiVendor.Helpers
{
    public class MessageEventListener
    {
        string connectionString;
        MessageEvents messageEventHandler;
        Guid filterMessageId;
        public void Initialize(OctopusCodesMultiVendorsEntities entity,MessageEvents handler, Guid msgId)
        {
            // The mapper object is used to map model properties 
            // that do not have a corresponding table column name.
            // In case all properties of your model have same name 
            // of table columns, you can avoid to use the mapper.
            var mapper = new ModelToTableMapper<MessageDetail>();
            mapper.AddMapping(c => c.Id, "Id");
            mapper.AddMapping(c => c.Body, "Body");
            mapper.AddMapping(c => c.MessageHeaderId, "MessageHeaderId");
            mapper.AddMapping(c => c.DateCreation, "DateCreation");
            string connectionString = ConfigurationManager.ConnectionStrings["OctopusCodesMultiVendorsEntities"].ConnectionString;

            Expression<Func<MessageDetail, bool>> expression = p =>
            (p.MessageHeaderId==filterMessageId);
            ITableDependencyFilter whereCondition = new SqlTableDependencyFilter<MessageDetail>(
               expression,
               mapper);
            SqlTableDependency<MessageDetail> dep = new SqlTableDependency<MessageDetail>(connectionString, "MessageDetail", mapper: mapper, whereCondition);
                filterMessageId = msgId;


                dep.OnChanged += Changed;
                dep.Start();
                dep.Stop();
                 
        }
        public void Changed(object sender, RecordChangedEventArgs<MessageDetail> e)
        {
            var changedEntity = e.Entity;
            if(e.ChangeType==TableDependency.SqlClient.Base.Enums.ChangeType.Insert)
                messageEventHandler.OnNewMessageReceived(changedEntity.DateCreation,changedEntity.Body,changedEntity.Sender);
        }
    }