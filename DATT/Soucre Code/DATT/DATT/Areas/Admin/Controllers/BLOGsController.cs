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
    public class BLOGsController : Controller
    {
        private DATTEntities db = new DATTEntities();

        // GET: Admin/BLOGs
        public ActionResult Index()
        {
            var bLOGs = db.TIN_TUC.Include(b => b.SAN_PHAM);
            return View(bLOGs.ToList());
        }

        // GET: Admin/BLOGs/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TIN_TUC bLOG = db.TIN_TUC.Find(id);
            if (bLOG == null)
            {
                return HttpNotFound();
            }
            return View(bLOG);
        }

        // GET: Admin/BLOGs/Create
        public ActionResult Create()
        {
            ViewBag.ID_SP = new SelectList(db.SAN_PHAM, "ID_SP", "TEN_SAN_PHAM");
            return View();
        }

        // POST: Admin/BLOGs/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID_DMB,ID_SP,ANH,TIEU_DE,NOI_DUNG")] TIN_TUC bLOG)
        {
            if (ModelState.IsValid)
            {
                db.TIN_TUC.Add(bLOG);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.ID_SP = new SelectList(db.SAN_PHAM, "ID_SP", "TEN_SAN_PHAM", bLOG.ID_SP);
            return View(bLOG);
        }

        // GET: Admin/BLOGs/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TIN_TUC bLOG = db.TIN_TUC.Find(id);
            if (bLOG == null)
            {
                return HttpNotFound();
            }
            ViewBag.ID_SP = new SelectList(db.SAN_PHAM, "ID_SP", "TEN_SAN_PHAM", bLOG.ID_SP);
            return View(bLOG);
        }

        // POST: Admin/BLOGs/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit([Bind(Include = "ID_DMB,ID_SP,ANH,TIEU_DE,NOI_DUNG")] TIN_TUC bLOG)
        {
            if (ModelState.IsValid)
            {
                db.Entry(bLOG).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.ID_SP = new SelectList(db.SAN_PHAM, "ID_SP", "TEN_SAN_PHAM", bLOG.ID_SP);
            return View(bLOG);
        }

        // GET: Admin/BLOGs/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TIN_TUC bLOG = db.TIN_TUC.Find(id);
            if (bLOG == null)
            {
                return HttpNotFound();
            }
            return View(bLOG);
        }

        // POST: Admin/BLOGs/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            TIN_TUC bLOG = db.TIN_TUC.Find(id);
            db.TIN_TUC.Remove(bLOG);
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
