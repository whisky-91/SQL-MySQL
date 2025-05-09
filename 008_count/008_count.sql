/*
COUNT()
Cuenta la cantidad de registros en una tabla.
*/
USE sakila;

SELECT COUNT(*) FROM (`tabla`);


USE sakila;

SELECT COUNT(amount)
FROM `payment`
WHERE amount <=5;