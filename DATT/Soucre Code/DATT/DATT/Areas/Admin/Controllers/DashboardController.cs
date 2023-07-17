using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DATT.DAL;
using DATT.Models;

namespace DATT.Areas.Admin.Controllers
{
    public class DashboardController : Controller
    {
        DATTEntities db = new DATTEntities();
        // GET: Admin/Dashboard
        public ActionResult Dashboard()
        {
            ViewBag.loadTSP = db.CHI_TIET_HOA_DON.Where(s => s.TRANG_THAI == "true").Sum(s => s.SO_LUONG);
            ViewBag.loadTT = (from a in db.CHI_TIET_HOA_DON
                              join b in db.SAN_PHAM
                              on a.ID_SP equals b.ID_SP
                              where a.TRANG_THAI == "true"
                              select a.SO_LUONG * b.GIA).Sum();
            ViewBag.loadTHD = db.CHI_TIET_HOA_DON.Count(s=>s.TRANG_THAI == "true");
            ViewBag.loadTKH = db.CHI_TIET_HOA_DON.Where(s=>s.TRANG_THAI == "true").Select(s => s.ID_KH).Count();
            ViewBag.loadDanhMuc = db.DoanhThuDanhMuc().ToList();
            ViewBag.loadThang = db.DoanhThuThang().ToList();
            ViewBag.loadNgay = db.DoanhThuNgay().ToList();
            return View();
        }
    }
}