{{ config(materialized='view') }}

SELECT o.Producto AS nombre, c.producto, COUNT(*) AS purchase_count
FROM {{ ref('Compras') }} c
LEFT JOIN {{ ref('Olimpica') }} o ON c.producto = o.Codigo
LEFT JOIN {{ ref('Exito') }} e ON c.producto = e.Codigo
GROUP BY c.producto, nombre
ORDER BY purchase_count DESC
LIMIT 3