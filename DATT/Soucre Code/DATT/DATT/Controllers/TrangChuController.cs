using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DATT.DAL;
using DATT.Models;

namespace DATT.Controllers
{
    public class TrangChuController : Controller
    {
        DATTEntities db = new DATTEntities();
        // GET: TrangChu
        public ActionResult TrangChu()
        {
            try
            {
                ViewBag.loadDM = db.SAN_PHAM.Select(s => s.DANH_MUC).Distinct().ToList();
                ViewBag.loadSP = db.SAN_PHAM.Select(s => s).ToList();
                ViewBag.loadTH = db.SAN_PHAM.Select(s => new DanhMucThuongHieu { THUONG_HIEU = s.THUONG_HIEU, DANH_MUC = s.DANH_MUC }).Distinct().ToList();

                ViewBag.loadTT = db.TIN_TUC.Take(4);
                ViewBag.loadDDG = db.DANH_GIAs.ToList();
                ViewBag.loadCN = db.CHI_NHANH.ToList();

                if (Session["IDAcc"] == null)
                {
                    var ID = 0;
                    ViewBag.loadTGH = db.CHI_TIET_HOA_DON.Count(s => s.ID_ACC == ID);
                }
                else
                {
                    var ID = Int16.Parse(Session["IDAcc"].ToString());
                    ViewBag.loadTGH = db.CHI_TIET_HOA_DON.Count(s => s.ID_ACC == ID && s.TRANG_THAI != "true");
                }

                if (Session["ChiNhanh"] == null)
                {
                    Session["ChiNhanh"] = 1;
                }

                return View();
            }
            catch { return RedirectToAction("Error", "SanPham"); }
        }

        public ActionResult ChiNhanh(int idCN)
        {
            try
            {
                Session["ChiNhanh"] = idCN;
                return RedirectToAction("TrangChu");
            }
            catch { return RedirectToAction("Error", "SanPham"); }
        }

        public ActionResult Blog(int id)
        {
            try
            {
                var loadTT = db.TIN_TUC.ToList();
                ViewBag.loadTT = loadTT;

                var loadCTTT = db.TIN_TUC.Find(id);
                return View(loadCTTT);
            }
            catch
            {
                return RedirectToAction("Error", "SanPham");
            }
        }
    }
}