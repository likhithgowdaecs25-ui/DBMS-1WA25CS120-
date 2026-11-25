create database supplier;
use supplier;
CREATE TABLE Supplier
(
    sid INT PRIMARY KEY,
    sname VARCHAR(50),
    city VARCHAR(30)
);
desc Supplier;
CREATE TABLE Parts
(
    pid INT PRIMARY KEY,
    pname VARCHAR(50),
    color VARCHAR(20)
);
desc Parts;
CREATE TABLE Catalog
(
    sid INT,
    pid INT,
    cost DECIMAL(10,2) CHECK (cost >= 0),
    PRIMARY KEY(sid, pid),
    FOREIGN KEY(sid) REFERENCES Supplier(sid),
    FOREIGN KEY(pid) REFERENCES Parts(pid)
);
desc Catalog;
INSERT INTO Supplier VALUES
(1, 'Acme Widget Suppliers', 'Bangalore'),
(2, 'Global Suppliers', 'Mysore'),
(3, 'ABC Suppliers', 'Chennai'),
(4, 'XYZ Suppliers', 'Bangalore');
select * from supplier;
INSERT INTO Parts VALUES
(101, 'Bolt', 'Red'),
(102, 'Nut', 'Blue'),
(103, 'Gear', 'Red'),
(104, 'Screw', 'Green'),
(105, 'Washer', 'Yellow');
select * from Parts;
INSERT INTO Catalog VALUES
(1, 101, 10),(2, 101, 15),(3, 101, 8),(4, 101, 12),
(1, 102, 20),(2, 102, 18),(3, 102, 25),(4, 102, 16),
(1, 103, 30),(2, 103, 35),(3, 103, 28),
(1, 104, 12),(2, 104, 15),(3, 104, 10),
(1, 105, 40);
select * from Catalog;
SELECT DISTINCT P.pname FROM Parts P JOIN Catalog C ON P.pid = C.pid;

SELECT S.sname FROM Supplier S WHERE NOT EXISTS
(SELECT * FROM Parts P WHERE NOT EXISTS
    ( SELECT * FROM Catalog C WHERE C.sid = S.sid AND C.pid = P.pid )
);

SELECT S.sname FROM Supplier S WHERE NOT EXISTS
( SELECT * FROM Parts P WHERE P.color = 'Red' AND NOT EXISTS
    (SELECT * FROM Catalog C WHERE C.sid = S.sid AND C.pid = P.pid)
);

SELECT P.pname FROM Parts P JOIN Catalog C ON P.pid = C.pid JOIN Supplier S ON C.sid = S.sid WHERE S.sname = 'Acme Widget Suppliers'
AND NOT EXISTS ( SELECT * FROM Catalog C2 WHERE C2.pid = P.pid AND C2.sid <> S.sid);

SELECT DISTINCT C1.sid FROM Catalog C1 WHERE C1.cost > ( SELECT AVG(C2.cost) FROM Catalog C2 WHERE C2.pid = C1.pid);

SELECT P.pname, S.sname, C.cost FROM Parts P JOIN Catalog C ON P.pid = C.pid JOIN Supplier S ON C.sid = S.sid
WHERE C.cost = ( SELECT MAX(C2.cost) FROM Catalog C2 WHERE C2.pid = P.pid);
