# Online-Bookstore-SQL-Practice
A complete schema + sample queries for an online bookstore (DDL + DML + analytical questions).

🧪 Sample Queries

1,Books in Fiction,"SELECT Title, Genre FROM Books WHERE Genre='Fiction';"
6,Most expensive book,SELECT * FROM Books ORDER BY Price DESC LIMIT 1;
11,Total revenue,SELECT SUM(Total_Amount) FROM Orders;
1A,Sales per genre,"SELECT b.Genre, SUM(o.Quantity) FROM Books b JOIN Orders o ON o.Book_ID=b.Book_ID GROUP BY b.Genre;"
9A,Stock after orders,"SELECT b.Title, b.Stock - COALESCE(SUM(o.Quantity),0) AS Remaining FROM Books b LEFT JOIN Orders o ON b.Book_ID=o.Book_ID GROUP BY b.Book_ID;"
