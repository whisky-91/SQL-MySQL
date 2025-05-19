Preguntar a chatgpt que actúa como un experto en sql y mariadb y utilice la sintaxis de mariadb.

Pedir que nos proporcione el código para crear la tabla productos que tiene la siguiente estructura:

TABLA PRODUCTO:
	producto_id
	nombre
	cod_producto

TABLAS PRODUCTOS HISTORICOS DE PRECIOS	
	php_id
	precio
	fecha

La base de datos que se va a llamar práctica subconsultas₁
Debe relacionar el productor con el historico de productos (php_id)

Si hay algún producto que haya cambiando de precio entre el primero de abril y el 15 de abril del mismo año que tengamos

Pedirle una lista de productos cuyo promedio de cambio de precio sea inferior a 3€:


CREATE DATABASE IF NOT EXISTS practica_subconsultas;
USE practica_subconsultas;

-- Crear la tabla de productos
CREATE TABLE productos (
    producto_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    cod_producto VARCHAR(50) NOT NULL UNIQUE
);

-- Crear la tabla de histórico de precios
CREATE TABLE historico_precios (
    php_id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
);

-- Insertar datos en la tabla productos
INSERT INTO productos (nombre, cod_producto) VALUES
('Teclado Mecánico', 'PROD001'),
('Ratón Inalámbrico', 'PROD002'),
('Monitor LED 24"', 'PROD003'),
('Disco SSD 1TB', 'PROD004'),
('Auriculares Bluetooth', 'PROD005');

-- Insertar datos en la tabla historico_precios
INSERT INTO historico_precios (producto_id, precio, fecha) VALUES
(1, 59.99, '2024-01-15'),
(1, 54.99, '2024-03-10'),
(1, 52.49, '2024-05-01'),

(2, 29.99, '2024-02-01'),
(2, 24.99, '2024-04-01'),

(3, 199.99, '2024-01-01'),
(3, 189.99, '2024-03-01'),
(3, 179.99, '2024-05-01'),

(4, 120.00, '2024-01-20'),
(4, 115.00, '2024-04-10'),

(5, 79.99, '2024-01-10'),
(5, 69.99, '2024-03-20'),
(5, 64.99, '2024-05-10');


-- Cambio de precio del 1 al 15:
SELECT 
    p.nombre,
    COUNT(DISTINCT h.precio) AS precios_distintos
FROM historico_precios h
JOIN productos p ON h.producto_id = p.producto_id
WHERE 
    MONTH(h.fecha) = 4 AND
    DAY(h.fecha) BETWEEN 1 AND 15
GROUP BY h.producto_id
HAVING COUNT(DISTINCT h.precio) > 1;

Resultado esperado:

Solo el producto "Disco SSD 1TB" cumple con esto, ya que tiene:

    Un precio de 120.00 el 2024-01-20 (fuera de rango),

    Otro precio de 115.00 el 2024-04-10 (dentro de rango).


-- Productos que no han variado más de 3€ en su precio:

SELECT 
    p.nombre,
    AVG(ABS(h1.precio - h2.precio)) AS promedio_cambio
FROM historico_precios h1
JOIN historico_precios h2 
    ON h1.producto_id = h2.producto_id
   AND h1.fecha = (
       SELECT MIN(hx.fecha)
       FROM historico_precios hx
       WHERE hx.producto_id = h2.producto_id
         AND hx.fecha > h2.fecha
   )
JOIN productos p ON p.producto_id = h1.producto_id
GROUP BY p.producto_id, p.nombre
HAVING AVG(ABS(h1.precio - h2.precio)) < 3;

Resultado esperado:

Todos los productos tienen un promedio de cambio mayor o igual a 3.

Resultado esperado: ningún producto listado.