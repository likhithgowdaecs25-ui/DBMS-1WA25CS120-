create database Employee;
use Employee;
CREATE TABLE Department
(
    Dept_no INT PRIMARY KEY,
    Dept_name VARCHAR(30) NOT NULL,
    Location VARCHAR(30) NOT NULL
);
desc Department;
CREATE TABLE Employee
(
    Emp_no INT PRIMARY KEY,
    Emp_name VARCHAR(30) NOT NULL,
    Manager_id INT,
    Hire_date DATE NOT NULL,
    Salary DECIMAL(10,2) CHECK (Salary >= 0),
    Dept_no INT,
    FOREIGN KEY (Manager_id) REFERENCES Employee(Emp_no),
    FOREIGN KEY (Dept_no) REFERENCES Department(Dept_no),
    CHECK (Manager_id IS NULL OR Manager_id <> Emp_no)
);
desc employee;
CREATE TABLE Project
(
    Project_no INT PRIMARY KEY,
    Project_name VARCHAR(30) NOT NULL,
    Location VARCHAR(30) NOT NULL
);
desc Project;
CREATE TABLE Works_On
(
    Emp_no INT,
    Project_no INT,
    Job_role VARCHAR(30),
    PRIMARY KEY (Emp_no, Project_no),
    FOREIGN KEY (Emp_no) REFERENCES Employee(Emp_no),
	FOREIGN KEY (Project_no) REFERENCES Project(Project_no)
);
desc Works_On;
CREATE TABLE Incentive
(
    Incentive_id INT PRIMARY KEY AUTO_INCREMENT,
    Emp_no INT,
    Incentive_date DATE,
    Incentive_amount DECIMAL(10,2)
    CHECK (Incentive_amount >= 0),
    FOREIGN KEY (Emp_no) REFERENCES Employee(Emp_no)
);
desc Incentive;
INSERT INTO Department VALUES
(1, 'HR', 'Bengaluru'),
(2, 'IT', 'Hyderabad'),
(3, 'Sales', 'Mysuru'),
(4, 'Finance', 'Chennai'),
(5, 'Marketing', 'Mumbai'),
(6, 'Production', 'Pune');
select * from department;
INSERT INTO Employee VALUES
(101, 'Ramesh', NULL, '2015-01-10', 100000, 1),
(102, 'Suresh', NULL, '2016-02-15', 110000, 2),
(103, 'Mahesh', NULL, '2014-03-20', 90000, 3),
(104, 'Rajesh', NULL, '2017-04-25', 95000, 4),
(105, 'Ganesh', NULL, '2015-05-30', 105000, 5),
(106, 'Kiran', NULL, '2018-06-12', 100000, 6);
INSERT INTO Employee VALUES
(107, 'Arun', 101, '2018-07-10', 40000, 1),
(108, 'Varun', 101, '2019-08-15', 45000, 1),
(109, 'Kumar', 101, '2019-09-20', 42000, 2),
(110, 'Manoj', 102, '2020-10-25', 50000, 2),
(111, 'Ravi', 102, '2020-11-30', 48000, 2),
(112, 'Vijay', 103, '2021-12-12', 38000, 3),
(113, 'Ajay', 104, '2019-05-10', 44000, 4),
(114, 'Sanjay', 105, '2020-06-15', 46000, 5),
(115, 'Deepak', 106, '2021-07-20', 43000, 6),
(116, 'Prakash', 106, '2022-08-25', 41000, 1);
select * from Employee;
INSERT INTO Project VALUES
(201, 'Website Development', 'Bengaluru'),
(202, 'Mobile Application', 'Hyderabad'),
(203, 'Marketing Campaign', 'Mysuru'),
(204, 'Banking System', 'Chennai'),
(205, 'Sales Management', 'Mumbai'),
(206, 'Production System', 'Pune');
select * from Project;
INSERT INTO Works_On VALUES
(101, 201, 'Manager'),(102, 202, 'Manager'),(103, 203, 'Manager'),(104, 204, 'Manager'),
(105, 205, 'Manager'),(106, 206, 'Manager'),(107, 201, 'Developer'),(108, 201, 'Tester'),
(109, 202, 'Developer'),(110, 202, 'Tester'),(111, 202, 'Developer'),(112, 203, 'Sales Executive'),
(113, 204, 'Accountant'),(114, 205, 'Marketing Executive'),(115, 206, 'Engineer'),(116, 201, 'Designer');
select * from Works_On;
INSERT INTO Incentive (Emp_no, Incentive_date, Incentive_amount) VALUES
(101, '2019-02-05', 5000),(102, '2019-02-10', 9000),(103, '2019-02-15', 8000),(104, '2019-02-20', 6000),
(105, '2019-02-25', 7000),(107, '2020-03-10', 2500),(108, '2020-04-15', 3500),(110, '2021-05-20', 4000);
select * from Incentive;
SELECT DISTINCT E.Emp_no FROM Employee E, Works_On W, Project P WHERE E.Emp_no = W.Emp_no AND W.Project_no = P.Project_no
AND P.Location IN ('Bengaluru', 'Hyderabad', 'Mysuru');
SELECT Emp_no FROM Employee WHERE Emp_no NOT IN (SELECT Emp_no FROM Incentive);
SELECT E.Emp_name, E.Emp_no, D.Dept_name,W.Job_role, D.Location, P.Location FROM Employee E, Department D,Works_On W, Project P
WHERE E.Dept_no = D.Dept_no AND E.Emp_no = W.Emp_no AND W.Project_no = P.Project_no AND D.Location = P.Location;
SELECT E.Emp_name FROM Employee E WHERE E.Emp_no IN
(SELECT Manager_id FROM Employee WHERE Manager_id IS NOT NULL GROUP BY Manager_id HAVING COUNT(*) >= ALL
    (SELECT COUNT(*) FROM Employee WHERE Manager_id IS NOT NULL GROUP BY Manager_id)
);
SELECT M.Emp_name FROM Employee M WHERE M.Emp_no IN (SELECT Manager_id FROM Employee WHERE Manager_id IS NOT NULL)
AND M.Salary >(SELECT AVG(E.Salary) FROM Employee E WHERE E.Manager_id = M.Emp_no);
SELECT DISTINCT D.Dept_name, E.Emp_name FROM Employee E, Department D WHERE E.Dept_no = D.Dept_no AND E.Manager_id IS NULL;
SELECT E.* FROM Employee E, Incentive I WHERE E.Emp_no = I.Emp_no AND I.Incentive_date BETWEEN '2019-02-01' AND '2019-02-28'
AND I.Incentive_amount =(SELECT MAX(Incentive_amount) FROM Incentive WHERE Incentive_date BETWEEN '2019-02-01' AND '2019-02-28'
    AND Incentive_amount <(SELECT MAX(Incentive_amount) FROM Incentive WHERE Incentive_date BETWEEN '2019-02-01' AND '2019-02-28')
);
SELECT E.Emp_name FROM Employee E, Employee M WHERE E.Manager_id = M.Emp_no AND E.Dept_no = M.Dept_no;
