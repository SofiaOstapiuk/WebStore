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
(1, 'Юлія Сафонова', '0978654321', 'F', 'yulia@gmail.com', 300),
(2, 'Анастасія Коваль', '0988345761', 'F', 'anasteisha@gmail.com', 100),
(3, 'Тарас Мегера', '0503418759', 'M', 'taras@gmail.com', 50),
(4, 'Назар Пиць', '0503413562', 'M', 'nazar@gmail.com', 20),
(5, 'Наталя Кунта', '0986754334', 'F', 'natali@gmail.com', 100),
(6, 'Соломія Вища', '0506746633', 'F', 'solomiya@gmail.com', 100),
(7, 'Юлія Таробарова', '0974306546', 'F', 'yulia.star@gmail.com', 120),
(8, 'Станіслав Топчій', '0662819231', 'M', 'stas@gmail.com', 200),
(9, 'Роман Гриць', '0930338669', 'M', 'roman@gmail.com', 200),
(10, 'Юлія Петренко', '0980337828', 'F', 'julias@gmail.com', 50);
GO
INSERT INTO _Furniture VALUES(
1, 'Шафа-купе', 'Велика шафа', '2020-04-30', 'IKEA', 7000.0, 2),
(2, 'Крісло', 'Зручне крісло', '2021-09-01', 'JYSK', 3500.0, 4),
(3, 'Стіл', 'Деревяний стіл для кухні', '2020-03-12', 'IKEA', 4000.0, 1),
(4, 'Крісло', 'Крісло-гойдалка', '2021-03-01', 'IKEA', 2000.0, 1),
(5, 'Шафа', 'Шафа в стилі гранд', '2020-10-12', 'JYSK', 12000.0, 2),
(6, 'Шафа-купе', 'Шафа-купе для прихожої', '2022-05-13', 'JYSK', 10000.0, 1),
(7, 'Стіл', 'Стіл письмовий', '2020-09-30', 'JYSK', 3500.0, 2),
(8, 'Крісло', 'Крісло кухоне', '2020-01-28', 'IKEA', 1000.0, 4),
(9, 'Диван', 'Диван розкладний', '2021-05-07', 'JYSK', 5500.0, 1),
(10, 'Диван', 'Диван із сховком', '2022-11-11', 'IKEA', 6000.0, 2);
GO
INSERT INTO _Delivery VALUES (
1, 'Бойчука 43/6', 'Доставте зібраним', '0978654321'),
(2, 'Боткіна 21/2', 'Надіюсь на швидку доставку', '0988345761'),
(3, 'Наукова 96/25', 'Відправте ще каталог', '0503418759'),
(4, 'Кн.Ольги 5/5', 'Відправте разом із грущиком', '0503413562'),
(5, 'Левандівка 100/75', 'В будинку поламаний ліфт', '0986754334'),
(6, 'Чупринки 23/1', 'Хочу каталог', '0506746633'),
(7, 'Угорська 14/74', 'Доставте зібраним', '0974306546'),
(8, 'Шевченка 10/2', 'Покладіть запасні шурупи', '662819231'),
(9, 'Боткіна 43/21', 'Хочу отримати 25.12', '0930338669'),
(10, 'Наукова 100/4', 'Гарного дня!', '0980337828');
GO
INSERT INTO Employee VALUES (
1, 'Дарина Мастер','Продавець'),
(2, 'Максим Ромашка','Вантажник'),
(3, 'Олексій Труш','Вантажник');
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



/*Запит з join для виведення списку користувачів і їхніх замовлень*/
Select Customers.CusID, Customers.CusName, _Furniture.FurnitureName From _ORDERS 
join Customers  on _ORDERS.CusID = Customers.CusID
join _Furniture  on _Furniture.IDFurniture = _ORDERS.IDFurniture
order by Customers.CusName;

/*Запит з join для виведення списку користувачів і працівників які їх обслуговували*/

Select Customers.CusID, Customers.CusName, Employee.EmployeeName From _ORDERS 
join Customers  on _ORDERS.CusID = Customers.CusID
right join Employee  on Employee.EmployeeID = _ORDERS.EmployeeID;

/*Запит з join для вививедення усіх замовлень з адресою доставки і описом
відсортованих по адресу*/
Select _ORDERS.OrderID, _Furniture.FurnitureName, _Delivery.DelivAddress, _Delivery.DelivDescription From _ORDERS 
join _Furniture  on _ORDERS.IDFurniture = _Furniture.IDFurniture
join _Delivery  on _ORDERS.DelivID = _Delivery.DelivID
order by _Delivery.DelivAddress;

/*Запит з join для виведення ID замовлення, Імя користувача, його замовлення з адресою і
імям працівника який оформив замовлення*/
Select _ORDERS.OrderID, Customers.CusName, _Furniture.FurnitureName, _Delivery.DelivAddress, Employee.EmployeeName From _ORDERS 
join Customers  on _ORDERS.CusID = Customers.CusID
join _Furniture  on _ORDERS.IDFurniture = _Furniture.IDFurniture
join _Delivery  on _ORDERS.DelivID = _Delivery.DelivID
join Employee  on _ORDERS.EmployeeID = Employee.EmployeeID;


/*Запит з join для виведення усіх оформлених товарів з описом для кожного 
працівника посортований за назвою товару*/
Select Employee.EmployeeName, _Furniture.FurnitureName, _Furniture.FurnitureDescription From _ORDERS join Employee 
on _ORDERS.EmployeeID = Employee.EmployeeID
join _Furniture  on _ORDERS.IDFurniture = _Furniture.IDFurniture
order by _Furniture.FurnitureName;




/*Запит для підрахунку скільки кожен працівник оформив замовлень
посортованих за кількістю за спаданням*/
Select Employee.EmployeeName, Count(_ORDERS.OrderID) as 'Number ot orders'
From _ORDERS  join Employee  
on _ORDERS.EmployeeID = Employee.EmployeeID
Group by Employee.EmployeeName
Order by Count(_ORDERS.OrderID) DESC;


/*Запит для підрахунку скільки кожен працівник(ID,Name) приніс виручку */
Select Employee.EmployeeID, Employee.EmployeeName, SUM(_Furniture.FurniturePrice) as 'order amount' from _ORDERS join Employee  
on _ORDERS.EmployeeID = Employee.EmployeeID
join _Furniture  
on _ORDERS.IDFurniture = _Furniture.IDFurniture
Group by Employee.EmployeeID, Employee.EmployeeName

/*Запит для підрахунку середньої вартості замовлення*/
Select AVG(_Furniture.FurniturePrice) as 'average price' from _ORDERS 
join _Furniture 
on _ORDERS.IDFurniture = _Furniture.IDFurniture;

/*Запит для підрахунку загальної суми замовлень для кожного користувача
посортований за сумою*/
Select Customers.CusName, SUM(_Furniture.FurniturePrice) from _ORDERS join Customers  
on _ORDERS.CusID = Customers.CusID
join _Furniture  
on _ORDERS.IDFurniture = _Furniture.IDFurniture
Group by Customers.CusName
Order by SUM(_Furniture.FurniturePrice);

/*Запит для підрахунку скільки разів замовляли кожен товар*/
Select _Furniture.FurnitureName, COUNT(_Furniture.FurnitureName) as 'times' from _ORDERS join _Furniture  
on _ORDERS.IDFurniture = _Furniture.IDFurniture
Group by _Furniture.FurnitureName;

/*Запит для підрахунку загальної кількості одиниць товару*/
Select Sum(FurnitureAmount) as 'furniure amount' from _Furniture;

/*Запит для групування меблів за роком випуску*/
Select FurnitureYear, COUNT(FurnitureYear) as 'year count' from _Furniture
Group by FurnitureYear;


