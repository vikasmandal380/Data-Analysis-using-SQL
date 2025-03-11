Q1
SELECT DATE_FORMAT(Check_In_Date, '%Y-%m-%d %H') AS month, COUNT(*) AS total_bookings
FROM booking
GROUP BY month
ORDER BY month;

Q2
SELECT b.Hotel_ID, h.Hotel_Name, AVG(b.`customer Rating`) AS avg_rating
FROM booking b
JOIN hotel h ON b.Hotel_ID = h.Hotel_ID
GROUP BY b.Hotel_ID, h.Hotel_Name
ORDER BY avg_rating DESC;

SELECT Hotel_ID, Hotel_Name, avg_rating
FROM (
    SELECT b.Hotel_ID, h.Hotel_Name, AVG(b.`customer Rating`) AS avg_rating
    FROM booking b
    JOIN hotel h ON b.Hotel_ID = h.Hotel_ID
    GROUP BY b.Hotel_ID, h.Hotel_Name
) AS ratings
WHERE avg_rating = (SELECT MAX(avg_rating) FROM (
    SELECT AVG(`customer Rating`) AS avg_rating FROM booking GROUP BY Hotel_ID
) AS subquery);

Q3
SELECT Room_Type, COUNT(*) AS total_bookings
FROM booking
GROUP BY Room_Type
ORDER BY total_bookings DESC;

Q4
SELECT c.Loyalty_Program_Status, COUNT(DISTINCT b.Customer_ID) AS num_customers, COUNT(*) AS total_bookings
FROM booking b
JOIN customer c ON b.Customer_ID = c.Customer_ID
GROUP BY c.Loyalty_Program_Status;

Q5
SELECT b.Customer_ID, c.Name, c.Contact, COUNT(*) AS num_bookings
FROM booking b
JOIN customer c ON b.Customer_ID = c.Customer_ID
GROUP BY b.Customer_ID, c.Name, c.Contact
HAVING num_bookings > 1
ORDER BY num_bookings DESC;

Q6
SELECT DAYNAME(Check_In_Date) AS booking_day, COUNT(*) AS total_bookings
FROM booking
GROUP BY booking_day
ORDER BY total_bookings DESC;

Q7
SELECT b.Customer_ID, c.Name, COUNT(*) AS total_bookings, c.Loyalty_Program_Status
FROM booking b
JOIN customer c ON b.Customer_ID = c.Customer_ID
GROUP BY b.Customer_ID, c.Name, c.Loyalty_Program_Status
ORDER BY total_bookings DESC
LIMIT 5;

Q8
SELECT h.Location_City, COUNT(*) AS total_bookings
FROM booking b
JOIN hotel h ON b.Hotel_ID = h.Hotel_ID
GROUP BY h.Location_City
ORDER BY total_bookings DESC
LIMIT 1;
