-- 1
SELECT * FROM dept
-- 2
SELECT deptno,dname
FROM dept
-- 3 请从表EMP中查询10号部门工作的雇员姓名和工资。
SELECT ename,sal
FROM emp
WHERE deptno=10
-- 4
SELECT ename,sal
FROM emp
WHERE job IN ('clerk','manager');
-- 5
SELECT ename,deptno,sal,job
FROM emp
WHERE deptno BETWEEN 10 AND 30;
-- 6
SELECT ename,sal,job
FROM emp
WHERE ename LIKE 'j%'
-- 7
SELECT ename,job,sal
FROM emp 
WHERE sal<=2000
ORDER BY sal DESC
-- 8
SELECT ename,sal,dept.deptno,dept.loc,job
FROM emp,dept
WHERE job IN ('clerk') AND emp.deptno=dept.deptno
-- 9
SELECT f.ename emname,c.ename manager
FROM emp f
INNER JOIN emp c ON f.empno=c.mgr 
WHERE f.sal>2000

SELECT f.ename ename,c.ename manager
FROM emp f,emp c
WHERE f.empno=c.mgr AND f.sal>2000

-- 10
SELECT ename,job,sal5
FROM emp
WHERE sal>(SELECT sal FROM emp WHERE ename='james')
ORDER BY sal DESC
-- 11
SELECT ename,job,emp.deptno
FROM emp
WHERE emp.deptno NOT IN (SELECT dept.deptno FROM dept )
-- 12
SELECT ename FROM emp WHERE deptno IN(SELECT deptno FROM emp WHERE sal>=1000 AND sal<=3000)
-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
------------------------------------------------
------------------------------------------------
-- 教师任课表
CREATE TABLE teacher_info
(
	t_id INT PRIMARY KEY auto_increment,
-- 	该列有触发器生成
	t_no CHAR(14),
	t_name VARCHAR(50),
	t_password CHAR(32),
	t_sex CHAR(2),
	t_tel CHAR(11),
	t_birth CHAR(10),
	t_native_place VARCHAR (20),
	t_address CHAR(20),
-- 	0表示状态删除
	t_status INT DEFAULT 1
);

DROP TABLE teacher_info
-- 课程信息表
CREATE TABLE course_info
(
	c_id INT PRIMARY KEY auto_increment,
	c_no CHAR(5),
	c_name VARCHAR(100),
	c_grade INT(2),
	c_status INT DEFAULT 1
);

-- 教师任课表
CREATE TABLE c_t_info
(
	ct_id INT PRIMARY KEY auto_increment,
	ct_t_id INT,
	ct_c_id INT,
	ct_relnum INT DEFAULT 0,
	ct_max INT(3),
	ct_min INT(3),
	ct_start CHAR(10),
	ct_end CHAR(10)
);
DROP TABLE c_t_info;
-- 学生信息表
CREATE TABLE student_info
(
	s_id INT PRIMARY KEY auto_increment,
	s_no CHAR(14),
	s_name VARCHAR(30),
	s_sex CHAR(2),
	s_tel CHAR(11),
	s_native_place VARCHAR (20),
	s_password CHAR(32),
	s_status INT DEFAULT 1
);
DROP TABLE student_info;


-- 选课信息表
CREATE TABLE c_s_info
(
	cs_id INT PRIMARY KEY auto_increment,
	cs_s_id INT,
	cs_ct_id INT,
	cs_grade DECIMAL(3,1)  
);
DROP TABLE c_s_info;

-- 管理员信息表
CREATE TABLE manager_info
(
	m_id INT PRIMARY KEY auto_increment,
	m_no CHAR(5),
	m_name VARCHAR(30),
	m_tel CHAR(11),
	m_password CHAR(32),
	m_status INT DEFAULT 1
);
DROP TABLE manager_info;
-- 如果触发器修改的是 触发的表本身  before
-- 修改的是被影响的表  after
--

CREATE TRIGGER trig_course_no
BEFORE 
	INSERT 
ON course_info
for EACH ROW
BEGIN
-- 	SET new.c_no='c1001';
	DECLARE n CHAR(5);        
-- 声明一个5个长度的char 类型的变量 用于存放表中最大的编号
-- 	用于获取编号 整数部分并加1
	DECLARE m INT;
	
	SET n=(SELECT MAX(c_no) FROM course_info);
-- 	判断n 是否为null
	IF n IS NULL THEN
		SET n='c1000';
	END IF;
-- 获取后 4位
	SET m=SUBSTRING(n,2)+1;
	SET new.c_no=CONCAT('c',m);
END;
-- c1001
--  +1
-- c1002
-- SUBSTRING(str,pos,len) 不指明长度 截取到尾部
-- CONCAT(str1,str2,...)  拼接字符串 str1str2

CREATE TRIGGER trig_student_no
BEFORE 
	INSERT 
ON student_info
for EACH ROW
BEGIN
	SET new.s_no=DATE_FORMAT(SYSDATE(),'%Y%m%d%H%i%s');
END;



CREATE TRIGGER trig_manager_no
BEFORE 
	INSERT 
ON manager_info
for EACH ROW
BEGIN
-- 	SET new.c_no='c1001';
	DECLARE n CHAR(5);        
-- 声明一个5个长度的char 类型的变量 用于存放表中最大的编号
-- 	用于获取编号 整数部分并加1
	DECLARE m INT;
	
	SET n=(SELECT MAX(m_no) FROM manager_info);
-- 	判断n 是否为null
	IF n IS NULL THEN
		SET n='m1000';
	END IF;
-- 获取后 4位
	SET m=SUBSTRING(n,2)+1;
	SET new.m_no=CONCAT('m',m);
END;


SELECT max(c_no) FROM course_info;



-- 给学生选课表添加触发器
-- 学生选择一门课程 该门课程的人数加 1
-- 学生退出一门课程 该门课程的人数 减 1

-------------------------------------------
-------------------------------------------
-------------------------------------------
CREATE TRIGGER trig_cs_insert
AFTER
	INSERT
ON c_s_info
FOR EACH ROW 
BEGIN
	UPDATE c_t_info
	SET ct_relnum=ct_relnum+1
	WHERE ct_id=new.cs_ct_id;
END;
CREATE TRIGGER trig_cs_delete
AFTER 
	DELETE 
ON c_s_info
FOR EACH ROW
BEGIN
	UPDATE c_t_info
	SET ct_relnum=ct_relnum-1
	WHERE ct_id=old.cs_ct_id;
END;

DROP TRIGGER trig_cs_delete;
DROP TRIGGER trig_cs_insert;
;
INSERT INTO c_s_info(cs_ct_id,cs_s_id)
VALUES (2,1);


INSERT INTO teacher_info(t_no,t_name)
VALUES('t1001','吾王');
INSERT INTO c_t_info(ct_t_id,ct_c_id,ct_max)
VALUES(1,3,30);
INSERT INTO c_t_info(ct_t_id,ct_c_id,ct_max)
VALUES(1,5,30);

SELECT * FROM c_t_info;
SELECT * FROM student_info;


SELECT * FROM c_s_info;

DELETE FROM c_s_info WHERE cs_id=1;
DELETE FROM c_t_info;
SELECT * FROM student_info;

---------------------------------------------------
--------------------------------------------------------
-----------------------------------------------------------
---------------------------------------------------------
-----------------------------------------------------------
DELETE FROM course_info;
DELETE FROM manager_info;
DELETE FROM student_info;
DELETE FROM teacher_info;
DELETE FROM c_s_info;


INSERT INTO student_info(s_name,s_sex,s_tel,s_native_place,s_password)
VALUES('土肥圆','男','11111111111','Japan','123456');
INSERT INTO student_info(s_name,s_sex,s_tel,s_native_place,s_password)
VALUES('胖子','男','22222222222','China','123456');
INSERT INTO student_info(s_name,s_sex,s_tel,s_native_place,s_password)
VALUES('傻子东','男','33333333333','England','123456');
INSERT INTO student_info(s_name,s_sex,s_tel,s_native_place,s_password)
VALUES('帅哥林','男','44444444444','China','123456');
INSERT INTO student_info(s_name,s_sex,s_tel,s_native_place,s_password)
VALUES('山本五十六','男','55555555555','Japan','123456');

INSERT INTO teacher_info(t_no,t_name,t_password,t_sex,t_tel,t_birth,t_native_place,t_address)
VALUES('t10001','贤二','123456','男','1234567891','19960501','Janpan','BeiJing');
INSERT INTO teacher_info(t_no,t_name,t_password,t_sex,t_tel,t_birth,t_native_place,t_address)
VALUES('t10002','贤三','123456','女','1234567891','19960502','Janpan','BeiJing');
INSERT INTO teacher_info(t_no,t_name,t_password,t_sex,t_tel,t_birth,t_native_place,t_address)
VALUES('t10003','贤四','123456','男','1234567891','19960503','Janpan','BeiJing');
INSERT INTO teacher_info(t_no,t_name,t_password,t_sex,t_tel,t_birth,t_native_place,t_address)
VALUES('t10004','贤五','123456','女','1234567891','19960504','Janpan','BeiJing');
INSERT INTO teacher_info(t_no,t_name,t_password,t_sex,t_tel,t_birth,t_native_place,t_address)
VALUES('t10005','贤六','123456','男','1234567891','19960505','Janpan','BeiJing');

SELECT * FROM teacher_info;

INSERT INTO manager_info(m_name,m_tel,m_password)
VALUES('太阳骑士1','15487965471','123456');
INSERT INTO manager_info(m_name,m_tel,m_password)
VALUES('太阳骑士2','15487965472','123456');
INSERT INTO manager_info(m_name,m_tel,m_password)
VALUES('太阳骑士3','15487965473','123456');
INSERT INTO manager_info(m_name,m_tel,m_password)
VALUES('太阳骑士4','15487965474','123456');
INSERT INTO manager_info(m_name,m_tel,m_password)
VALUES('太阳骑士5','15487965475','123456');

SELECT * FROM manager_info;
SELECT * FROM course_info;
INSERT INTO course_info(c_name,c_grade)
VALUES('c++',8);
INSERT INTO course_info(c_name,c_grade)
VALUES('java',5);
INSERT INTO course_info(c_name,c_grade)
VALUES('c#',6);
INSERT INTO course_info(c_name,c_grade)
VALUES('pathon',7);
INSERT INTO course_info(c_name,c_grade)
VALUES('html',9);

SELECT * FROM c_t_info;
INSERT INTO c_t_info(ct_t_id,ct_c_id,ct_max,ct_min)
VALUES(1,3,30,30);
INSERT INTO c_t_info(ct_t_id,ct_c_id,ct_max,ct_min)
VALUES(2,1,30,30);
INSERT INTO c_t_info(ct_t_id,ct_c_id,ct_max,ct_min)
VALUES(1,2,30,30);
INSERT INTO c_t_info(ct_t_id,ct_c_id,ct_max,ct_min)
VALUES(3,5,30,30);
INSERT INTO c_t_info(ct_t_id,ct_c_id,ct_max,ct_min)
VALUES(2,4,30,30);

SELECT * FROM c_s_info;
INSERT INTO c_s_info(cs_s_id,cs_ct_id)
VALUES (2,1);
INSERT INTO c_s_info(cs_s_id,cs_ct_id)
VALUES (3,2);
INSERT INTO c_s_info(cs_s_id,cs_ct_id)
VALUES (4,3);
INSERT INTO c_s_info(cs_s_id,cs_ct_id)
VALUES (5,4);
INSERT INTO c_s_info(cs_s_id,cs_ct_id)
VALUES (1,5);
-- 1
SELECT t_name,c_name
FROM teacher_info t,course_info c,c_t_info ct
WHERE t.t_id=ct.ct_t_id AND c.c_id=ct.ct_c_id;
-- 2
SELECT s_name,c_name
FROM student_info,course_info,c_s_info
WHERE s_id=cs_s_id AND c_id=(SELECT ct_c_id FROM c_t_info WHERE cs_ct_id =ct_id);
-- 3
SELECT t_name,s_name,c_name
FROM teacher_info,course_info,c_t_info,c_s_info,student_info
WHERE t_id=ct_t_id AND c_id =ct_c_id AND s_id=cs_s_id 
			AND c_id=(SELECT ct_c_id FROM c_t_info WHERE cs_ct_id =ct_id);


-- 查询的数据如果来源于多张表 必须使用视图
-- 简化sql的复杂度
CREATE VIEW lalala
AS 
	SELECT t_name,s_name,c_name
	FROM teacher_info,course_info,c_t_info,c_s_info,student_info
	WHERE t_id=ct_t_id AND c_id =ct_c_id AND s_id=cs_s_id 
			AND c_id=(SELECT ct_c_id FROM c_t_info WHERE cs_ct_id =ct_id);

SELECT * FROM lalala;
	
SELECT * FROM course_info;
INSERT INTO course_info(c_name,c_grade)
VALUES(?,?)