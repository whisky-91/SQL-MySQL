
/**
AND ()

Operador que permite realizar consultas con 
condiciones múltiples.

TODAS las condiciones tienen que ser VERDADERAS
para que se cumpla.

Se puede usar con WHERE y con HAVING.

SELECT <columnas>
FROM <tabla>
WHERE <condicion1> AND <condicion2> ...;
*/


#AND con WHERE:

SELECT *
FROM `payment`
WHERE `staff_id` = 1 AND `amount` > 0 AND amount < 5
ORDER BY AMOUNT ASC;


#AND con HAVING:

SELECT *
FROM `payment`
HAVING `customer_id`< 5 AND `staff_id`= 2;

+------------+-------------+----------+-----------+--------+---------------------+---------------------+
| payment_id | customer_id | staff_id | rental_id | amount | payment_date        | last_update         |
+------------+-------------+----------+-----------+--------+---------------------+---------------------+
|          4 |           1 |        2 |      1422 |   0.99 | 2005-06-15 18:02:53 | 2006-02-15 22:12:30 |
|          5 |           1 |        2 |      1476 |   9.99 | 2005-06-15 21:08:46 | 2006-02-15 22:12:30 |
|          8 |           1 |        2 |      2363 |   0.99 | 2005-06-18 13:33:59 | 2006-02-15 22:12:30 |
|         10 |           1 |        2 |      4526 |   5.99 | 2005-07-08 03:17:05 | 2006-02-15 22:12:30 |
  ...
|        102 |           4 |        2 |     12856 |   1.99 | 2005-08-19 02:19:13 | 2006-02-15 22:12:30 |
|        105 |           4 |        2 |     14225 |   4.99 | 2005-08-21 04:53:37 | 2006-02-15 22:12:30 |
|        107 |           4 |        2 |     15635 |   1.99 | 2005-08-23 07:43:00 | 2006-02-15 22:12:30 |
+------------+-------------+----------+-----------+--------+---------------------+---------------------+
49 rows in set (0,008 sec)


# AND con WHERE y HAVING:

SELECT *
FROM `payment`
WHERE `payment_id` > 30 AND `payment_id` < 45
HAVING `customer_id`< 5 AND `staff_id`= 2;

+------------+-------------+----------+-----------+--------+---------------------+---------------------+
| payment_id | customer_id | staff_id | rental_id | amount | payment_date        | last_update         |
+------------+-------------+----------+-----------+--------+---------------------+---------------------+
|         31 |           1 |        2 |     15298 |   2.99 | 2005-08-22 19:41:37 | 2006-02-15 22:12:30 |
|         37 |           2 |        2 |      7346 |   4.99 | 2005-07-27 14:30:42 | 2006-02-15 22:12:30 |
|         39 |           2 |        2 |      7459 |   5.99 | 2005-07-27 18:40:20 | 2006-02-15 22:12:30 |
|         40 |           2 |        2 |      8230 |   5.99 | 2005-07-29 00:12:59 | 2006-02-15 22:12:30 |
|         42 |           2 |        2 |      8705 |   5.99 | 2005-07-29 17:14:29 | 2006-02-15 22:12:30 |
|         44 |           2 |        2 |      9236 |  10.99 | 2005-07-30 13:47:43 | 2006-02-15 22:12:30 |
+------------+-------------+----------+-----------+--------+---------------------+---------------------+
6 rows in set (0,001 sec)


#SELECT, con COUNT y SUM, con GROUP BY.

SELECT `rental_duration`, `rental_rate`, COUNT(rental_duration), SUM(rental_rate)
FROM film
GROUP BY rental_duration, rental_rate;

+-----------------+-------------+------------------------+------------------+
| rental_duration | rental_rate | COUNT(rental_duration) | SUM(rental_rate) |
+-----------------+-------------+------------------------+------------------+
|               3 |        0.99 |                     78 |            77.22 |
|               3 |        2.99 |                     63 |           188.37 |
|               3 |        4.99 |                     62 |           309.38 |
|               4 |        0.99 |                     72 |            71.28 |
|               4 |        2.99 |                     61 |           182.39 |
|               4 |        4.99 |                     70 |           349.30 |
|               5 |        0.99 |                     56 |            55.44 |
|               5 |        2.99 |                     59 |           176.41 |
|               5 |        4.99 |                     76 |           379.24 |
|               6 |        0.99 |                     76 |            75.24 |
|               6 |        2.99 |                     70 |           209.30 |
|               6 |        4.99 |                     66 |           329.34 |
|               7 |        0.99 |                     59 |            58.41 |
|               7 |        2.99 |                     70 |           209.30 |
|               7 |        4.99 |                     62 |           309.38 |
+-----------------+-------------+------------------------+------------------+
15 rows in set (0,002 sec)




# SELECT (con un COUNT y una SUM), GROUP BY CON HAVING Y ORDER BY DESC:

SELECT `rental_duration`, `rental_rate`, COUNT(rental_duration), SUM(rental_rate)
FROM film
GROUP BY rental_duration, rental_rate
HAVING COUNT(RENTAL_DURATION) < 70 AND SUM(rental_rate) < 1000
ORDER BY rental_duration DESC;

+-----------------+-------------+------------------------+------------------+
| rental_duration | rental_rate | COUNT(rental_duration) | SUM(rental_rate) |
+-----------------+-------------+------------------------+------------------+
|               7 |        0.99 |                     59 |            58.41 |
|               7 |        4.99 |                     62 |           309.38 |
|               6 |        4.99 |                     66 |           329.34 |
|               5 |        0.99 |                     56 |            55.44 |
|               5 |        2.99 |                     59 |           176.41 |
|               4 |        2.99 |                     61 |           182.39 |
|               3 |        2.99 |                     63 |           188.37 |
|               3 |        4.99 |                     62 |           309.38 |
+-----------------+-------------+------------------------+------------------+
8 rows in set (0,002 sec)


SELECT `rental_duration`, `rental_rate`, COUNT(rental_duration), SUM(rental_rate)
FROM film
GROUP BY rental_duration, rental_rate
HAVING COUNT(RENTAL_DURATION) < 70 AND SUM(rental_rate) < 300
ORDER BY rental_duration DESC;

+-----------------+-------------+------------------------+------------------+
| rental_duration | rental_rate | COUNT(rental_duration) | SUM(rental_rate) |
+-----------------+-------------+------------------------+------------------+
|               7 |        0.99 |                     59 |            58.41 |
|               5 |        0.99 |                     56 |            55.44 |
|               5 |        2.99 |                     59 |           176.41 |
|               4 |        2.99 |                     61 |           182.39 |
|               3 |        2.99 |                     63 |           188.37 |
+-----------------+-------------+------------------------+------------------+
