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
    public class KHACH_HANGController : Controller
    {
        private DATTEntities db = new DATTEntities();

        // GET: Admin/KHACH_HANG
        public ActionResult Index()
        {
            return View(db.KHACH_HANG.ToList());
        }

        // GET: Admin/KHACH_HANG/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            KHACH_HANG kHACH_HANG = db.KHACH_HANG.Find(id);
            if (kHACH_HANG == null)
            {
                return HttpNotFound();
            }
            return View(kHACH_HANG);
        }

        // GET: Admin/KHACH_HANG/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/KHACH_HANG/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID_KH,TEN_KHACH_HANG,DIA_CHI,SDT,EMAIL")] KHACH_HANG kHACH_HANG)
        {
            if (ModelState.IsValid)
            {
                db.KHACH_HANG.Add(kHACH_HANG);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(kHACH_HANG);
        }

        // GET: Admin/KHACH_HANG/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            KHACH_HANG kHACH_HANG = db.KHACH_HANG.Find(id);
            if (kHACH_HANG == null)
            {
                return HttpNotFound();
            }
            return View(kHACH_HANG);
        }

        // POST: Admin/KHACH_HANG/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID_KH,TEN_KHACH_HANG,DIA_CHI,SDT,EMAIL")] KHACH_HANG kHACH_HANG)
        {
            if (ModelState.IsValid)
            {
                db.Entry(kHACH_HANG).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(kHACH_HANG);
        }

        // GET: Admin/KHACH_HANG/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            KHACH_HANG kHACH_HANG = db.KHACH_HANG.Find(id);
            if (kHACH_HANG == null)
            {
                return HttpNotFound();
            }
            return View(kHACH_HANG);
        }

        // POST: Admin/KHACH_HANG/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            KHACH_HANG kHACH_HANG = db.KHACH_HANG.Find(id);
            db.KHACH_HANG.Remove(kHACH_HANG);
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
