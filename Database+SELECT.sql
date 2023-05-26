/*USE model;
DROP DATABASE test;*/
CREATE DATABASE testdb;
USE testdb;

CREATE TABLE Customers (
CusID INT PRIMARY KEY,
CusName varchar (40) NOT NULL,
CusPhone varchar (20) NOT NULL,
CusGender varchar (1) NOT NULL, 
CusEmail varchar (50) NOT NULL,
CusDiscount INT NOT NULL
);
GO

ALTER TABLE Customers DROP COLUMN CusDiscount;
ALTER TABLE Customers ADD CusDiscount varchar(10);
ALTER TABLE Customers ALTER COLUMN CusDiscount INT NOT NULL;
GO

CREATE TABLE _Furniture (
IDFurniture INT PRIMARY KEY,
FurnitureName varchar (50) NOT NULL,
FurnitureDescription varchar(30) NOT NULL,
FurnitureYear DATE NOT NULL,
FurnitureManufacture varchar (30) NOT NULL,
FurniturePrice FLOAT NOT NULL,
FurnitureAmount INT NOT NULL
);
GO
CREATE TABLE _Delivery (
DelivID INT PRIMARY KEY,
DelivAddress varchar (40) NOT NULL,
DelivDescription varchar (255) NOT NULL,
CusPhone varchar (10) NOT NULL
);
GO
CREATE TABLE Employee (
EmployeeID INT PRIMARY KEY,
EmployeeName varchar(40) NOT NULL,
EmployeePosition varchar(40) NOT NULL
);
GO

CREATE TABLE _ORDERS (
OrderID varchar (10) PRIMARY KEY,
OrderStartDate DATE NOT NULL,
OrderEndDate DATE NOT NULL,
CusID INT NOT NULL,
IDFurniture int NOT NULL,
DelivID INT NOT NULL,
EmployeeID INT NOT NULL
);
GO
ALTER TABLE _ORDERS ADD FOREIGN KEY (CusID) REFERENCES Customers(CusID);
ALTER TABLE _ORDERS ADD FOREIGN KEY (IDFurniture) REFERENCES _Furniture(IDFurniture);
ALTER TABLE _ORDERS ADD FOREIGN KEY (DelivID) REFERENCES _Delivery(DelivID);
ALTER TABLE _ORDERS ADD FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID);
GO
INSERT INTO Customers VALUES
(1, '��� ��������', '0978654321', 'F', 'yulia@gmail.com', 300),
(2, '�������� ������', '0988345761', 'F', 'anasteisha@gmail.com', 100),
(3, '����� ������', '0503418759', 'M', 'taras@gmail.com', 50),
(4, '����� ����', '0503413562', 'M', 'nazar@gmail.com', 20),
(5, '������ �����', '0986754334', 'F', 'natali@gmail.com', 100),
(6, '������ ����', '0506746633', 'F', 'solomiya@gmail.com', 100),
(7, '��� ����������', '0974306546', 'F', 'yulia.star@gmail.com', 120),
(8, '�������� ������', '0662819231', 'M', 'stas@gmail.com', 200),
(9, '����� �����', '0930338669', 'M', 'roman@gmail.com', 200),
(10, '��� ��������', '0980337828', 'F', 'julias@gmail.com', 50);
GO
INSERT INTO _Furniture VALUES(
1, '����-����', '������ ����', '2020-04-30', 'IKEA', 7000.0, 2),
(2, '�����', '������ �����', '2021-09-01', 'JYSK', 3500.0, 4),
(3, '���', '��������� ��� ��� ����', '2020-03-12', 'IKEA', 4000.0, 1),
(4, '�����', '�����-��������', '2021-03-01', 'IKEA', 2000.0, 1),
(5, '����', '���� � ���� �����', '2020-10-12', 'JYSK', 12000.0, 2),
(6, '����-����', '����-���� ��� �������', '2022-05-13', 'JYSK', 10000.0, 1),
(7, '���', '��� ���������', '2020-09-30', 'JYSK', 3500.0, 2),
(8, '�����', '����� ������', '2020-01-28', 'IKEA', 1000.0, 4),
(9, '�����', '����� ����������', '2021-05-07', 'JYSK', 5500.0, 1),
(10, '�����', '����� �� �������', '2022-11-11', 'IKEA', 6000.0, 2);
GO
INSERT INTO _Delivery VALUES (
1, '������� 43/6', '�������� �������', '0978654321'),
(2, '������ 21/2', '������ �� ������ ��������', '0988345761'),
(3, '������� 96/25', '³������� �� �������', '0503418759'),
(4, '��.����� 5/5', '³������� ����� �� ��������', '0503413562'),
(5, '��������� 100/75', '� ������� ��������� ���', '0986754334'),
(6, '�������� 23/1', '���� �������', '0506746633'),
(7, '�������� 14/74', '�������� �������', '0974306546'),
(8, '�������� 10/2', '�������� ������ ������', '662819231'),
(9, '������ 43/21', '���� �������� 25.12', '0930338669'),
(10, '������� 100/4', '������� ���!', '0980337828');
GO
INSERT INTO Employee VALUES (
1, '������ ������','���������'),
(2, '������ �������','���������'),
(3, '������ ����','���������');
GO
INSERT INTO _ORDERS VALUES (
1, '2022-11-01', '2022-11-14', 1,1,1,1),
(2, '2022-11-03', '2022-11-09', 2,2,2,1),
(3, '2022-11-07', '2022-11-08', 3,3,3,2),
(4, '2022-11-17', '2022-11-29', 4,4,4,2),
(5, '2022-11-17', '2022-11-22', 5,5,5,3),
(6, '2022-11-17', '2022-11-20', 6,6,6,1),
(7, '2022-11-19', '2022-11-26', 7,7,7,3),
(8, '2022-11-21', '2022-11-25', 8,8,8,2),
(9, '2022-11-22', '2022-11-29', 9,9,9,1),
(10, '2022-11-23', '2022-11-29', 10,10,10,3);
GO



/*����� � join ��� ��������� ������ ������������ � ���� ���������*/
Select Customers.CusID, Customers.CusName, _Furniture.FurnitureName From _ORDERS 
join Customers  on _ORDERS.CusID = Customers.CusID
join _Furniture  on _Furniture.IDFurniture = _ORDERS.IDFurniture
order by Customers.CusName;

/*����� � join ��� ��������� ������ ������������ � ���������� �� �� �������������*/

Select Customers.CusID, Customers.CusName, Employee.EmployeeName From _ORDERS 
join Customers  on _ORDERS.CusID = Customers.CusID
right join Employee  on Employee.EmployeeID = _ORDERS.EmployeeID;

/*����� � join ��� ����������� ��� ��������� � ������� �������� � ������
������������ �� ������*/
Select _ORDERS.OrderID, _Furniture.FurnitureName, _Delivery.DelivAddress, _Delivery.DelivDescription From _ORDERS 
join _Furniture  on _ORDERS.IDFurniture = _Furniture.IDFurniture
join _Delivery  on _ORDERS.DelivID = _Delivery.DelivID
order by _Delivery.DelivAddress;

/*����� � join ��� ��������� ID ����������, ��� �����������, ���� ���������� � ������� �
���� ���������� ���� ������� ����������*/
Select _ORDERS.OrderID, Customers.CusName, _Furniture.FurnitureName, _Delivery.DelivAddress, Employee.EmployeeName From _ORDERS 
join Customers  on _ORDERS.CusID = Customers.CusID
join _Furniture  on _ORDERS.IDFurniture = _Furniture.IDFurniture
join _Delivery  on _ORDERS.DelivID = _Delivery.DelivID
join Employee  on _ORDERS.EmployeeID = Employee.EmployeeID;


/*����� � join ��� ��������� ��� ���������� ������ � ������ ��� ������� 
���������� ������������ �� ������ ������*/
Select Employee.EmployeeName, _Furniture.FurnitureName, _Furniture.FurnitureDescription From _ORDERS join Employee 
on _ORDERS.EmployeeID = Employee.EmployeeID
join _Furniture  on _ORDERS.IDFurniture = _Furniture.IDFurniture
order by _Furniture.FurnitureName;




/*����� ��� ��������� ������ ����� ��������� ������� ���������
������������ �� ������� �� ���������*/
Select Employee.EmployeeName, Count(_ORDERS.OrderID) as 'Number ot orders'
From _ORDERS  join Employee  
on _ORDERS.EmployeeID = Employee.EmployeeID
Group by Employee.EmployeeName
Order by Count(_ORDERS.OrderID) DESC;


/*����� ��� ��������� ������ ����� ���������(ID,Name) ����� ������� */
Select Employee.EmployeeID, Employee.EmployeeName, SUM(_Furniture.FurniturePrice) as 'order amount' from _ORDERS join Employee  
on _ORDERS.EmployeeID = Employee.EmployeeID
join _Furniture  
on _ORDERS.IDFurniture = _Furniture.IDFurniture
Group by Employee.EmployeeID, Employee.EmployeeName

/*����� ��� ��������� �������� ������� ����������*/
Select AVG(_Furniture.FurniturePrice) as 'average price' from _ORDERS 
join _Furniture 
on _ORDERS.IDFurniture = _Furniture.IDFurniture;

/*����� ��� ��������� �������� ���� ��������� ��� ������� �����������
������������ �� �����*/
Select Customers.CusName, SUM(_Furniture.FurniturePrice) from _ORDERS join Customers  
on _ORDERS.CusID = Customers.CusID
join _Furniture  
on _ORDERS.IDFurniture = _Furniture.IDFurniture
Group by Customers.CusName
Order by SUM(_Furniture.FurniturePrice);

/*����� ��� ��������� ������ ���� ��������� ����� �����*/
Select _Furniture.FurnitureName, COUNT(_Furniture.FurnitureName) as 'times' from _ORDERS join _Furniture  
on _ORDERS.IDFurniture = _Furniture.IDFurniture
Group by _Furniture.FurnitureName;

/*����� ��� ��������� �������� ������� ������� ������*/
Select Sum(FurnitureAmount) as 'furniure amount' from _Furniture;

/*����� ��� ���������� ����� �� ����� �������*/
Select FurnitureYear, COUNT(FurnitureYear) as 'year count' from _Furniture
Group by FurnitureYear;


