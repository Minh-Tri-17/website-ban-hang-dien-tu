using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DATT.DAL;
using DATT.Models;

namespace DATT.Controllers
{
    public class SanPhamController : Controller
    {
        DATTEntities db = new DATTEntities();
        // GET: SanPham
        public ActionResult SanPham(string DM, string TH, string SX, string text)
        {
            try
            {
                List<SAN_PHAM> listSP = new List<SAN_PHAM>();
                ViewBag.loadTH = db.SAN_PHAM.Select(s => s.THUONG_HIEU).Distinct().ToList();
                ViewBag.loadDDG = db.DANH_GIAs.ToList();

                var loadSPTH = db.SAN_PHAM.Where(s => s.THUONG_HIEU == TH).Select(s => s).ToList();
                var loadSPDM = db.SAN_PHAM.Where(s => s.DANH_MUC == DM).Select(s => s).ToList();
                var loadSPDMTH = db.SAN_PHAM.Where(s => s.THUONG_HIEU == TH && s.DANH_MUC == DM).Select(s => s).ToList();
                var loadSPSXG = db.SAN_PHAM.OrderByDescending(s => s.GIA).Select(s => s).ToList();
                var loadSPSXT = db.SAN_PHAM.OrderBy(s => s.GIA).Select(s => s).ToList();
                var loadSPKM = db.SAN_PHAM.OrderByDescending(s => s.GIAM_GIA).Select(s => s).ToList();
                var loadSPS = (from a in db.SAN_PHAM
                               join b in db.THONG_TIN_SAN_PHAM
                               on a.ID_SP equals b.ID_SP
                               where a.TEN_SAN_PHAM.Contains(text) || b.CHIP.Contains(text) || b.RAM.Contains(text)
                               || b.HE_DIEU_HANH.Contains(text) || b.BO_NHO.Contains(text)
                               select a).ToList();

                if (TH != null && DM != null)
                {
                    listSP = loadSPDMTH;
                }
                else if (SX == "ASCE")
                {
                    listSP = loadSPSXT;
                }
                else if (SX == "DESC")
                {
                    listSP = loadSPSXG;
                }
                else if (SX == "SALE")
                {
                    listSP = loadSPKM;
                }
                else if (TH != null)
                {
                    listSP = loadSPTH;
                }
                else if (text != null)
                {
                    listSP = loadSPS;
                }
                else
                {
                    listSP = loadSPDM;
                }
                return View(listSP);
            }
            catch { return RedirectToAction("Error", "SanPham"); }
        }

        public ActionResult Error()
        {
            return View();
        }


        // GET: ChiTietSanPham
        public ActionResult ChiTietSanPham(int id)
        {
            var query = (from a in db.SAN_PHAM
                         join b in db.THONG_TIN_SAN_PHAM on a.ID_SP equals b.ID_SP
                         where a.ID_SP == id
                         select new ThongTinChiTietSanPham
                         {
                             ID_SP = a.ID_SP,
                             ID_TTSP = b.ID_TTSP,
                             THUONG_HIEU = a.THUONG_HIEU,
                             DANH_MUC = a.DANH_MUC,
                             TEN_SAN_PHAM = a.TEN_SAN_PHAM,
                             THONG_TIN_TONG_QUAT = a.THONG_TIN_TONG_QUAT,
                             GIA = a.GIA,
                             ANH = a.ANH,
                             GIAM_GIA = a.GIAM_GIA,
                             XUAT_XU = b.XUAT_XU,
                             KICH_THUOC = b.KICH_THUOC,
                             CONG_NGHE_MAN_HINH = b.CONG_NGHE_MAN_HINH,
                             CAMERA_SAU = b.CAMERA_SAU,
                             CAMERA_TRUOC = b.CAMERA_TRUOC,
                             CHIP = b.CHIP,
                             RAM = b.RAM,
                             BO_NHO = b.BO_NHO,
                             PIN = b.PIN,
                             THE_SIM = b.THE_SIM,
                             HE_DIEU_HANH = b.HE_DIEU_HANH,
                             DO_PHAN_GIAI = b.DO_PHAN_GIAI,
                             TAN_SO_QUET = b.TAN_SO_QUET,
                             GPU = b.GPU,
                             CONG = b.CONG,
                             HO_TRO_MANG = b.HO_TRO_MANG,
                             WI_FI = b.WI_FI,
                             BLUETOOTH = b.BLUETOOTH,
                             KICH_THUOC_MAN_HINH = b.KICH_THUOC_MAN_HINH,
                             TRONG_LUONG = b.TRONG_LUONG,
                             CHAT_LIEU = b.CHAT_LIEU,
                             CAM_BIEN_VAN_TAY = b.CAM_BIEN_VAN_TAY,
                             TINH_NANG_DAC_BIET = b.TINH_NANG_DAC_BIET,
                             SO_KHE_RAM = b.SO_KHE_RAM,
                             THOI_DIEM_RA_MAT = b.THOI_DIEM_RA_MAT
                         }).FirstOrDefault();

            var loadTT = db.TIN_TUC.FirstOrDefault(s => s.ID_SP == id);
            ViewBag.loadTT = loadTT;

            var loadDG = (from a in db.SAN_PHAM
                          join b in db.DANH_GIAs on
                          a.ID_SP equals b.ID_SP
                          join c in db.TAI_KHOAN on
                          b.ID_ACC equals c.ID_ACC
                          where b.ID_SP == id
                          select new DanhGia
                          {
                              ID_DG = b.ID_DG,
                              ID_SP = a.ID_SP,
                              DIEM = b.DIEM,
                              NOI_DUNG = b.NOI_DUNG,
                              USERNAME = c.TEN_TAI_KHOAN,
                          }).ToList();
            ViewBag.loadDG = loadDG;

            var loadDDG = (from q in db.DANH_GIAs where q.ID_SP == id select q.DIEM).Average();
            var loadSLDG = (from q in db.DANH_GIAs where q.ID_SP == id select q).Count();
            ViewBag.loadDDG = loadDDG;
            ViewBag.loadSLDG = loadSLDG;

            if (query != null)
            {
                return View(query);
            }
            else
            {
                return RedirectToAction("Error", "SanPham");
            }
        }
        [HttpPost]
        public ActionResult ChiTietSanPham(int id, string ND, int D)
        {
            try
            {
                var IDA = Int16.Parse(Session["IDAcc"].ToString());
                DANH_GIA danhgia = new DANH_GIA();
                danhgia.ID_ACC = IDA;
                danhgia.NOI_DUNG = ND;
                danhgia.DIEM = D;
                danhgia.ID_SP = id;
                db.DANH_GIAs.Add(danhgia);
                db.SaveChanges();

                var item = db.DANH_GIAs.Where(s => s.ID_SP == id).Select(s => s).FirstOrDefault();
                if(item != null && item.KIEM_TRA != "true")
                {
                    item.KIEM_TRA = "true";
                    db.SaveChanges();
                }
                return RedirectToAction("TrangChu", "TrangChu");
            }
            catch
            {
                return RedirectToAction("Error", "SanPham");
            }
        }
    }
}