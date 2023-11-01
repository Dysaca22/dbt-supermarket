{{ config(materialized='view') }}

SELECT o.Codigo, o.producto
FROM {{ ref('Olimpica') }} o
LEFT JOIN {{ ref('Compras') }} c
ON o.Codigo = c.producto
WHERE c.producto IS NULL
UNION ALL
SELECT e.Codigo, e.producto
FROM {{ ref('Exito') }} e
LEFT JOIN {{ ref('Compras') }} c
ON e.Codigo = c.producto
WHERE c.producto IS NULL
ORDER BY Codigo ASC