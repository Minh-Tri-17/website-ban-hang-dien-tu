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
    public class THONG_TIN_SAN_PHAMController : Controller
    {
        private DATTEntities db = new DATTEntities();

        // GET: Admin/THONG_TIN_SAN_PHAM
        public ActionResult Index()
        {
            return View(db.THONG_TIN_SAN_PHAM.ToList());
        }

        // GET: Admin/THONG_TIN_SAN_PHAM/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            THONG_TIN_SAN_PHAM tHONG_TIN_SAN_PHAM = db.THONG_TIN_SAN_PHAM.Find(id);
            if (tHONG_TIN_SAN_PHAM == null)
            {
                return HttpNotFound();
            }
            return View(tHONG_TIN_SAN_PHAM);
        }

        // GET: Admin/THONG_TIN_SAN_PHAM/Create
        public ActionResult Create()
        {
            ViewBag.ID_SP = new SelectList(db.SAN_PHAM, "ID_SP", "TEN_SAN_PHAM");
            return View();
        }

        // POST: Admin/THONG_TIN_SAN_PHAM/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID_TTSP,ID_SP,XUAT_XU,KICH_THUOC,CONG_NGHE_MAN_HINH,CAMERA_SAU,CAMERA_TRUOC,CHIP,RAM,BO_NHO,PIN,THE_SIM,HE_DIEU_HANH,DO_PHAN_GIAI,TAN_SO_QUET,GPU,CONG,HO_TRO_MANG,WI_FI,BLUETOOTH,KICH_THUOC_MAN_HINH,TRONG_LUONG,CHAT_LIEU,CAM_BIEN_VAN_TAY,TINH_NANG_DAC_BIET,SO_KHE_RAM,THOI_DIEM_RA_MAT")] THONG_TIN_SAN_PHAM tHONG_TIN_SAN_PHAM)
        {
            if (ModelState.IsValid)
            {
                db.THONG_TIN_SAN_PHAM.Add(tHONG_TIN_SAN_PHAM);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.ID_SP = new SelectList(db.SAN_PHAM, "ID_SP", "TEN_SAN_PHAM");
            return View(tHONG_TIN_SAN_PHAM);
        }

        // GET: Admin/THONG_TIN_SAN_PHAM/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            THONG_TIN_SAN_PHAM tHONG_TIN_SAN_PHAM = db.THONG_TIN_SAN_PHAM.Find(id);
            if (tHONG_TIN_SAN_PHAM == null)
            {
                return HttpNotFound();
            }
            ViewBag.ID_SP = new SelectList(db.SAN_PHAM, "ID_SP", "TEN_SAN_PHAM");
            return View(tHONG_TIN_SAN_PHAM);
        }

        // POST: Admin/THONG_TIN_SAN_PHAM/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID_TTSP,ID_SP,XUAT_XU,KICH_THUOC,CONG_NGHE_MAN_HINH,CAMERA_SAU,CAMERA_TRUOC,CHIP,RAM,BO_NHO,PIN,THE_SIM,HE_DIEU_HANH,DO_PHAN_GIAI,TAN_SO_QUET,GPU,CONG,HO_TRO_MANG,WI_FI,BLUETOOTH,KICH_THUOC_MAN_HINH,TRONG_LUONG,CHAT_LIEU,CAM_BIEN_VAN_TAY,TINH_NANG_DAC_BIET,SO_KHE_RAM,THOI_DIEM_RA_MAT")] THONG_TIN_SAN_PHAM tHONG_TIN_SAN_PHAM)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tHONG_TIN_SAN_PHAM).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.ID_SP = new SelectList(db.SAN_PHAM, "ID_SP", "TEN_SAN_PHAM");
            return View(tHONG_TIN_SAN_PHAM);
        }

        // GET: Admin/THONG_TIN_SAN_PHAM/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            THONG_TIN_SAN_PHAM tHONG_TIN_SAN_PHAM = db.THONG_TIN_SAN_PHAM.Find(id);
            if (tHONG_TIN_SAN_PHAM == null)
            {
                return HttpNotFound();
            }
            return View(tHONG_TIN_SAN_PHAM);
        }

        // POST: Admin/THONG_TIN_SAN_PHAM/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            THONG_TIN_SAN_PHAM tHONG_TIN_SAN_PHAM = db.THONG_TIN_SAN_PHAM.Find(id);
            db.THONG_TIN_SAN_PHAM.Remove(tHONG_TIN_SAN_PHAM);
            db.SaveChanges();
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
