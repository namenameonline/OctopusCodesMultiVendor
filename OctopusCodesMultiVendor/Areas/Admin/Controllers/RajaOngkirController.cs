using OctopusCodesMultiVendor.Models;
using OctopusCodesMultiVendor.Models.ViewModels;
using OctopusCodesMultiVendor.Models.ViewModels.Json;
using OctopusCodesMultiVendor.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net.Sockets;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace OctopusCodesMultiVendor.Areas.Admin.Controllers
{
    [CustomAuthorize(Roles = "Admin")]
    public class RajaOngkirController : Controller
    {
        private OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();
        // GET: Admin/RajaOngkir
        public async Task<ActionResult> Index()
        {
            client.BaseAddress = new Uri(ocmde.Settings.Find(20).Value);
            client.DefaultRequestHeaders.Accept.Clear();
            client.DefaultRequestHeaders.Accept.Add(
                new MediaTypeWithQualityHeaderValue("application/json"));
            client.DefaultRequestHeaders.Add("key", ocmde.Settings.Find(19).Value);
            RajaOngkirCityListJson rajaJson= await GetCitiesList("/starter/city");
            
            foreach(Result rst in rajaJson.Rajaongkir.Results)
            {
                if (rst.Type == RajaOngkirCityTypeEnum.Kota)
                {
                    RajaOngkir_CityMapping cityMapping = new RajaOngkir_CityMapping();
                    cityMapping.Id = Guid.NewGuid();
                    cityMapping.postal_code = rst.PostalCode;
                    cityMapping.city_id = rst.CityId;
                    cityMapping.city_name = rst.CityName;
                    cityMapping.province = rst.Province;
                    cityMapping.province_id = rst.ProvinceId;
                    cityMapping.type = rst.Type.ToString();
                    ocmde.RajaOngkir_CityMapping.Add(cityMapping);
                }
                ocmde.SaveChanges();
            }
            ViewBag.infoMessage = "Ok";
            return View();
        }
        HttpClient client = new HttpClient();
        async Task<RajaOngkirCityListJson> GetCitiesList(string path)
        {
            RajaOngkirCityListJson product = null;
            HttpResponseMessage response = await client.GetAsync(path);
            if (response.IsSuccessStatusCode)
            {
                product = await response.Content.ReadAsAsync<RajaOngkirCityListJson>();
            }
            return product;
        }

       
    }
}