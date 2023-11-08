 CREATE DATABASE TicketFilm;
USE TicketFilm;
CREATE TABLE tblPhim(
PhimId int auto_increment primary key,
Ten_phim varchar(30),
Loai_phim varchar(25),
Thoi_gian int
);
CREATE TABLE tblPhong(
PhongId int auto_increment primary key ,
Ten_phong varchar(20),
Trang_thai tinyint
);
CREATE TABLE tblGhe(
GheId int auto_increment primary key,
PhongId int,
foreign key (PhongId) references tblPhong(PhongId),
So_ghe varchar(10)
);
CREATE TABLE tblVe(
PhimId int,
GheId int ,
foreign key (PhimId) references tblPhim(PhimId),
foreign key (GheId) references tblGhe(GheId),
Ngay_chieu datetime,
Trang_thai varchar(20)
);

insert into tblPhim (Ten_phim, Loai_phim ,Thoi_gian) values ('Em bé Hà Nội','Tâm lý',90);
insert into tblPhim (Ten_phim, Loai_phim ,Thoi_gian) values ('NHiệm vụ bất khả thi ','Hành động',100);
insert into tblPhim (Ten_phim, Loai_phim ,Thoi_gian) values ('DỊ nhân','Viễn tưởng',90);
insert into tblPhim (Ten_phim, Loai_phim ,Thoi_gian) values ('Cuốn theo chiều gió ','Tình cảm',120);

insert into tblPhong (Ten_phong ,Trang_thai) values ('Phòng chiếu 1',1);
insert into tblPhong (Ten_phong ,Trang_thai) values ('Phòng chiếu 2',1);
insert into tblPhong (Ten_phong ,Trang_thai) values ('Phòng chiếu 3',0);

insert into tblGhe (PhongID,So_ghe) values (1,'A3');
insert into tblGhe (PhongID,So_ghe) values (1,'B5');
insert into tblGhe (PhongID,So_ghe) values (2,'A7');
insert into tblGhe (PhongID,So_ghe) values (2,'D1');
insert into tblGhe (PhongID,So_ghe) values (3,'T2');

insert into tblVe (PhimID,GheID,Ngay_chieu,Trang_thai) values(1,1,'2008-10-20','Đã bán');
insert into tblVe (PhimID,GheID,Ngay_chieu,Trang_thai) values(1,3,'2008-11-20','Đã bán');
insert into tblVe (PhimID,GheID,Ngay_chieu,Trang_thai) values(1,4,'2008-12-23','Đã bán');
insert into tblVe (PhimID,GheID,Ngay_chieu,Trang_thai) values(2,1,'2008-02-14','Đã bán');
insert into tblVe (PhimID,GheID,Ngay_chieu,Trang_thai) values(3,1,'2008-02-14','Đã bán');
insert into tblVe (PhimID,GheID,Ngay_chieu,Trang_thai) values(2,5,'2008-08-03','Chưa bán');
insert into tblVe (PhimID,GheID,Ngay_chieu,Trang_thai) values(2,3,'2008-08-03','Chưa bán');

-- Hiển thị danh sách các phim (chú ý: danh sách phải được sắp xếp theo trường Thoi_gian)
SELECT * FROM tblPhim ORDER BY Thoi_gian;

-- Hiển thị Ten_phim có thời gian chiếu dài nhất
SELECT Ten_phim , Thoi_gian FROM tblPhim ORDER BY Thoi_gian DESC LIMIT 1;

-- Hiển thị Ten_Phim có thời gian chiếu ngắn nhất
SELECT Ten_phim , Thoi_gian FROM tblPhim ORDER BY Thoi_gian LIMIT 1;

-- Hiển thị danh sách So_Ghe mà bắt đầu bằng chữ ‘A’
SELECT So_ghe FROM tblGhe WHERE So_ghe LIKE 'A%';

-- Hiển thị danh sách tên phim mà có độ dài >15 và < 25 ký tự
SELECT Ten_phim 
FROM tblPhim 
WHERE Ten_phim > 15 AND Ten_phim < 25;

-- Hiển thị Ten_Phong và Trang_Thai trong bảng tblPhong
--  trong 1 cột với tiêu đề ‘Trạng thái phòng chiếu’
SELECT CONCAT(Ten_phong, ' - ', Trang_thai) AS 'Trạng thái phòng chiếu' FROM tblPhong;


-- Tạo bảng mới có tên tblRank với các cột sau:
-- STT(thứ hạng sắp xếp theo Ten_Phim), TenPhim, Thoi_gian
CREATE TABLE tblRank AS
SELECT ROW_NUMBER() OVER (ORDER BY Ten_phim) AS STT, Ten_phim AS TenPhim, Thoi_gian
FROM tblPhim;


