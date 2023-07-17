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
    public class CHI_NHANHController : Controller
    {
        private DATTEntities db = new DATTEntities();

        // GET: Admin/CHI_NHANH
        public ActionResult Index()
        {
            return View(db.CHI_NHANH.ToList());
        }

        // GET: Admin/CHI_NHANH/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CHI_NHANH cHI_NHANH = db.CHI_NHANH.Find(id);
            if (cHI_NHANH == null)
            {
                return HttpNotFound();
            }
            return View(cHI_NHANH);
        }

        // GET: Admin/CHI_NHANH/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/CHI_NHANH/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
       
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID_CN,TEN_CHI_NHANH,DIA_CHI,SDT")] CHI_NHANH cHI_NHANH)
        {
            if (ModelState.IsValid)
            {
                db.CHI_NHANH.Add(cHI_NHANH);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(cHI_NHANH);
        }

        // GET: Admin/CHI_NHANH/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CHI_NHANH cHI_NHANH = db.CHI_NHANH.Find(id);
            if (cHI_NHANH == null)
            {
                return HttpNotFound();
            }
            return View(cHI_NHANH);
        }

        // POST: Admin/CHI_NHANH/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID_CN,TEN_CHI_NHANH,DIA_CHI,SDT")] CHI_NHANH cHI_NHANH)
        {
            if (ModelState.IsValid)
            {
                db.Entry(cHI_NHANH).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(cHI_NHANH);
        }

        // GET: Admin/CHI_NHANH/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CHI_NHANH cHI_NHANH = db.CHI_NHANH.Find(id);
            if (cHI_NHANH == null)
            {
                return HttpNotFound();
            }
            return View(cHI_NHANH);
        }

        // POST: Admin/CHI_NHANH/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            CHI_NHANH cHI_NHANH = db.CHI_NHANH.Find(id);
            db.CHI_NHANH.Remove(cHI_NHANH);
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
