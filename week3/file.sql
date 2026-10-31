create database Bank;
use Bank;
create table Branch(
Branchname varchar(30) primary key,
Branchcity varchar(20),
Assets int);
desc Branch;
create table Bankaccount(
Accno int primary key,
Branchname varchar(20),
Balance int,
foreign key (Branchname) references Branch(Branchname));
desc Bankaccount;
create table Bankcustomer(
 customername varchar(30) primary key,
 customerstreet varchar(30),
 customercity varchar(20));
 desc Bankcustomer;
 create table Depositor(
 customername varchar(30),
 Accno int,
 primary key(customername,Accno),
 foreign key (customername) references Bankcustomer(customername),
 foreign key (Accno) references Bankaccount(Accno));
 desc Depositor;
 create table Loan(
 Loannumber int primary key,
 Branchname varchar(20),
 Amount int,
 foreign key (Branchname) references Branch(Branchname));
 desc Loan;
 Insert into Branch values
 ('SBI_Chamrajpet','Banglore',50000),
 ('SBI_Residencyroad','Banglore',10000),
 ('SBI_Shivajiroad','Bombay',20000),
 ('SBI_Parliamentroad','Delhi',10000),
 ('SBI_Jantarmantar','Delhi',20000);
 select * from Branch;
 insert into Bankcustomer values
 ('Avinash','BUll_Temple_Road','Banglore'),
 ('Dinesh','Bannerghatta_Road','Banglore'),
 ('Mohan','NationalCollege_Road','Bangore'),
 ('Nikil','Akbar_Road','Delhi'),
 ('Ravi','Prithviraj_Road','Delhi');
 select * from Bankcustomer;
 INSERT INTO BankAccount VALUES 
 (1, 'SBI_Chamrajpet', 2000),
 (2, 'SBI_ResidencyRoad', 5000),
 (3, 'SBI_ShivajiRoad', 6000),
 (4, 'SBI_ParliamentRoad', 9000),
 (5, 'SBI_Jantarmantar', 8000),
 (6, 'SBI_ShivajiRoad', 4000),
 (8, 'SBI_ResidencyRoad', 4000),
 (9, 'SBI_ParliamentRoad', 3000),
 (10, 'SBI_ResidencyRoad', 5000),
 (11, 'SBI_Jantarmantar', 2000);
 select * from BankAccount;
 insert into Depositor values
 ('Avinash',1),
 ('Dinesh',2),
 ('Nikil',4),
 ('Ravi',5),
 ('Avinash',8),
 ('Nikil',9),
 ('Dinesh',10),
 ('Nikil',11);
  select * from Depositor;
  insert into Loan values
  (1,'SBI_Chamrajpet',1000),
  (2,'SBI_Residencyroad',2000),
  (3,'SBI_Shivajiroad',3000),
  (4,'SBI_Parliamentroad',4000),
  (5,'SBI_Jantarmantar',5000);
    select * from Loan;
select Branchname,Assets/100000 as 'assets in lakhs' from Branch;
select D.customername,B.Branchname,count(*) as no_of_accounts from Depositor D,BankAccount B where D.Accno=B.Accno group by D.customername,B.Branchname having count(*)>=2;
create view Branch_Loan as select Branchname,sum(Amount) as Total_Loan from Loan group by Branchname;
select * from Branch_Loan;
select * from Loan order by Amount DESC;
create table Borrower(
customername varchar(30),
Loannumber int,
primary key(customername,Loannumber),
foreign key (customername) references Bankcustomer(customername),
foreign key (Loannumber) references Loan(Loannumber));
desc Borrower;
set SQL_SAFE_UPDATES=0;
update Branch set Assets = Assets * 1.05;
select * from Branch;
