/**
NOT ()

Es un operador utilizado en la cláusula WHERE
y HAVING para mostrar todo menos la condición:

SELECT <columna>
FROM <tabla>
WHERE NOT <condicion>;
*/


# Ejemplo:

SELECT *
FROM `actor`
WHERE `first_name` = 'Penelope';

# +----------+------------+-----------+---------------------+
# | actor_id | first_name | last_name | last_update         |
# +----------+------------+-----------+---------------------+
# |        1 | PENELOPE   | GUINESS   | 2006-02-15 04:34:33 |
# |       54 | PENELOPE   | PINKETT   | 2006-02-15 04:34:33 |
# |      104 | PENELOPE   | CRONYN    | 2006-02-15 04:34:33 |
# |      120 | PENELOPE   | MONROE    | 2006-02-15 04:34:33 |
# +----------+------------+-----------+---------------------+
# 4 rows in set (0,000 sec)

# Misma consulta, negando el first_name = PENELOPE:

SELECT *
FROM `actor`
WHERE NOT `first_name` = 'Penelope';

# +----------+-------------+--------------+---------------------+
# | actor_id | first_name  | last_name    | last_update         |
# +----------+-------------+--------------+---------------------+
# |        2 | NICK        | WAHLBERG     | 2006-02-15 04:34:33 |
# |        3 | ED          | CHASE        | 2006-02-15 04:34:33 |
# |        4 | JENNIFER    | DAVIS        | 2006-02-15 04:34:33 |
# |        5 | JOHNNY      | LOLLOBRIGIDA | 2006-02-15 04:34:33 |
# |        6 | BETTE       | NICHOLSON    | 2006-02-15 04:34:33 |
#   ...
# |      196 | BELA        | WALKEN       | 2006-02-15 04:34:33 |
# |      197 | REESE       | WEST         | 2006-02-15 04:34:33 |
# |      198 | MARY        | KEITEL       | 2006-02-15 04:34:33 |
# |      199 | JULIA       | FAWCETT      | 2006-02-15 04:34:33 |
# |      200 | THORA       | TEMPLE       | 2006-02-15 04:34:33 |
# +----------+-------------+--------------+---------------------+
# 196 rows in set (0,001 sec)


# SELECT con COUNT renombrado como 'CONTEO', GROUP BY 'rental_rate',
# HAVING (condición completa entre paréntesis), ORDER BY el CONTEO
# de rental_rate ascendente (ASC):

SELECT 
`rental_rate`,
COUNT(`rental_rate`) AS `CONTEO`
FROM `film`
GROUP BY `rental_rate`
HAVING (COUNT(`rental_rate`) > 300 AND COUNT(`rental_rate`) < 339)
ORDER BY COUNT(`rental_rate`) ASC;

# +-------------+--------+
# | rental_rate | CONTEO |
# +-------------+--------+
# |        2.99 |    323 |
# |        4.99 |    336 |
# +-------------+--------+
# 2 rows in set (0,001 sec)


# Ejemplo anterior con HAVING NOT:

SELECT 
`rental_rate`,
COUNT(`rental_rate`) AS `CONTEO` --> Puedo usar el alias en el resto de operadores salvo WHERE, 
FROM `film`                      --  ya que ese alias es una función y WHERE no las acepta.
GROUP BY `rental_rate`
HAVING NOT (COUNT(`rental_rate`) > 300 AND COUNT(`rental_rate`) < 339) --> Paréntesis en toda la 
ORDER BY COUNT(`rental_rate`) ASC;                                     --  condición para que el 
                                                                       --  not se aplique a todo.
# +-------------+--------+                                            
# | rental_rate | CONTEO |
# +-------------+--------+
# |        0.99 |    341 |
# +-------------+--------+
# 1 row in set (0,001 sec)
