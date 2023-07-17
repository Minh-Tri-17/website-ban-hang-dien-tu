using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DATT.Models;
using DATT.DAL;

namespace DATT.Controllers
{
    public class GioHangController : Controller
    {
        DATTEntities db = new DATTEntities();
        // GET: GioHang
        public ActionResult GioHang()
        {
            try
            {
                var ID = Int16.Parse(Session["IDAcc"].ToString());
                var query = (from a in db.CHI_TIET_HOA_DON
                             join b in db.SAN_PHAM
                             on a.ID_SP equals b.ID_SP
                             where a.ID_ACC == ID && a.TRANG_THAI != "true"
                             select new ThongTinGioHang
                             {
                                 ID_CTHD = a.ID_CTHD,
                                 ID_SP = b.ID_SP,
                                 TEN_SAN_PHAM = b.TEN_SAN_PHAM,
                                 GIA = b.GIA,
                                 GIAM_GIA = b.GIAM_GIA,
                                 ANH = b.ANH,
                                 SO_LUONG = a.SO_LUONG,
                                 SO_LUONG_TON = b.SO_LUONG_TON
                             }).ToList();
                if (ID != 0)
                {
                    ViewBag.loadTT = db.TAM_TINH(ID).First();
                }
                else
                {
                    ViewBag.loadTT = 0;
                }
                return View(query);
            }
            catch
            {
                return RedirectToAction("Error", "SanPham");
            }
        }

        public ActionResult RemoveGioHang(int id)
        {
            try
            {
                var chitiethoadon = db.CHI_TIET_HOA_DON.Find(id);
                db.CHI_TIET_HOA_DON.Remove(chitiethoadon);
                db.SaveChanges();
                return RedirectToAction("GioHang", "GioHang");
            }
            catch
            {
                return RedirectToAction("Error", "SanPham");
            }
        }

        public ActionResult AddGioHang(int id, string MN)
        {
            try
            {
                var IDA = Int16.Parse(Session["IDAcc"].ToString());
                var IDCN = Int16.Parse(Session["ChiNhanh"].ToString());
                if (IDA != 0)
                {
                    CHI_TIET_HOA_DON chitiethoadon = new CHI_TIET_HOA_DON();
                    chitiethoadon.ID_SP = id;
                    chitiethoadon.ID_ACC = IDA;
                    chitiethoadon.ID_CN = IDCN;
                    chitiethoadon.SO_LUONG = 1;
                    db.CHI_TIET_HOA_DON.Add(chitiethoadon);
                    db.SaveChanges();
                    if (MN != null)
                    {
                        return RedirectToAction("GioHang", "GioHang");
                    }
                    else
                    {
                        return RedirectToAction("TrangChu", "TrangChu");
                    }
                }
                else
                {
                    return RedirectToAction("DangNhap", "DangNhap");
                }
            }
            catch
            {
                return RedirectToAction("Error", "SanPham");
            }
        }

        public ActionResult AddSL(int IDCT, int SL)
        {
            CHI_TIET_HOA_DON chitiethoadon = db.CHI_TIET_HOA_DON.Find(IDCT);
            chitiethoadon.SO_LUONG = SL;
            db.CHI_TIET_HOA_DON.Add(chitiethoadon);
            db.SaveChanges();

            CHI_TIET_HOA_DON chitiethoadon2 = db.CHI_TIET_HOA_DON.Find(IDCT);
            db.CHI_TIET_HOA_DON.Remove(chitiethoadon2);
            db.SaveChanges();

            return RedirectToAction("GioHang", "GioHang");
        }

        public ActionResult DatHang()
        {
            return View();
        }

        [HttpPost]
        public ActionResult DatHang(string Hoten, string SDT, string Email, string Diachi)
        {
            var ID = Int16.Parse(Session["IDAcc"].ToString());
            if (db.KHACH_HANG.Select(s => s.SDT).FirstOrDefault() != SDT)
            {
              if(ID != 0)
                {
                    KHACH_HANG khachhang = new KHACH_HANG();
                    khachhang.TEN_KHACH_HANG = Hoten;
                    khachhang.SDT = SDT;
                    khachhang.EMAIL = Email;
                    khachhang.DIA_CHI = Diachi;
                    db.KHACH_HANG.Add(khachhang);
                    db.SaveChanges();
                }
                else
                {
                    return RedirectToAction("DangNhap", "DangNhap");
                }
            }

            if (ID != 0)
            {
                var IDKH = db.KHACH_HANG.Where(s => s.SDT == SDT).Select(s => s.ID_KH).FirstOrDefault();
                db.THEM_KHACH_VAO_HOA_DON(IDKH, ID);

                HOA_DON hoadon = new HOA_DON();
                hoadon.NGAY_XUAT = DateTime.Now;
                db.HOA_DON.Add(hoadon);
                
                var listCTHD = db.CHI_TIET_HOA_DON.Where(ct => ct.ID_KH == IDKH && ct.TRANG_THAI == "true").Select(ct => ct).ToList();
                foreach (var item in listCTHD)
                {
                    item.ID_HD = hoadon.ID_HD;
                    item.TONG_TIEN = item.SAN_PHAM.GIA * item.SO_LUONG;
                }
                db.SaveChanges();
                return RedirectToAction("TrangChu", "TrangChu");
            }
            else
            {
                return RedirectToAction("DangNhap", "DangNhap");
            }
        }

        public ActionResult DaDat()
        {
            var ID = Int16.Parse(Session["IDAcc"].ToString());
            var loadDH = (from a in db.CHI_TIET_HOA_DON
                          join b in db.KHACH_HANG
                          on a.ID_KH equals b.ID_KH
                          where a.ID_ACC == ID && a.TRANG_THAI == "true"
                          select new ThongTinGioHang
                          {
                              TEN_KHACH_HANG = b.TEN_KHACH_HANG,
                              DIA_CHI = b.DIA_CHI,
                              SDT = b.SDT,
                              EMAIL = b.EMAIL,
                              TEN_SAN_PHAM = a.SAN_PHAM.TEN_SAN_PHAM,
                              GIA = a.SAN_PHAM.GIA,
                              SO_LUONG = a.SO_LUONG,
                              ANH =a.SAN_PHAM.ANH
                          }).ToList();
            return View(loadDH);
        }
    }
}