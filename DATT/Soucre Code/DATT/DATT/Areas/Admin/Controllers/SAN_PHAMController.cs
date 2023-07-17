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
    public class SAN_PHAMController : Controller
    {
        private DATTEntities db = new DATTEntities();

        // GET: Admin/SAN_PHAM
        public ActionResult Index()
        {
            var sAN_PHAM = db.SAN_PHAM.Include(s => s.THONG_TIN_SAN_PHAM);
            return View(sAN_PHAM.ToList());
        }

        // GET: Admin/SAN_PHAM/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SAN_PHAM sAN_PHAM = db.SAN_PHAM.Find(id);
            if (sAN_PHAM == null)
            {
                return HttpNotFound();
            }
            return View(sAN_PHAM);
        }

        // GET: Admin/SAN_PHAM/Create
        public ActionResult Create()
        {
            ViewBag.loadTH = new SelectList(db.SAN_PHAM.Select(s=>s.THUONG_HIEU).Distinct().ToList());
            ViewBag.loadDM = new SelectList(db.SAN_PHAM.Select(s => s.DANH_MUC).Distinct().ToList());
            return View();
        }

        // POST: Admin/SAN_PHAM/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID_SP,ID_TTSP,THUONG_HIEU,DANH_MUC,TEN_SAN_PHAM,THONG_TIN_TONG_QUAT,GIA,ANH,GIAM_GIA,SO_LUONG_TON,TINH_TRANG_TON_KHO")] SAN_PHAM sAN_PHAM)
        {
            if (ModelState.IsValid)
            {
                db.SAN_PHAM.Add(sAN_PHAM);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.loadTH = new SelectList(db.SAN_PHAM.Select(s => s.THUONG_HIEU).Distinct().ToList());
            ViewBag.loadDM = new SelectList(db.SAN_PHAM.Select(s => s.DANH_MUC).Distinct().ToList());
            return View(sAN_PHAM);
        }

        // GET: Admin/SAN_PHAM/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SAN_PHAM sAN_PHAM = db.SAN_PHAM.Find(id);
            if (sAN_PHAM == null)
            {
                return HttpNotFound();
            }
            ViewBag.loadTH = new SelectList(db.SAN_PHAM.Select(s => s.THUONG_HIEU).Distinct().ToList());
            ViewBag.loadDM = new SelectList(db.SAN_PHAM.Select(s => s.DANH_MUC).Distinct().ToList());
            return View(sAN_PHAM);
        }

        // POST: Admin/SAN_PHAM/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID_SP,ID_TTSP,THUONG_HIEU,DANH_MUC,TEN_SAN_PHAM,THONG_TIN_TONG_QUAT,GIA,ANH,GIAM_GIA,SO_LUONG_TON,TINH_TRANG_TON_KHO")] SAN_PHAM sAN_PHAM)
        {
            if (ModelState.IsValid)
            {
                db.Entry(sAN_PHAM).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.loadTH = new SelectList(db.SAN_PHAM.Select(s => s.THUONG_HIEU).Distinct().ToList());
            ViewBag.loadDM = new SelectList(db.SAN_PHAM.Select(s => s.DANH_MUC).Distinct().ToList());
            return View(sAN_PHAM);
        }

        // GET: Admin/SAN_PHAM/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SAN_PHAM sAN_PHAM = db.SAN_PHAM.Find(id);
            if (sAN_PHAM == null)
            {
                return HttpNotFound();
            }
            return View(sAN_PHAM);
        }

        // POST: Admin/SAN_PHAM/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            SAN_PHAM sAN_PHAM = db.SAN_PHAM.Find(id);
            db.SAN_PHAM.Remove(sAN_PHAM);
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
