-- Create Database
CREATE DATABASE OnlineBookstore;

-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- 1) Retrieve all books in the "Fiction" genre

select Title, Genre 
from books
where Genre = 'Fiction';

-- 2) Find books published after the year 1950

select Title, Published_Year from books
Where Published_Year > 1950;

-- 3) List all customers from the Canada

select Name, Country 
from Customers
where Country = 'Canada';

 -- 4) Show orders placed in November 2023

Select * from Orders
Where order_date between '2023/11/01' and '2023/11/30';

 -- 5) Retrieve the total stock of books available

Select Sum(stock)
from books;

--  6) Find the details of the most expensive book

select *
from books 
order by price desc limit 1;

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- 7) Show all customers who ordered more than 1 quantity of a book

SELECT * FROM Orders
where quantity > 1;

-- 8) Retrieve all orders where the total amount exceeds $20

SELECT * FROM Orders
where Total_Amount > 20;

-- 9) List all genres available in the Books table

SELECT distinct(genre) FROM Books;

-- 10) Find the book with the lowest stock

SELECT * FROM Books
order by stock asc;
 
 -- 11) Calculate the total revenue generated from all orders
 
 select Sum(Total_Amount)
 From Orders;

-- 1) Retrieve the total number of books sold for each genre

Select b.Genre, Sum(o.Quantity)
from  Books b
join orders O on o.Book_ID = b.book_ID
Group by b.Genre;

--  2) Find the average price of books in the "Fantasy" genre

Select avg(price) as Average_price
From Books 
Where Genre = 'Fantasy';

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

 -- 3) List customers who have placed at least 2 orders

Select o.Customer_ID, c.name, count(o.Order_ID) as order_Count
From Orders o
Join Customers C on o.Customer_ID = C.Customer_ID
group by o.Customer_ID
Having count(o.Order_id)>=2;

-- 4) Find the most frequently ordered book


select O.book_id, b.Title, count(o.order_ID) as Order_count
From Orders O
Join Books b on B.book_ID = O.Book_ID
Group by o.Book_ID, b.Title
order by Order_count desc Limit 1;

 -- 5) Show the top 3 most expensive books of 'Fantasy' Genre 

Select * from books
where Genre = 'Fantasy' 
Order by Price desc
 Limit 3;
 
-- 6) Retrieve the total quantity of books sold by each author

Select b.Author, Sum(O.quantity) As total_books_sold
from orders o
Join Books b on o.book_id = b.Book_id
group by b. Author;

--  7) List the cities where customers who spent over $300 are located

select distinct C.city, total_amount
from orders o
Join Customers C on o.Customer_ID = C.Customer_ID
Where O.total_amount >300;

 -- 8) Find the customer who spent the most on orders

Select c.customer_id, c.name, Sum(O.total_amount) as Total_Spent
from orders o
Join Customers C on o.Customer_ID = C.Customer_ID
group by C.customer_Id, C.name
Order By Total_spent desc;

-- 9) Calculate the stock remaining after fulfilling all orders 
 
select b.book_id, b.title, b.stock, coalesce(sum(Quantity),0) as order_quantity, b.stock- coalesce(sum(Quantity),0) as remaning_quantity
from Books b
Left Join Orders o On b.book_id = O.book_id
group by b.book_id;


