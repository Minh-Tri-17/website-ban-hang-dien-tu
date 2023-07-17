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
    public class DANH_GIAController : Controller
    {
        private DATTEntities db = new DATTEntities();

        // GET: Admin/DANH_GIA
        public ActionResult Index()
        {
            var dANH_GIAs = db.DANH_GIAs.Include(d => d.TAI_KHOAN).Include(d => d.SAN_PHAM);
            return View(dANH_GIAs.ToList());
        }

        // GET: Admin/DANH_GIA/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DANH_GIA dANH_GIA = db.DANH_GIAs.Find(id);
            if (dANH_GIA == null)
            {
                return HttpNotFound();
            }
            return View(dANH_GIA);
        }

        // GET: Admin/DANH_GIA/Create
        public ActionResult Create()
        {
            ViewBag.ID_ACC = new SelectList(db.TAI_KHOAN, "ID_ACC", "TEN_TAI_KHOAN");
            ViewBag.ID_SP = new SelectList(db.SAN_PHAM, "ID_SP", "THUONG_HIEU");
            return View();
        }

        // POST: Admin/DANH_GIA/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID_DG,ID_SP,DIEM,NOI_DUNG,KIEM_TRA,ID_ACC")] DANH_GIA dANH_GIA)
        {
            if (ModelState.IsValid)
            {
                db.DANH_GIAs.Add(dANH_GIA);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.ID_ACC = new SelectList(db.TAI_KHOAN, "ID_ACC", "USERNAME", dANH_GIA.ID_ACC);
            ViewBag.ID_SP = new SelectList(db.SAN_PHAM, "ID_SP", "THUONG_HIEU", dANH_GIA.ID_SP);
            return View(dANH_GIA);
        }

        // GET: Admin/DANH_GIA/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DANH_GIA dANH_GIA = db.DANH_GIAs.Find(id);
            if (dANH_GIA == null)
            {
                return HttpNotFound();
            }
            ViewBag.ID_ACC = new SelectList(db.TAI_KHOAN, "ID_ACC", "USERNAME", dANH_GIA.ID_ACC);
            ViewBag.ID_SP = new SelectList(db.SAN_PHAM, "ID_SP", "THUONG_HIEU", dANH_GIA.ID_SP);
            return View(dANH_GIA);
        }

        // POST: Admin/DANH_GIA/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID_DG,ID_SP,DIEM,NOI_DUNG,KIEM_TRA,ID_ACC")] DANH_GIA dANH_GIA)
        {
            if (ModelState.IsValid)
            {
                db.Entry(dANH_GIA).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.ID_ACC = new SelectList(db.TAI_KHOAN, "ID_ACC", "USERNAME", dANH_GIA.ID_ACC);
            ViewBag.ID_SP = new SelectList(db.SAN_PHAM, "ID_SP", "THUONG_HIEU", dANH_GIA.ID_SP);
            return View(dANH_GIA);
        }

        // GET: Admin/DANH_GIA/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DANH_GIA dANH_GIA = db.DANH_GIAs.Find(id);
            if (dANH_GIA == null)
            {
                return HttpNotFound();
            }
            return View(dANH_GIA);
        }

        // POST: Admin/DANH_GIA/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            DANH_GIA dANH_GIA = db.DANH_GIAs.Find(id);
            db.DANH_GIAs.Remove(dANH_GIA);
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
