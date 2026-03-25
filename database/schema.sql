USE LogisticsDB;
GO

CREATE TABLE KHACH_HANG (
    khach_hang_id INT IDENTITY(1,1) PRIMARY KEY,
    ten           NVARCHAR(100) NOT NULL,
    sdt           NVARCHAR(15)  NOT NULL,
    email         NVARCHAR(100),
    ngay_tao      DATETIME      NOT NULL DEFAULT GETDATE(),
    ngay_sua      DATETIME      NULL
);

CREATE TABLE DIA_CHI (
    dia_chi_id    INT IDENTITY(1,1) PRIMARY KEY,
    khach_hang_id INT           NOT NULL,
    dia_chi       NVARCHAR(255) NOT NULL,
    loai          NVARCHAR(50),
    ngay_tao      DATETIME      NOT NULL DEFAULT GETDATE(),
    ngay_sua      DATETIME      NULL,
    FOREIGN KEY (khach_hang_id) REFERENCES KHACH_HANG(khach_hang_id)
);

CREATE TABLE HANG_HOA (
    hang_hoa_id INT IDENTITY(1,1) PRIMARY KEY,
    ten_hang    NVARCHAR(100) NOT NULL,
    trong_luong FLOAT,
    mo_ta       NVARCHAR(255),
    ngay_tao    DATETIME      NOT NULL DEFAULT GETDATE(),
    ngay_sua    DATETIME      NULL
);

CREATE TABLE KHO (
    kho_id   INT IDENTITY(1,1) PRIMARY KEY,
    ten_kho  NVARCHAR(100) NOT NULL,
    dia_chi  NVARCHAR(255),
    ngay_tao DATETIME      NOT NULL DEFAULT GETDATE(),
    ngay_sua DATETIME      NULL        -- fix: bỏ dấu phẩy thừa
);

CREATE TABLE KHO_HANG_HOA (
    id          INT IDENTITY(1,1) PRIMARY KEY,
    kho_id      INT NOT NULL,
    hang_hoa_id INT NOT NULL,
    so_luong    INT NOT NULL DEFAULT 0,
    FOREIGN KEY (kho_id)      REFERENCES KHO(kho_id),
    FOREIGN KEY (hang_hoa_id) REFERENCES HANG_HOA(hang_hoa_id),
    CONSTRAINT UQ_KhoHangHoa UNIQUE (kho_id, hang_hoa_id)
);

CREATE TABLE DON_HANG (
    don_hang_id   INT IDENTITY(1,1) PRIMARY KEY,
    khach_hang_id INT           NOT NULL,
    dia_chi_id    INT           NOT NULL,
    trang_thai    NVARCHAR(50)  NOT NULL DEFAULT N'Chờ xử lý',
    ngay_tao      DATETIME      NOT NULL DEFAULT GETDATE(),
    ngay_sua      DATETIME      NULL,
    FOREIGN KEY (khach_hang_id) REFERENCES KHACH_HANG(khach_hang_id),
    FOREIGN KEY (dia_chi_id)    REFERENCES DIA_CHI(dia_chi_id)
);

CREATE TABLE DON_HANG_HANG_HOA (
    id          INT IDENTITY(1,1) PRIMARY KEY,
    don_hang_id INT NOT NULL,
    hang_hoa_id INT NOT NULL,
    so_luong    INT NOT NULL,
    FOREIGN KEY (don_hang_id) REFERENCES DON_HANG(don_hang_id),
    FOREIGN KEY (hang_hoa_id) REFERENCES HANG_HOA(hang_hoa_id)
);

CREATE TABLE NHAN_VIEN_GIAO_HANG (
    nhan_vien_id INT IDENTITY(1,1) PRIMARY KEY,
    ten          NVARCHAR(100) NOT NULL,
    sdt          NVARCHAR(15)  NOT NULL,
    ngay_tao     DATETIME      NOT NULL DEFAULT GETDATE(),
    ngay_sua     DATETIME      NULL
);

CREATE TABLE XE_VAN_CHUYEN (
    xe_id    INT IDENTITY(1,1) PRIMARY KEY,
    bien_so  NVARCHAR(50) NOT NULL UNIQUE,
    loai_xe  NVARCHAR(50)
);

CREATE TABLE LO_TRINH (
    lo_trinh_id   INT IDENTITY(1,1) PRIMARY KEY,
    diem_bat_dau  NVARCHAR(255) NOT NULL,
    diem_ket_thuc NVARCHAR(255) NOT NULL
);

CREATE TABLE PHAN_CONG (
    phan_cong_id   INT IDENTITY(1,1) PRIMARY KEY,
    don_hang_id    INT      NOT NULL,
    nhan_vien_id   INT      NOT NULL,
    xe_id          INT      NOT NULL,
    lo_trinh_id    INT      NOT NULL,
    kho_id         INT      NOT NULL,
    ngay_phan_cong DATETIME NOT NULL DEFAULT GETDATE(),
    ngay_tao       DATETIME NOT NULL DEFAULT GETDATE(),
    ngay_sua       DATETIME NULL,
    FOREIGN KEY (don_hang_id)  REFERENCES DON_HANG(don_hang_id),
    FOREIGN KEY (nhan_vien_id) REFERENCES NHAN_VIEN_GIAO_HANG(nhan_vien_id),
    FOREIGN KEY (xe_id)        REFERENCES XE_VAN_CHUYEN(xe_id),
    FOREIGN KEY (lo_trinh_id)  REFERENCES LO_TRINH(lo_trinh_id),
    FOREIGN KEY (kho_id)       REFERENCES KHO(kho_id)
);

CREATE TABLE LICH_SU_GIAO_HANG (
    lich_su_id  INT IDENTITY(1,1) PRIMARY KEY,
    don_hang_id INT          NOT NULL,
    trang_thai  NVARCHAR(50) NOT NULL,
    thoi_gian   DATETIME     NOT NULL DEFAULT GETDATE(),
    ghi_chu     NVARCHAR(255),
    ngay_tao    DATETIME     NOT NULL DEFAULT GETDATE(),
    ngay_sua    DATETIME     NULL,
    FOREIGN KEY (don_hang_id) REFERENCES DON_HANG(don_hang_id)
);