using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using DATT.DAL;

namespace DATT.Areas.Admin.Controllers
{
    public class CHI_TIET_HOA_DONController : Controller
    {
        private DATTEntities db = new DATTEntities();

        // GET: Admin/CHI_TIET_HOA_DON
        public ActionResult Index()
        {
            var cHI_TIET_HOA_DON = db.CHI_TIET_HOA_DON.Include(c => c.TAI_KHOAN).Include(c => c.CHI_NHANH).Include(c => c.KHACH_HANG).Include(c => c.HOA_DON).Include(c => c.SAN_PHAM).Where(c=>c.TRANG_THAI == "true");
            return View(cHI_TIET_HOA_DON.ToList());
        }

        // GET: Admin/CHI_TIET_HOA_DON/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CHI_TIET_HOA_DON cHI_TIET_HOA_DON = db.CHI_TIET_HOA_DON.Find(id);
            if (cHI_TIET_HOA_DON == null)
            {
                return HttpNotFound();
            }
            return View(cHI_TIET_HOA_DON);
        }

        public ActionResult Edit(int id)
        {
            db.CAP_NHAT_GIAO_HANG(id);
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
