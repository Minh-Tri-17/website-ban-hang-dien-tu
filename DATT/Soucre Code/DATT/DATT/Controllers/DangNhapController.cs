using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DATT.DAL;
using DATT.Models;

namespace DATT.Controllers
{
    public class DangNhapController : Controller
    {
        DATTEntities db = new DATTEntities();
        // GET: DangNhap
        public ActionResult DangNhap()
        {
            return View();
        }
        [HttpPost]
        public ActionResult DangNhap(string user, string password)
        {
            var query = (from q in db.TAI_KHOAN where q.TEN_TAI_KHOAN == user && q.MAT_KHAU == password select q).FirstOrDefault();
            if (query != null)
            {
                if (query.QUYEN != "admin")
                {
                    Session["User"] = user;
                    Session["IDAcc"] = query.ID_ACC;
                    return RedirectToAction("TrangChu", "TrangChu");
                }
                else
                {
                    return RedirectToAction("Dashboard", "Dashboard", new { area = "Admin" });
                }
              
            }
            return View();
        }
        [HttpPost]
        public ActionResult DangKy(string user, string password)
        {
            if (user != "" && password != "")
            {
                var query = (from q in db.TAI_KHOAN where q.TEN_TAI_KHOAN == user && q.MAT_KHAU == password select q).FirstOrDefault();
                if (query == null)
                {
                    TAI_KHOAN acc = new TAI_KHOAN();
                    acc.TEN_TAI_KHOAN = user;
                    acc.MAT_KHAU = password;
                    db.TAI_KHOAN.Add(acc);
                    db.SaveChanges();
                }
            }
            return RedirectToAction("DangNhap", "DangNhap");
        }
    }
}