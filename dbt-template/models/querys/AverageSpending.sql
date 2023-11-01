{{ config(materialized='view') }}

WITH Vino_Tinto_OLI AS (
    SELECT Codigo, Precio, Producto as Nombre
    FROM {{ ref('Olimpica') }}
    WHERE Producto LIKE '%Vino Tinto%'
), Vino_Tinto_EXI AS (
    SELECT Codigo, Precio, Producto as Nombre
    FROM {{ ref('Exito') }}
    WHERE Producto LIKE '%Vino Tinto%'
), Vino_Tinto_PROD AS (
    SELECT *
    FROM Vino_Tinto_OLI

    UNION ALL

    SELECT *
    FROM Vino_Tinto_EXI
), Compras_AGG AS (
  SELECT producto, COUNT(*) AS cantidad
  FROM {{ ref('Compras') }}
  GROUP BY producto
), Por_Almacen AS (
    SELECT IF(SUBSTR(vino_tinto_.Codigo,1,3)='OLI', 'OLIMPICA', 'EXITO') AS almacen,
    vino_tinto_.Codigo AS producto, compras_.cantidad, Nombre,
    compras_.cantidad * vino_tinto_.Precio AS total
    FROM Compras_AGG compras_ INNER JOIN Vino_Tinto_PROD vino_tinto_ ON compras_.producto = vino_tinto_.Codigo
)

SELECT *,
(SUM(total) OVER (particion_almacen)) / (SUM(cantidad) OVER (particion_almacen)) promedio_almacen
FROM Por_Almacen
WINDOW particion_almacen AS (
  PARTITION BY almacen
)
ORDER BY producto