/**
OR

Operador que permite realizar consultas con 
condiciones múltiples.

ALGUNA de las condiciones tiene que ser VERDADERA
para que se cumpla.

Se puede usar con WHERE y con HAVING.

SELECT <columnas>
FROM <tabla>
WHERE <condicion1> OR <condicion2> ...;
*/

# Ejemplo último de AND, sustituyéndolo por OR. Muestra los resultados de todas
# las condiciones que se cumplen, de manera independiente de las otras condiciones.

SELECT `rental_duration`, `rental_rate`, COUNT(rental_duration), SUM(rental_rate)
FROM film
GROUP BY rental_duration, rental_rate
HAVING COUNT(RENTAL_DURATION) < 70 OR SUM(rental_rate) < 300

# +-----------------+-------------+------------------------+------------------+
# | rental_duration | rental_rate | COUNT(rental_duration) | SUM(rental_rate) |
# +-----------------+-------------+------------------------+------------------+
# |               3 |        0.99 |                     78 |            77.22 |
# |               3 |        2.99 |                     63 |           188.37 |
# |               3 |        4.99 |                     62 |           309.38 |
# |               4 |        0.99 |                     72 |            71.28 |
# |               4 |        2.99 |                     61 |           182.39 |
# |               5 |        0.99 |                     56 |            55.44 |
# |               5 |        2.99 |                     59 |           176.41 |
# |               6 |        0.99 |                     76 |            75.24 |
# |               6 |        2.99 |                     70 |           209.30 |
# |               6 |        4.99 |                     66 |           329.34 |
# |               7 |        0.99 |                     59 |            58.41 |
# |               7 |        2.99 |                     70 |           209.30 |
# |               7 |        4.99 |                     62 |           309.38 |
# +-----------------+-------------+------------------------+------------------+
13 rows in set (0,002 sec)


SELECT *
FROM `actor`
WHERE `first_name`= 'Penelope' OR `last_name` = 'Monroe';

# +----------+------------+-----------+---------------------+
# | actor_id | first_name | last_name | last_update         |
# +----------+------------+-----------+---------------------+
# |        1 | PENELOPE   | GUINESS   | 2006-02-15 04:34:33 |
# |       54 | PENELOPE   | PINKETT   | 2006-02-15 04:34:33 |
# |      104 | PENELOPE   | CRONYN    | 2006-02-15 04:34:33 |
# |      120 | PENELOPE   | MONROE    | 2006-02-15 04:34:33 |
# |      178 | LISA       | MONROE    | 2006-02-15 04:34:33 |
# +----------+------------+-----------+---------------------+
