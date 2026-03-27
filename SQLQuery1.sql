USE LogisticsDB;
GO

CREATE TABLE KHACH_HANG (
    khach_hang_id INT IDENTITY(1,1) PRIMARY KEY,
    ten NVARCHAR(100),
    sdt NVARCHAR(15),
    email NVARCHAR(100)
);

CREATE TABLE DIA_CHI (
    dia_chi_id INT IDENTITY(1,1) PRIMARY KEY,
    dia_chi NVARCHAR(255)
);

CREATE TABLE TRANG_THAI (
    trang_thai_id INT IDENTITY(1,1) PRIMARY KEY,
    ten_trang_thai NVARCHAR(100)
);

CREATE TABLE DON_HANG (
    don_hang_id INT IDENTITY(1,1) PRIMARY KEY,
    khach_hang_id INT,
    dia_chi_id INT,
    trang_thai_id INT,
    ngay_tao DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (khach_hang_id) REFERENCES KHACH_HANG(khach_hang_id),
    FOREIGN KEY (dia_chi_id) REFERENCES DIA_CHI(dia_chi_id),
    FOREIGN KEY (trang_thai_id) REFERENCES TRANG_THAI(trang_thai_id)
);

CREATE TABLE HANG_HOA (
    hang_hoa_id INT IDENTITY(1,1) PRIMARY KEY,
    ten_hang NVARCHAR(100),
    trong_luong FLOAT,
    mo_ta NVARCHAR(255)
);

CREATE TABLE KHO (
    kho_id INT IDENTITY(1,1) PRIMARY KEY,
    ten_kho NVARCHAR(100),
    dia_chi NVARCHAR(255)
);

CREATE TABLE DON_HANG_HANG_HOA (
    id INT IDENTITY(1,1) PRIMARY KEY,
    don_hang_id INT,
    hang_hoa_id INT,
    so_luong INT,
    FOREIGN KEY (don_hang_id) REFERENCES DON_HANG(don_hang_id),
    FOREIGN KEY (hang_hoa_id) REFERENCES HANG_HOA(hang_hoa_id)
);

CREATE TABLE NHAN_VIEN_GIAO_HANG (
    nhan_vien_id INT IDENTITY(1,1) PRIMARY KEY,
    ten NVARCHAR(100),
    sdt NVARCHAR(15)
);

CREATE TABLE XE_VAN_CHUYEN (
    xe_id INT IDENTITY(1,1) PRIMARY KEY,
    bien_so NVARCHAR(50),
    loai_xe NVARCHAR(50)
);

CREATE TABLE LO_TRINH (
    lo_trinh_id INT IDENTITY(1,1) PRIMARY KEY,
    diem_bat_dau NVARCHAR(255),
    diem_ket_thuc NVARCHAR(255)
);

CREATE TABLE LICH_SU_GIAO_HANG (
    lich_su_id INT IDENTITY(1,1) PRIMARY KEY,
    don_hang_id INT,
    nhan_vien_id INT,
    xe_id INT,
    lo_trinh_id INT,
    thoi_gian DATETIME DEFAULT GETDATE(),
    ghi_chu NVARCHAR(255),

    FOREIGN KEY (don_hang_id) REFERENCES DON_HANG(don_hang_id),
    FOREIGN KEY (nhan_vien_id) REFERENCES NHAN_VIEN_GIAO_HANG(nhan_vien_id),
    FOREIGN KEY (xe_id) REFERENCES XE_VAN_CHUYEN(xe_id),
    FOREIGN KEY (lo_trinh_id) REFERENCES LO_TRINH(lo_trinh_id)
);