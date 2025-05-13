/**
LIKE ()

El operador LIKE se utiliza en la cláusula 
WHERE.

Con like se utilizan dos comodines:
% representa 0, 1 o más caracteres.
_ representa un solo caracter.

SELECT <columnas>
FROM <tabla>
WHERE <columna> LIKE <buscado> ;
*/

# Buscando actores cuyo nombre empiece
# por la letra F.

SELECT *
FROM actor
WHERE first_name LIKE "F%";

# +----------+------------+-----------+---------------------+
# | actor_id | first_name | last_name | last_update         |
# +----------+------------+-----------+---------------------+
# |       16 | FRED       | COSTNER   | 2006-02-15 04:34:33 |
# |       48 | FRANCES    | DAY-LEWIS | 2006-02-15 04:34:33 |
# |       55 | FAY        | KILMER    | 2006-02-15 04:34:33 |
# |      126 | FRANCES    | TOMEI     | 2006-02-15 04:34:33 |
# |      147 | FAY        | WINSLET   | 2006-02-15 04:34:33 |
# |      156 | FAY        | WOOD      | 2006-02-15 04:34:33 |
# +----------+------------+-----------+---------------------+
# 6 rows in set (0,001 sec)



# Actores cuyo nombre contenga la letra 'E' como segundo caracter:

SELECT *
FROM actor
WHERE first_name LIKE '_E%';

# +----------+------------+-------------+---------------------+
# | actor_id | first_name | last_name   | last_update         |
# +----------+------------+-------------+---------------------+
# |        1 | PENELOPE   | GUINESS     | 2006-02-15 04:34:33 |
# |        4 | JENNIFER   | DAVIS       | 2006-02-15 04:34:33 |
# |        6 | BETTE      | NICHOLSON   | 2006-02-15 04:34:33 |
# |       11 | ZERO       | CAGE        | 2006-02-15 04:34:33 |
# |       17 | HELEN      | VOIGHT      | 2006-02-15 04:34:33 |
# |       25 | KEVIN      | BLOOM       | 2006-02-15 04:34:33 |
# |       45 | REESE      | KILMER      | 2006-02-15 04:34:33 |
# |       53 | MENA       | TEMPLE      | 2006-02-15 04:34:33 |
# |       54 | PENELOPE   | PINKETT     | 2006-02-15 04:34:33 |
# |       60 | HENRY      | BERRY       | 2006-02-15 04:34:33 |
# |       67 | JESSICA    | BAILEY      | 2006-02-15 04:34:33 |
# |       69 | KENNETH    | PALTROW     | 2006-02-15 04:34:33 |
# |       72 | SEAN       | WILLIAMS    | 2006-02-15 04:34:33 |
# |       83 | BEN        | WILLIS      | 2006-02-15 04:34:33 |
# |       88 | KENNETH    | PESCI       | 2006-02-15 04:34:33 |
# |       90 | SEAN       | GUINESS     | 2006-02-15 04:34:33 |
# |       94 | KENNETH    | TORN        | 2006-02-15 04:34:33 |
# |       96 | GENE       | WILLIS      | 2006-02-15 04:34:33 |
# |       97 | MEG        | HAWKE       | 2006-02-15 04:34:33 |
# |      104 | PENELOPE   | CRONYN      | 2006-02-15 04:34:33 |
# |      117 | RENEE      | TRACY       | 2006-02-15 04:34:33 |
# |      120 | PENELOPE   | MONROE      | 2006-02-15 04:34:33 |
# |      127 | KEVIN      | GARLAND     | 2006-02-15 04:34:33 |
# |      134 | GENE       | HOPKINS     | 2006-02-15 04:34:33 |
# |      151 | GEOFFREY   | HESTON      | 2006-02-15 04:34:33 |
# |      152 | BEN        | HARRIS      | 2006-02-15 04:34:33 |
# |      154 | MERYL      | GIBSON      | 2006-02-15 04:34:33 |
# |      169 | KENNETH    | HOFFMAN     | 2006-02-15 04:34:33 |
# |      170 | MENA       | HOPPER      | 2006-02-15 04:34:33 |
# |      177 | GENE       | MCKELLEN    | 2006-02-15 04:34:33 |
# |      180 | JEFF       | SILVERSTONE | 2006-02-15 04:34:33 |
# |      182 | DEBBIE     | AKROYD      | 2006-02-15 04:34:33 |
# |      187 | RENEE      | BALL        | 2006-02-15 04:34:33 |
# |      194 | MERYL      | ALLEN       | 2006-02-15 04:34:33 |
# |      196 | BELA       | WALKEN      | 2006-02-15 04:34:33 |
# |      197 | REESE      | WEST        | 2006-02-15 04:34:33 |
# +----------+------------+-------------+---------------------+
# 36 rows in set (0,000 sec)


# Actores cuyo nombre contenga la letra 'E' como segundo caracter
# y que finalice con 'TR' + dos caracteres en el last_name:

  SELECT *
  FROM actor
  WHERE first_name LIKE '_E%' AND last_name LIKE '%TR__';

# +----------+------------+-----------+---------------------+
# | actor_id | first_name | last_name | last_update         |
# +----------+------------+-----------+---------------------+
# |       69 | KENNETH    | PALTROW   | 2006-02-15 04:34:33 |
# +----------+------------+-----------+---------------------+
# 1 row in set (0,000 sec)


# Ejercicio anterior sustituyendo AND por OR:

SELECT *
FROM actor
WHERE first_name LIKE '_E%' OR last_name LIKE '%TR__';

# +----------+------------+-------------+---------------------+
# | actor_id | first_name | last_name   | last_update         |
# +----------+------------+-------------+---------------------+
# |        1 | PENELOPE   | GUINESS     | 2006-02-15 04:34:33 |
# |        4 | JENNIFER   | DAVIS       | 2006-02-15 04:34:33 |
# |        6 | BETTE      | NICHOLSON   | 2006-02-15 04:34:33 |
# |       11 | ZERO       | CAGE        | 2006-02-15 04:34:33 |
# |       17 | HELEN      | VOIGHT      | 2006-02-15 04:34:33 |
# |       21 | KIRSTEN    | PALTROW     | 2006-02-15 04:34:33 |
# |       25 | KEVIN      | BLOOM       | 2006-02-15 04:34:33 |
# |       45 | REESE      | KILMER      | 2006-02-15 04:34:33 |
# |       53 | MENA       | TEMPLE      | 2006-02-15 04:34:33 |
# |       54 | PENELOPE   | PINKETT     | 2006-02-15 04:34:33 |
# |       60 | HENRY      | BERRY       | 2006-02-15 04:34:33 |
# |       67 | JESSICA    | BAILEY      | 2006-02-15 04:34:33 |
# |       69 | KENNETH    | PALTROW     | 2006-02-15 04:34:33 |
# |       72 | SEAN       | WILLIAMS    | 2006-02-15 04:34:33 |
# |       83 | BEN        | WILLIS      | 2006-02-15 04:34:33 |
# |       88 | KENNETH    | PESCI       | 2006-02-15 04:34:33 |
# |       90 | SEAN       | GUINESS     | 2006-02-15 04:34:33 |
# |       94 | KENNETH    | TORN        | 2006-02-15 04:34:33 |
# |       96 | GENE       | WILLIS      | 2006-02-15 04:34:33 |
# |       97 | MEG        | HAWKE       | 2006-02-15 04:34:33 |
# |      104 | PENELOPE   | CRONYN      | 2006-02-15 04:34:33 |
# |      117 | RENEE      | TRACY       | 2006-02-15 04:34:33 |
# |      120 | PENELOPE   | MONROE      | 2006-02-15 04:34:33 |
# |      127 | KEVIN      | GARLAND     | 2006-02-15 04:34:33 |
# |      134 | GENE       | HOPKINS     | 2006-02-15 04:34:33 |
# |      151 | GEOFFREY   | HESTON      | 2006-02-15 04:34:33 |
# |      152 | BEN        | HARRIS      | 2006-02-15 04:34:33 |
# |      154 | MERYL      | GIBSON      | 2006-02-15 04:34:33 |
# |      169 | KENNETH    | HOFFMAN     | 2006-02-15 04:34:33 |
# |      170 | MENA       | HOPPER      | 2006-02-15 04:34:33 |
# |      177 | GENE       | MCKELLEN    | 2006-02-15 04:34:33 |
# |      180 | JEFF       | SILVERSTONE | 2006-02-15 04:34:33 |
# |      182 | DEBBIE     | AKROYD      | 2006-02-15 04:34:33 |
# |      187 | RENEE      | BALL        | 2006-02-15 04:34:33 |
# |      194 | MERYL      | ALLEN       | 2006-02-15 04:34:33 |
# |      196 | BELA       | WALKEN      | 2006-02-15 04:34:33 |
# |      197 | REESE      | WEST        | 2006-02-15 04:34:33 |
# +----------+------------+-------------+---------------------+
# 37 rows in set (0,000 sec)


# Buscando en un campo numérico: Se puede usar con números 
# pero no tiene sentido, no podemos usar # % ó _ salvo que 
# lo metas entrecomillado como un string:

SELECT *
FROM actor
WHERE actor_id LIKE "%5";

# +----------+------------+--------------+---------------------+
# | actor_id | first_name | last_name    | last_update         |
# +----------+------------+--------------+---------------------+
# |        5 | JOHNNY     | LOLLOBRIGIDA | 2006-02-15 04:34:33 |
# |       15 | CUBA       | OLIVIER      | 2006-02-15 04:34:33 |
# |       25 | KEVIN      | BLOOM        | 2006-02-15 04:34:33 |
# |       35 | JUDY       | DEAN         | 2006-02-15 04:34:33 |
# |       45 | REESE      | KILMER       | 2006-02-15 04:34:33 |
# |       55 | FAY        | KILMER       | 2006-02-15 04:34:33 |
# |       65 | ANGELA     | HUDSON       | 2006-02-15 04:34:33 |
# |       75 | BURT       | POSEY        | 2006-02-15 04:34:33 |
# |       85 | MINNIE     | ZELLWEGER    | 2006-02-15 04:34:33 |
# |       95 | DARYL      | WAHLBERG     | 2006-02-15 04:34:33 |
# |      105 | SIDNEY     | CROWE        | 2006-02-15 04:34:33 |
# |      115 | HARRISON   | BALE         | 2006-02-15 04:34:33 |
# |      125 | ALBERT     | NOLTE        | 2006-02-15 04:34:33 |
# |      135 | RITA       | REYNOLDS     | 2006-02-15 04:34:33 |
# |      145 | KIM        | ALLEN        | 2006-02-15 04:34:33 |
# |      155 | IAN        | TANDY        | 2006-02-15 04:34:33 |
# |      165 | AL         | GARLAND      | 2006-02-15 04:34:33 |
# |      175 | WILLIAM    | HACKMAN      | 2006-02-15 04:34:33 |
# |      185 | MICHAEL    | BOLGER       | 2006-02-15 04:34:33 |
# |      195 | JAYNE      | SILVERSTONE  | 2006-02-15 04:34:33 |
# +----------+------------+--------------+---------------------+
# 20 rows in set (0,000 sec)