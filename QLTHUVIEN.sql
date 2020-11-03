CREATE DATABASE QLTHUVIEN 
USE QLTHUVIEN

GO
CREATE TABLE [THAMSO](  
[TenThamSo] [nvarchar](40) NOT NULL,  
[GiaTri] [int] NULL,  
CONSTRAINT [PK_THAMSO] PRIMARY KEY (TenThamSo) ) 

CREATE TABLE [BANGCAP](  
[MaBangCap] int Identity(1,1),  
[TenBangCap] [nvarchar](40) NULL,  
CONSTRAINT [PK_BANGCAP] PRIMARY KEY (MaBangCap) ) 

CREATE TABLE [NHANVIEN](  
[MaNhanVien] int Identity(1,1),  
[HoTenNhanVien] [nvarchar](50) NULL,  
[NgaySinh] [datetime] NULL,  
[DiaChi] [nvarchar](50) NULL,  
[DienThoai] [nvarchar](15) NULL,  
[MaBangCap] [int] NULL,  
CONSTRAINT [PK_NHANVIEN] PRIMARY KEY (MaNhanVien) )

CREATE TABLE [DOCGIA](  
[MaDocGia] int Identity(1,1),  
[HoTenDocGia] [nvarchar](40) NULL,  
[NgaySinh] [datetime] NULL,  
[DiaChi] [nvarchar](50) NULL,  
[Email] [nvarchar](30) NULL,  
[NgayLapThe] [datetime] NULL,  
[NgayHetHan] [datetime] NULL,  
[TienNo] [float] NULL,  
CONSTRAINT [PK_DOCGIA_1] PRIMARY KEY (MaDocGia) ) 

CREATE TABLE [PHIEUTHUTIEN](  
[MaPhieuThuTien] int Identity(1,1),  
[SoTienNo] [float] NULL,  
[SoTienThu] [float] NULL,  
[MaDocGia] [int] NULL,  
[MaNhanVien] [int] NULL,  
CONSTRAINT [PK_PHIEUTHUTIEN] PRIMARY KEY (MaPhieuThuTien) ) 

CREATE TABLE [SACH](  
[MaSach] int Identity(1,1),  
[TenSach] [nvarchar](40) NULL,  
[TacGia] [nvarchar](30) NULL,  
[NamXuatBan] [int] NULL,  
[NhaXuatBan] [nvarchar](40) NULL,  
[TriGia] [float] NULL,  
[NgayNhap] [datetime] NULL,  
CONSTRAINT [PK_SACH] PRIMARY KEY (MaSach) ) 

CREATE TABLE [PHIEUMUONSACH](  
[MaPhieuMuon] int Identity(1,1),  
[NgayMuon] [datetime] NOT NULL,  
[MaDocGia] [int] NULL,  
CONSTRAINT [PK_PHIEUMUONSACH] PRIMARY KEY (MaPhieuMuon) )

CREATE TABLE [CHITIETPHIEUMUON](  
[MaSach] [int] NOT NULL,  
[MaPhieuMuon] [int] NOT NULL,  
CONSTRAINT [PK_CHITIETPHIEUMUON] PRIMARY KEY (MaSach,MaPhieuMuon) ) 

create view Viewer
As 
Select MaNhanVien, HoTenNhanVien, NgaySinh, BangCap.TenBangCap, NhanVien.MaBangCap
From NhanVien, BangCap
Where NhanVien.MaBangCap = BangCap.MaBangCap

create view ViewSach1
As
Select dg.MaDocGia, dg.HoTenDocGia, s.TenSach, ctpm.MaPhieuMuon, pm.NgayMuon from SACH s, docgia dg, phieumuonsach pm, chitietphieumuon ctpm
	where		pm.MaDocGia = dg.MaDocGia 
			and s.MaSach = ctpm.MaSach 
			and pm.MaPhieuMuon = ctpm.MaPhieuMuon 


Select * From ViewSach1
Select * from Viewer where MaBangCap = 1

ALTER TABLE [NHANVIEN]  
WITH NOCHECK ADD  CONSTRAINT [FK_NHANVIEN_BANGCAP] 
FOREIGN KEY([MaBangCap]) 
REFERENCES [BANGCAP] ([MaBangCap]) 
ON UPDATE CASCADE 
ON DELETE CASCADE 
GO 
ALTER TABLE [NHANVIEN] 
CHECK CONSTRAINT [FK_NHANVIEN_BANGCAP] 
GO 
ALTER TABLE [PHIEUTHUTIEN] 
WITH CHECK ADD  CONSTRAINT [FK_PHIEUTHUTIEN_DOCGIA] 
FOREIGN KEY([MaDocGia]) REFERENCES [DOCGIA] ([MaDocGia])
GO 
ALTER TABLE [PHIEUTHUTIEN] 
CHECK CONSTRAINT [FK_PHIEUTHUTIEN_DOCGIA] 
GO 
ALTER TABLE [PHIEUTHUTIEN]  
WITH CHECK ADD  CONSTRAINT [FK_PHIEUTHUTIEN_NHANVIEN] FOREIGN KEY([MaNhanVien]) 
REFERENCES [NHANVIEN] ([MaNhanVien])
ON UPDATE CASCADE 
ON DELETE CASCADE 
GO 
ALTER TABLE [PHIEUTHUTIEN] 
CHECK CONSTRAINT [FK_PHIEUTHUTIEN_NHANVIEN] 
GO 
ALTER TABLE [PHIEUMUONSACH]  
WITH CHECK ADD  CONSTRAINT [FK_PHIEUMUONSACH_DOCGIA] FOREIGN KEY([MaDocGia]) 
REFERENCES [DOCGIA] ([MaDocGia]) 
ON UPDATE CASCADE 
ON DELETE CASCADE 
GO 
ALTER TABLE [PHIEUMUONSACH] 
CHECK CONSTRAINT [FK_PHIEUMUONSACH_DOCGIA] 
GO 
ALTER TABLE [CHITIETPHIEUMUON]  
WITH CHECK ADD  CONSTRAINT [FK_CHITIETPHIEUMUON_PHIEUMUONSACH] FOREIGN KEY([MaPhieuMuon]) 
REFERENCES [PHIEUMUONSACH] ([MaPhieuMuon]) 
GO 
ALTER TABLE [CHITIETPHIEUMUON] CHECK CONSTRAINT [FK_CHITIETPHIEUMUON_PHIEUMUONSACH] 
GO 
ALTER TABLE [CHITIETPHIEUMUON]  WITH CHECK ADD  CONSTRAINT [FK_CHITIETPHIEUMUON_SACH] FOREIGN KEY([MaSach]) 
REFERENCES [SACH] ([MaSach]) 
ON UPDATE CASCADE 
ON DELETE CASCADE 
GO 
ALTER TABLE [CHITIETPHIEUMUON] CHECK CONSTRAINT [FK_CHITIETPHIEUMUON_SACH]


insert into THAMSO values(N'THAM SỐ 1',1)
insert into THAMSO values(N'THAM SỐ 2',2)
insert into THAMSO values(N'THAM SỐ 3',3)
insert into THAMSO values(N'THAM SỐ 4',4)
select * from THAMSO

insert into BANGCAP values(N'TIẾN SĨ') 
insert into BANGCAP values(N'THẠC SĨ') 
insert into BANGCAP values(N'ÐẠI HỌC') 
insert into BANGCAP values(N'CAO ÐẲNG') 
insert into BANGCAP values(N'TRUNG CẤP') 
select * from BANGCAP
 
insert into NHANVIEN values(N'PHẠM ĐÀO MINH VŨ','01/24/1980',N'163/30 Thành Thái F.14 Q.10 TPHCM','0905646162',1) 
insert into NHANVIEN values(N'NGUYỄN MINH THÀNH','04/05/1983',N'41/4 CALMETTE Q1 TPHCM','0908373612',2) 
insert into NHANVIEN values(N'NGUYỄN HÀ MY','04/13/1985',N'178 NAM KỲ KHỞI NGHĨA Q4 TPHCM','0908783274',3) 
select * from NHANVIEN 


insert into DOCGIA values(N'NGUYỄN HOÀNG MINH','02/23/1990',N'41/4 CALMETTE Q1 TPHCM',N'hoangminh@yahoo.com','12/30/2000','12/30/2012',21.0) 
insert into DOCGIA values(N'TRẦN VÃN CHÂU','08/29/1992',N'TRẦN HÝNG ÐẠO Q1 TPHCM',N'vanchau@yahoo.com','11/22/2001','11/22/2013',0) 
insert into DOCGIA values(N'TRẦN VÃN TRUNG','09/22/1992',N'NGUYỄN CHÍ THÀNH P5 TPVL',N'thanhtrung@yahoo.com','11/20/2001','11/20/2020',0) 
select * from DOCGIA 
delete from DOCGIA WHERE MaDocGia = 16

insert into SACH values(N'NHẬP MÔN CNPM',N'PHẠM ÐÀO MINH VŨ',2007,N'NXB THỐNG KÊ',70000,'12/18/2008') 
insert into SACH values(N'KỸ THUẬT LẬP TRÌNH',N'TRẦN MINH THÁI',2005,N'NXB GIÁO DỤC',50000,'02/12/2006')
insert into SACH values(N'CÔNG NGHỆ WEB',N'PHẠM ÐÀO MINH VŨ',2009,N'NXB TRẺ',90000,'12/01/2009')
select * from SACH

insert into PHIEUMUONSACH values('01/02/2020',1)
insert into PHIEUMUONSACH values('04/02/2020',1)
insert into PHIEUMUONSACH values('01/11/2020',1)

select * from PHIEUMUONSACH

insert into CHITIETPHIEUMUON values(1,1)
insert into CHITIETPHIEUMUON values(2,2)
insert into CHITIETPHIEUMUON values(3,3)
select * from CHITIETPHIEUMUON

insert into PHIEUTHUTIEN values(5.5,2.5,1,2)
insert into PHIEUTHUTIEN values(5.0,2.8,1,2)
insert into PHIEUTHUTIEN values(10.5,0.5,1,2)
select * from PHIEUTHUTIEN


delete from PHIEUTHUTIEN
Select * from SACH, PHIEUMUONSACH,
            CHITIETPHIEUMUON where SACH.MaSach = CHITIETPHIEUMUON.MaSach 
			OR PHIEUMUONSACH.MaPhieuMuon = CHITIETPHIEUMUON.MaPhieuMuon
			OR PHIEUMUONSACH.MaDocGia = 1

Select * from ChiTietPhieuMuon Order By
            MaPhieuMuon

Select * from ChiTietPhieuMuon where
            MaPhieuMuon = 1
            Order By MaPhieuMuon

Select SUM(TienNo) as TongTienNo From DOCGIA
Select MaDocGia, HoTenDocGia, TienNo, Sum(TienNo) as TonTienNo from DOCGIA Group By MaDocGia, HoTenDocGia, TienNo
Select * from DOCGIA
Update SACH set TenSach = N'a',
				TacGia = N'b',
				NamXuatBan = 3,
				NhaXuatBan = N'',
				TriGia = 2000,
				NgayNhap = ''
		where MaSach = 3

Select * From Nhanvien
Select MaNhanVien, HoTenNhanVien, NgaySinh, BangCap.TenBangCap
                        From NhanVien Inner Join BangCap On NhanVien.MaBangCap = BangCap.MaBangCap
                        
Select HoTenDocGia, TienNo, NgayLapThe, NgayHetHan from DOCGIA Where TienNo <> 0

USE QLTHUVIEN
Select MaNhanVien, HoTenNhanVien, NgaySinh, BangCap.TenBangCap
                        From NhanVien Inner Join BangCap On NhanVien.MaBangCap = BangCap.MaBangCap

Select dg.MaDocGia, dg.HoTenDocGia, s.TenSach, ctpm.MaPhieuMuon, pm.NgayMuon from SACH s, docgia dg, phieumuonsach pm, chitietphieumuon ctpm
	where		pm.MaDocGia = dg.MaDocGia 
			and s.MaSach = ctpm.MaSach 
			and pm.MaPhieuMuon = ctpm.MaPhieuMuon 
			and pm.MaDocGia = 1

Select * from SACH
Select * from CHITIETPHIEUMUON
Select * from PHIEUMUONSACH
Select * from DOCGIA


