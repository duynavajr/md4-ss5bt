CREATE DATABASE STUDENTTEST_ASUSTUFGAMING ;
USE STUDENTTEST_ASUSTUFGAMING;
CREATE TABLE test (
testID int auto_increment primary key,
name varchar(50)
);
CREATE TABLE Student(
RN int auto_increment primary key,
name varchar(50),
age int ,
status bit (1)
);
CREATE TABLE StudentTest(
RN int ,
testId int ,
foreign key (RN) references Student (RN),
foreign key (testId) references test (testId),
date datetime,
mark float
);

INSERT INTO Student(name, age) VALUES ('Nguyen Hong Ha' , 20); 
INSERT INTO Student (name, age)  VALUES ('Truong Ngoc Anh' , 30); 
INSERT INTO Student (name, age)  VALUES ('Tuan Minh' , 25); 
INSERT INTO Student (name, age)  VALUES ('Dan Truong' , 22); 

INSERT INTO Test (name) VALUES ('EPC');
INSERT INTO Test (name) VALUES ('DWMX');
INSERT INTO Test (name) VALUES ('SQL1');
INSERT INTO Test (name) VALUES ('SQL2');

INSERT INTO StudentTest VALUES (1,1,'2006-7-17',8);
INSERT INTO StudentTest VALUES (1,2,'2006-7-18',5);
INSERT INTO StudentTest VALUES (1,3,'2006-7-19',7);
INSERT INTO StudentTest VALUES (2,1,'2006-7-17',7);
INSERT INTO StudentTest VALUES (2,2,'2006-7-18',4);
INSERT INTO StudentTest VALUES (2,3,'2006-7-19',2);
INSERT INTO StudentTest VALUES (3,1,'2006-7-17',10);
INSERT INTO StudentTest VALUES (3,3,'2006-7-18',1);

-- a. Thêm ràng buộc dữ liệu cho cột age với giá trị thuộc khoảng: 15-55:
ALTER TABLE Student
MODIFY COLUMN age INT CHECK (age BETWEEN 15 AND 55);

-- b. Thêm giá trị mặc định cho cột mark trong bảng StudentTest là 0:
ALTER TABLE StudentTest
ALTER COLUMN mark SET DEFAULT 0;

-- c.Thêm khóa chính cho bảng StudentTest là (RN, TestID):
ALTER TABLE StudentTest
ADD PRIMARY KEY (RN, testID);

-- d. Thêm ràng buộc duy nhất (unique) cho cột name trên bảng Test:
ALTER TABLE Test
ADD CONSTRAINT UQ_Name UNIQUE (name);

-- e. Xóa ràng buộc duy nhất (unique) trên bảng Test:
ALTER TABLE Test
DROP INDEX UQ_Name;

-- 3.Hiển thị danh sách các học viên đã tham gia thi, các môn thi được thi bởi các học viên đó, điểm thi và ngày th
SELECT s.name AS StudentName, t.name AS TestName, st.mark, st.date
FROM Student s
JOIN StudentTest st ON s.RN = st.RN
JOIN Test t ON st.testId = t.testID;

-- 4.Hiển thị danh sách các bạn học viên chưa thi môn nào
SELECT s.RN, s.name , s.age 
FROM Student s
LEFT JOIN StudentTest st ON s.RN = st.RN
WHERE st.RN IS NULL;

-- 5.Hiển thị danh sách học viên phải thi lại, tên môn học 
-- phải thi lại và điểm thi(điểm phải thi lại là điểm nhỏ hơn 5)
SELECT s.name AS StudentName, t.name AS TestName, st.mark , st.date
FROM Student s
JOIN StudentTest st ON s.RN = st.RN
JOIN Test t ON st.testId = t.testID
WHERE st.mark < 5;
-- 6.Hiển thị danh sách học viên và điểm trung bình(Average) của các môn đã thi. Danh sách phải
-- sắp xếp theo thứ tự điểm trung bình giảm dần(nếu không sắp xếp thì chỉ được ½ số điểm) 
SELECT s.name AS StudentName, AVG(st.mark) AS AverageMark
FROM Student s
JOIN StudentTest st ON s.RN = st.RN
GROUP BY s.RN, s.name
ORDER BY AverageMark DESC;

-- 7.Hiển thị tên và điểm trung bình của học viên có điểm trung bình lớn nhất
SELECT s.name AS StudentName, AVG(st.mark) AS AverageMark
FROM Student s
JOIN StudentTest st ON s.RN = st.RN
GROUP BY s.RN, s.name
ORDER BY AverageMark DESC
LIMIT 1;

-- 8.Hiển thị điểm thi cao nhất của từng môn học. Danh sách phải được sắp xếp theo tên môn học

SELECT t.name AS TestName, MAX(st.mark) AS MaxMark
FROM Test t
LEFT JOIN StudentTest st ON t.testID = st.testId
GROUP BY t.name
ORDER BY t.name;

-- 9.Hiển thị danh sách tất cả các học viên và môn học mà các học viên
-- đó đã thi nếu học viên chưa thi môn nào thì phần tên môn học để Null 
SELECT s.name AS StudentName, t.name AS TestName
FROM Student s
LEFT JOIN StudentTest st ON s.RN = st.RN
LEFT JOIN Test t ON st.testId = t.testID;

-- 13.Hiển thị danh sách học viên và điểm thi, dánh sách phải sắp xếp tăng dần theo ngày thi
SELECT s.name AS StudentName, st.mark, st.date
FROM Student s
JOIN StudentTest st ON s.RN = st.RN
ORDER BY st.date ASC;

-- 14.Hiển thị các thông tin sinh viên có tên bắt đầu bằng ký tự ‘T’ và điểm thi trung bình >4.5.
-- Thông tin bao gồm Tên sinh viên, tuổi, điểm trung bình
SELECT name AS StudentName, age, AVG(mark) AS AverageMark
FROM Student s
JOIN StudentTest st ON s.RN = st.RN
WHERE name LIKE 'T%' 
GROUP BY s.RN, name, age
HAVING AVG(mark) > 4.5;

-- Hiển thị các thông tin sinh viên (Mã, tên, tuổi, điểm trung bình, xếp hạng). Trong đó, 
-- xếp hạng dựa vào điểm trung bình của học viên, điểm trung bình cao nhất thì xếp hạng 1.
SELECT s.RN AS StudentID, s.name AS StudentName, s.age AS Age, AVG(st.mark) AS AverageMark,
       RANK() OVER (ORDER BY AVG(st.mark) DESC) AS Ranking
FROM Student s
JOIN StudentTest st ON s.RN = st.RN
GROUP BY s.RN, s.name, s.age
ORDER BY Ranking;



