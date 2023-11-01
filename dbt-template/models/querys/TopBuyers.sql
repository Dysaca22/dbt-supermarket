{{ config(materialized='view') }}

(
    SELECT c.Nombre, c.Apellido, compras.cliente AS top_buyer, COUNT(*) AS purchase_count, 'OLIMPICA' AS store
    FROM {{ ref('Compras') }} compras
    LEFT JOIN {{ ref('Clientes') }} c ON compras.cliente = c.C__digo
    WHERE compras.producto LIKE 'OLI%'
    GROUP BY top_buyer, c.Nombre, c.Apellido
    ORDER BY purchase_count DESC
    LIMIT 3
)
UNION ALL
(
    SELECT c.Nombre, c.Apellido, compras.cliente AS top_buyer, COUNT(*) AS purchase_count, 'EXITO' AS store
    FROM {{ ref('Compras') }} compras
    LEFT JOIN {{ ref('Clientes') }} c ON compras.cliente = c.C__digo
    WHERE compras.producto LIKE 'EXI%'
    GROUP BY top_buyer, c.Nombre, c.Apellido
    ORDER BY purchase_count DESC
    LIMIT 3
)
ORDER BY purchase_count DESC