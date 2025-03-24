CREATE DATABASE QUANLYCF
USE QUANLYCF

CREATE TABLE NhaCungCap (
    MaNCC VARCHAR(10) PRIMARY KEY,
    TenNCC NVARCHAR(50),
    DiaChi NVARCHAR(50),
    SDT char(10) not null Check(SDT like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);
INSERT INTO NhaCungCap (MaNCC, TenNCC, DiaChi, SDT)
VALUES 
('NCC01', N'CÔNG TY CÀ PHÊ THANH TÙNG', N'103 HUỲNH VĂN NGHỆ, NGŨ HÀNH SƠN, ĐÀ NẴNG', '0776101860'),
('NCC02', N'CÔNG TY TRÀ XANH BẢO LỘC', N'45 LÊ HỒNG PHONG, BẢO LỘC, LÂM ĐỒNG', '0987654321');


CREATE TABLE NhanVien (
    NvID VARCHAR(10) PRIMARY KEY,
    TenNV NVARCHAR(50) NOT NULL,
    GioiTinh NVARCHAR(10) CHECK (GioiTinh IN ('Nam', 'Nu'))  not null,
    ViTri NVARCHAR(50) not null,
    DiaChi NVARCHAR(60)not null,
    NgayVaoLam DATE not null,
    SDT char(10) not null Check(SDT like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);

INSERT INTO NhanVien (NvID, TenNV, GioiTinh, ViTri, DiaChi, NgayVaoLam, SDT)
VALUES 
('NV01', N'Nguyễn Văn A', N'Nam', N'Quản lý', N'123 Lê Lợi, Quận 1, TP.HCM', '2023-01-15', '0901111222'),
('NV02', N'Trần Thị B', N'Nu', N'Nhân viên pha chế', N'456 Nguyễn Trãi, Quận 5, TP.HCM', '2023-03-20', '0912222333'),
('NV03', N'Phạm Văn C', N'Nam', N'Nhân viên phục vụ', N'789 Hoàng Văn Thụ, Quận Tân Bình, TP.HCM', '2023-05-10', '0923333444'),
('NV04', N'Lê Thị D', N'Nu', N'Nhân viên thu ngân', N'12 Trần Hưng Đạo, Quận 1, TP.HCM', '2023-06-05', '0934444555'),
('NV05', N'Hoàng Văn E', N'Nam', N'Nhân viên bảo vệ', N'34 Phạm Ngọc Thạch, Quận 3, TP.HCM', '2023-08-12', '0945555666');

CREATE TABLE CaLamViec (
    MaCLV VARCHAR(10) PRIMARY KEY,
    TenCLV NVARCHAR(20) not null,
    GioBD DATETIME not null,
    GioKT DATETIME not null,
	CHECK (GioBD < GioKT),
    SoTien NUMERIC(8,2) not null CHECK(SoTien > 0)
);

INSERT INTO CaLamViec (MaCLV, TenCLV, GioBD, GioKT, SoTien)
VALUES 
('CLV01', N'Ca sáng', '2025-03-23 06:00:00', '2025-03-23 12:00:00', 200000),
('CLV02', N'Ca chiều', '2025-03-23 12:00:00', '2025-03-23 18:00:00', 220000),
('CLV03', N'Ca tối', '2025-03-23 18:00:00', '2025-03-23 23:00:00', 250000);


CREATE TABLE ChiTietLuong (
    NvID VARCHAR(10),
    MaCLV VARCHAR(10),
    TongSoCaLam INT check(TongSoCaLam >= 0) not null,
    ThanhTien NUMERIC(8,2) check(ThanhTien >= 0),
    PRIMARY KEY (NvID, MaCLV),
    FOREIGN KEY (NvID) REFERENCES NhanVien(NvID),
    FOREIGN KEY (MaCLV) REFERENCES CaLamViec(MaCLV)
);

INSERT INTO ChiTietLuong (NvID, MaCLV, TongSoCaLam, ThanhTien)
VALUES 
('NV01', 'CLV01', 10, 200000.00),
('NV02', 'CLV02', 12, 264000.00),
('NV03', 'CLV03', 8, 200000.00),
('NV04', 'CLV01', 15, 300000.00),
('NV05', 'CLV02', 9, 198000.00);


CREATE TABLE HoaDonNhapHang (
    MaHDNH VARCHAR(10) PRIMARY KEY,
    NgayNH DATE,
	NvID varchar(10),
	TongTien Float check (TongTien > 0),
    FOREIGN KEY (NvID) REFERENCES NhanVien(NvID)
);

INSERT INTO HoaDonNhapHang (MaHDNH, NgayNH, NvID, TongTien)
VALUES 
('HDNH001', '2024-03-01', 'NV01', 5000000),
('HDNH002', '2024-03-02', 'NV02', 7200000),
('HDNH003', '2024-03-03', 'NV03', 3150000),
('HDNH004', '2024-03-04', 'NV04', 8450000),
('HDNH005', '2024-03-05', 'NV05', 4200000);


CREATE TABLE LoaiHang (
    MaLH VARCHAR(10) PRIMARY KEY,
    TenLH NVARCHAR(50),
    MoTa NVARCHAR(100)
);

INSERT INTO LoaiHang (MaLH, TenLH, MoTa)
VALUES 
('LH001', N'Cà phê', N'Các loại cà phê rang xay và hòa tan'),
('LH002', N'Trà', N'Các loại trà xanh, trà đen, trà sữa'),
('LH003', N'Bánh ngọt', N'Các loại bánh ngọt ăn kèm đồ uống'),
('LH004', N'Nước ép', N'Nước ép trái cây tươi'),
('LH005', N'Sinh tố', N'Các loại sinh tố từ hoa quả tươi');

CREATE TABLE HangHoa (
    MaHH VARCHAR(10) PRIMARY KEY,
    TenHH NVARCHAR(50),
    MaLH VARCHAR(10),
    GiaSP NUMERIC(8,2) CHECK(GiaSP > 0),
	MaNCC VARCHAR(10),
    FOREIGN KEY (MaLH) REFERENCES LoaiHang(MaLH),
	FOREIGN KEY (MaNCC) REFERENCES NhaCungCap(MaNCC)
);

INSERT INTO HangHoa (MaHH, TenHH, MaLH, GiaSP, MaNCC)
VALUES 
('HH001', N'Cà phê đen', 'LH001', 25000, 'NCC01'),
('HH002', N'Cà phê sữa', 'LH001', 30000, 'NCC01'),
('HH003', N'Trà xanh', 'LH002', 20000, 'NCC01'),
('HH004', N'Trà sữa trân châu', 'LH002', 35000, 'NCC02'),
('HH005', N'Bánh bông lan', 'LH003', 15000, 'NCC02'),
('HH006', N'Bánh cookies', 'LH003', 18000, 'NCC02'),
('HH007', N'Nước ép cam', 'LH004', 40000, 'NCC02'),
('HH008', N'Nước ép dưa hấu', 'LH004', 38000, 'NCC02'),
('HH009', N'Sinh tố xoài', 'LH005', 45000, 'NCC01'),
('HH010', N'Sinh tố bơ', 'LH005', 50000, 'NCC01');

CREATE TABLE ChiTietNhapHang (
    MaHH VARCHAR(10),
    MaHDNH VARCHAR(10),
    SoLuong INT check(SoLuong > 0),
    ThanhTien NUMERIC(8,2) CHECK(ThanhTien > 0),
    PRIMARY KEY (MaHH, MaHDNH),
    FOREIGN KEY (MaHH) REFERENCES HangHoa(MaHH),
    FOREIGN KEY (MaHDNH) REFERENCES HoaDonNhapHang(MaHDNH)
);

INSERT INTO ChiTietNhapHang (MaHH, MaHDNH, SoLuong, ThanhTien)
VALUES 
('HH001', 'HDNH001', 50, 125000.00),
('HH002', 'HDNH001', 40, 120000.00),
('HH003', 'HDNH002', 30, 60000.00),
('HH004', 'HDNH002', 20, 70000.00),
('HH005', 'HDNH003', 25, 37500.00),
('HH006', 'HDNH003', 30, 54000.00),
('HH007', 'HDNH004', 15, 60000.00),
('HH008', 'HDNH004', 18, 68400.00),
('HH009', 'HDNH005', 12, 54000.00),
('HH010', 'HDNH005', 10, 50000.00);


CREATE TABLE LoaiMaKH (
    MaLKH VARCHAR(10) PRIMARY KEY,
    TenLKH NVARCHAR(50),
);

INSERT INTO LoaiMaKH (MaLKH, TenLKH)
VALUES 
('LKH001', N'Khách Thường'),
('LKH002', N'Khách VIP'),
('LKH003', N'Khách Thành Viên'),
('LKH004', N'Khách Doanh Nghiệp'),
('LKH005', N'Khách Mới');

CREATE TABLE KhachHang (
    KhID VARCHAR(10) PRIMARY KEY,
    MaLKH VARCHAR(10),
    TenKH NVARCHAR(50),
    DiaChi NVARCHAR(100),
    SDT char(10) not null Check(SDT like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    DiemTL INT check (DiemTL >= 0),
    FOREIGN KEY (MaLKH) REFERENCES LoaiMaKH(MaLKH)
);

INSERT INTO KhachHang (KhID, MaLKH, TenKH, DiaChi, SDT, DiemTL)
VALUES 
('KH001', 'LKH001', N'Nguyễn Văn A', N'123 Đường Lê Lợi, Hà Nội', '0912345678', 100),
('KH002', 'LKH002', N'Trần Thị B', N'456 Đường Trần Hưng Đạo, TP.HCM', '0923456789', 500),
('KH003', 'LKH003', N'Phạm Văn C', N'789 Đường Nguyễn Huệ, Đà Nẵng', '0934567890', 300),
('KH004', 'LKH004', N'Lê Thị D', N'101 Đường Hai Bà Trưng, Hải Phòng', '0945678901', 700),
('KH005', 'LKH005', N'Hoàng Văn E', N'202 Đường Quang Trung, Cần Thơ', '0956789012', 50);

CREATE TABLE Voucher (
    VoucherID VARCHAR(10) PRIMARY KEY,
	MaKH VARCHAR(10),
    startDate DATE,
    endDate DATE,
	CHECK (endDate >startDate),
    Discount NUMERIC(2,2) check(Discount > 0),
    FOREIGN KEY (MaKH) REFERENCES KhachHang(KhID)
);

INSERT INTO Voucher (VoucherID, MaKH, startDate, endDate, Discount)
VALUES 
('V001', 'KH001', '2025-03-01', '2025-03-31', 0.10),
('V002', 'KH002', '2025-03-05', '2025-04-05', 0.15),
('V003', 'KH003', '2025-03-10', '2025-04-10', 0.20),
('V004', 'KH004', '2025-03-15', '2025-04-15', 0.25),
('V005', 'KH005', '2025-03-20', '2025-04-20', 0.05);

CREATE TABLE Ban (
    MaBan VARCHAR(10) PRIMARY KEY,
    LoaiBan VARCHAR(10),
    TrangThai VARCHAR(2) DEFAULT 'CHƯA ĐẶT' CHECK (TrangThai IN ('CHƯA ĐẶT', 'ĐÃ ĐẶT')) 
);

INSERT INTO Ban (MaBan, LoaiBan, TrangThai)
VALUES 
('B001', '2 người', 'CHƯA ĐẶT'),
('B002', '3 người', 'ĐÃ ĐẶT'),
('B003', '4 người', 'CHƯA ĐẶT'),
('B004', '3 người', 'CHƯA ĐẶT'),
('B005', '2 người', 'ĐÃ ĐẶT');
ALTER TABLE BAN
ALTER COLUMN TRANGTHAI VARCHAR(10);

CREATE TABLE DatBan (
    MaDatBan VARCHAR(10) PRIMARY KEY,
    KhID VARCHAR(10),
    MaBan VARCHAR(10),
    NgayDat DATETIME,
    FOREIGN KEY (KhID) REFERENCES KhachHang(KhID),
    FOREIGN KEY (MaBan) REFERENCES Ban(MaBan)
);

INSERT INTO DatBan (MaDatBan, KhID, MaBan, NgayDat)
VALUES 
('DB001', 'KH001', 'B001', '2024-03-20 18:30:00'),
('DB002', 'KH002', 'B002', '2024-03-21 19:00:00'),
('DB003', 'KH003', 'B003', '2024-03-22 20:15:00'),
('DB004', 'KH004', 'B004', '2024-03-23 17:45:00'),
('DB005', 'KH005', 'B005', '2024-03-24 21:00:00');

CREATE TABLE HoaDon (
    MaHD VARCHAR(10) PRIMARY KEY,
    KhID VARCHAR(10),
    MaNV VARCHAR(10),
    MaBan VARCHAR(10),
    NgayHDBH DATE,
    TongTien NUMERIC(8,2) CHECK (TongTien > 0),
    ChiPhiKhac NUMERIC(8,2) CHECK (ChiPhiKhac > 0),
    FOREIGN KEY (KhID) REFERENCES KhachHang(KhID),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(NvID),
    FOREIGN KEY (MaBan) REFERENCES Ban(MaBan)
);

INSERT INTO HoaDon (MaHD, KhID, MaNV, MaBan, NgayHDBH, TongTien, ChiPhiKhac)
VALUES 
('HD001', 'KH001', 'NV01', 'B001', '2024-03-20', 500000, 20000),
('HD002', 'KH002', 'NV02', 'B002', '2024-03-21', 750000, 25000),
('HD003', 'KH003', 'NV03', 'B003', '2024-03-22', 620000, 15000),
('HD004', 'KH004', 'NV04', 'B004', '2024-03-23', 830000, 30000),
('HD005', 'KH005', 'NV05', 'B005', '2024-03-24', 910000, 35000),
('HD006', 'KH001', 'NV01', 'B001', '2025-03-24', 1000000, 50000);


CREATE TABLE ChiTietBanHang (
    MaHD VARCHAR(10),
    MaHH VARCHAR(10),
    SoLuong INT check (SoLuong > 0),
    ThanhTien NUMERIC(8,2) check (ThanhTien > 0),
    PRIMARY KEY (MaHD, MaHH),
    FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD),
    FOREIGN KEY (MaHH) REFERENCES HangHoa(MaHH)
);

INSERT INTO ChiTietBanHang (MaHD, MaHH, SoLuong, ThanhTien)
VALUES 
('HD001', 'HH001', 2, 100000.00),
('HD001', 'HH002', 1, 50000.00),
('HD002', 'HH003', 3, 225000.00),
('HD002', 'HH004', 2, 180000.00),
('HD003', 'HH005', 1, 62000.00),
('HD003', 'HH001', 2, 100000.00),
('HD004', 'HH002', 2, 100000.00),
('HD004', 'HH006', 1, 83000.00),
('HD005', 'HH003', 4, 300000.00),
('HD005', 'HH005', 2, 124000.00);


CREATE TRIGGER trg_UpdateDiemTL
ON HoaDon
AFTER INSERT
AS
BEGIN
    UPDATE KhachHang
    SET KhachHang.DiemTL = KhachHang.DiemTL + (i.TongTien * 0.0002)
    FROM INSERTED i
    WHERE KhachHang.KhID = i.KhID;
END;

CREATE TRIGGER trg_UpdateTongTienHD
ON ChiTietBanHang
AFTER INSERT 
AS
BEGIN
    UPDATE HoaDon
    SET TongTien = TongTien + i.ThanhTien
    FROM INSERTED i
    WHERE HoaDon.MaHD = i.MaHD;
END;

CREATE TRIGGER trg_CheckBanStatus
ON DatBan
AFTER INSERT, DELETE 
AS
BEGIN
    -- Handle INSERT: Set TrangThai to 'ĐÃ ĐẶT'
    IF EXISTS (SELECT 1 FROM INSERTED)
    BEGIN
        UPDATE Ban
        SET TrangThai = 'ĐÃ ĐẶT'
        FROM Ban b
        INNER JOIN INSERTED i ON b.MaBan = i.MaBan;
    END;

    -- Handle DELETE: Set TrangThai to 'CHƯA ĐẶT'
    IF EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        UPDATE Ban
        SET TrangThai = 'CHƯA ĐẶT'
        FROM Ban b
        INNER JOIN DELETED d ON b.MaBan = d.MaBan;
    END;
END;


CREATE TRIGGER trg_CheckInventoryBeforeSale
ON ChiTietBanHang
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @MaHH VARCHAR(10), @SoLuong INT;
    IF EXISTS (
        SELECT 1
        FROM INSERTED i
        JOIN HangHoa h ON i.MaHH = h.MaHH
        WHERE i.SoLuong > (
            SELECT ISNULL(SUM(SoLuong), 0) 
            FROM ChiTietNhapHang 
            WHERE MaHH = i.MaHH
        ) - (
            SELECT ISNULL(SUM(SoLuong), 0) 
            FROM ChiTietBanHang 
            WHERE MaHH = i.MaHH
        )
    )
    BEGIN
        PRINT 'Error: Not enough inventory for one or more items.';
        ROLLBACK TRANSACTION;
        RETURN;
    END;
    INSERT INTO ChiTietBanHang (MaHD, MaHH, SoLuong, ThanhTien)
    SELECT MaHD, MaHH, SoLuong, ThanhTien
    FROM INSERTED;
END;

CREATE PROCEDURE fn_DeleteDatBan
    @MaDatBan VARCHAR(10)
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM DatBan WHERE MaDatBan = @MaDatBan)
        BEGIN
            DELETE FROM DatBan WHERE MaDatBan = @MaDatBan;
            PRINT 'Reservation deleted successfully.';
        END
        ELSE
        BEGIN
            PRINT 'Reservation not found.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' + ERROR_MESSAGE();
    END CATCH
END;

-- Test for trg_UpdateDiemTL
-- Insert a new HoaDon
INSERT INTO HoaDon (MaHD, KhID, MaNV, MaBan, NgayHDBH, TongTien, DiemTL, ChiPhiKhac)
VALUES ('HD006', 'KH001', 'NV01', 'B001', '2025-03-24', 1000000, 0, 50000);

-- Check if DiemTL of KH001 is updated
SELECT KhID, DiemTL FROM KhachHang WHERE KhID = 'KH001';

-- Test for trg_UpdateTongTienHD
-- Insert a new ChiTietBanHang
INSERT INTO ChiTietBanHang (MaHD, MaHH, SoLuong, ThanhTien)
VALUES ('HD001', 'HH003', 2, 40000);

-- Check if TongTien of HD001 is updated
SELECT MaHD, TongTien FROM HoaDon WHERE MaHD = 'HD001';

-- Test for trg_CheckBanStatus (INSERT)
-- Insert a new DatBan
INSERT INTO DatBan (MaDatBan, KhID, MaBan, NgayDat)
VALUES ('DB006', 'KH002', 'B003', '2025-03-25 18:00:00');

-- Check if TrangThai of B003 is updated to 'ĐÃ ĐẶT'
SELECT MaBan, TrangThai FROM Ban WHERE MaBan = 'B003';

-- Test for trg_CheckBanStatus (DELETE)
-- Delete the DatBan
DELETE FROM DatBan WHERE MaDatBan = 'DB006';

-- Check if TrangThai of B003 is updated to 'CHƯA ĐẶT'
SELECT MaBan, TrangThai FROM Ban WHERE MaBan = 'B003';

-- Test for trg_CheckInventoryBeforeSale (Sufficient Inventory)
INSERT INTO ChiTietBanHang (MaHD, MaHH, SoLuong, ThanhTien)
VALUES ('HD002', 'HH001', 5, 125000);

-- Check if the row is inserted
SELECT * FROM ChiTietBanHang WHERE MaHD = 'HD002' AND MaHH = 'HH001';

-- Test for trg_CheckInventoryBeforeSale (Insufficient Inventory)
INSERT INTO ChiTietBanHang (MaHD, MaHH, SoLuong, ThanhTien)
VALUES ('HD002', 'HH001', 1000, 25000000);

-- Check if the row is not inserted
SELECT * FROM ChiTietBanHang WHERE MaHD = 'HD002' AND MaHH = 'HH001';

-- Test for fn_DeleteDatBan (Successful Deletion)
EXEC fn_DeleteDatBan @MaDatBan = 'DB001';

-- Check if the DatBan is deleted
SELECT * FROM DatBan WHERE MaDatBan = 'DB001';

--Cập nhật tổng tiền của hóa đơn nhập hàng khi có thêm sản phẩm
CREATE TRIGGER trg_UpdateTongTienHDNH
ON ChiTietNhapHang
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE HoaDonNhapHang
    SET TongTien = (
        SELECT SUM(ThanhTien) 
        FROM ChiTietNhapHang 
        WHERE MaHDNH = inserted.MaHDNH
    )
    FROM inserted
    WHERE HoaDonNhapHang.MaHDNH = inserted.MaHDNH;
END;

INSERT INTO ChiTietNhapHang (MaHDNH, MaSP, SoLuong, ThanhTien)
VALUES ('HDNH001', 'SP001', 10, 50000);

SELECT * FROM HoaDonNhapHang WHERE MaHDNH = 'HDNH001';

--Tính tổng doanh thu trong một khoảng thời gian
CREATE FUNCTION fn_TongDoanhThu (@startDate DATE, @endDate DATE)
RETURNS NUMERIC(10,2)
AS
BEGIN
    DECLARE @TongDoanhThu NUMERIC(10,2);
    SELECT @TongDoanhThu = SUM(TongTien) 
    FROM HoaDon
    WHERE NgayHDBH BETWEEN @startDate AND @endDate;
    
    RETURN ISNULL(@TongDoanhThu, 0);
END;

--Kiểm tra số lượng hàng trong kho trước khi bán
CREATE FUNCTION fn_KiemTraHangTrongKho (@MaSP VARCHAR(10), @SoLuong INT)
RETURNS BIT
AS
BEGIN
    DECLARE @KQ BIT;
    IF EXISTS (SELECT 1 FROM SanPham WHERE MaSP = @MaSP AND SoLuong >= @SoLuong)
        SET @KQ = 1;
    ELSE
        SET @KQ = 0;
    RETURN @KQ;
END;

SELECT dbo.fn_KiemTraHangTrongKho('SP001', 5);

