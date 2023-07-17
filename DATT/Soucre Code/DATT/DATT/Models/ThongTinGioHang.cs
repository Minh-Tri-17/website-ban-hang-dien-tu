using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DATT.DAL;

namespace DATT.Models
{
    public class ThongTinGioHang
    {
        public int ID_SP { get; set; }
        public string THUONG_HIEU { get; set; }
        public string DANH_MUC { get; set; }
        public string TEN_SAN_PHAM { get; set; }
        public Nullable<int> GIA { get; set; }
        public Nullable<int> SO_LUONG_TON { get; set; }
        public string ANH { get; set; }
        public Nullable<int> GIAM_GIA { get; set; }
        public int ID_CTHD { get; set; }
        public Nullable<int> ID_KH { get; set; }
        public string TEN_KHACH_HANG { get; set; }
        public string DIA_CHI { get; set; }
        public string SDT { get; set; }
        public string EMAIL { get; set; }
        public Nullable<int> ID_CN { get; set; }
        public Nullable<int> ID_ACC { get; set; }
        public Nullable<int> SO_LUONG { get; set; }
        public string TRANG_THAI { get; set; }
    }
    public class ChiNhanh
    {
        public int ID_CN { get; set; }
    }
}
