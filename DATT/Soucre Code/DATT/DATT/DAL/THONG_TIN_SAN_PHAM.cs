//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DATT.DAL
{
    using System;
    using System.Collections.Generic;
    
    public partial class THONG_TIN_SAN_PHAM
    {
        public int ID_TTSP { get; set; }
        public Nullable<int> ID_SP { get; set; }
        public string XUAT_XU { get; set; }
        public string KICH_THUOC { get; set; }
        public string CONG_NGHE_MAN_HINH { get; set; }
        public string CAMERA_SAU { get; set; }
        public string CAMERA_TRUOC { get; set; }
        public string CHIP { get; set; }
        public string RAM { get; set; }
        public string BO_NHO { get; set; }
        public string PIN { get; set; }
        public string THE_SIM { get; set; }
        public string HE_DIEU_HANH { get; set; }
        public string DO_PHAN_GIAI { get; set; }
        public string TAN_SO_QUET { get; set; }
        public string GPU { get; set; }
        public string CONG { get; set; }
        public string HO_TRO_MANG { get; set; }
        public string WI_FI { get; set; }
        public string BLUETOOTH { get; set; }
        public string KICH_THUOC_MAN_HINH { get; set; }
        public string TRONG_LUONG { get; set; }
        public string CHAT_LIEU { get; set; }
        public string CAM_BIEN_VAN_TAY { get; set; }
        public string TINH_NANG_DAC_BIET { get; set; }
        public string SO_KHE_RAM { get; set; }
        public Nullable<System.DateTime> THOI_DIEM_RA_MAT { get; set; }
    
        public virtual SAN_PHAM SAN_PHAM { get; set; }
    }
}