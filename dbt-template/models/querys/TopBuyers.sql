{{ config(materialized='view') }}

(
    SELECT cliente AS top_buyer, COUNT(*) AS purchase_count, 'OLIMPICA' AS store
    FROM {{ ref('Compras') }}
    WHERE producto LIKE 'OLI%'
    GROUP BY cliente
    ORDER BY purchase_count DESC
    LIMIT 3
)
UNION ALL
(
    SELECT cliente AS top_buyer, COUNT(*) AS purchase_count, 'EXITO' AS store
    FROM {{ ref('Compras') }}
    WHERE producto LIKE 'EXI%'
    GROUP BY cliente
    ORDER BY purchase_count DESC
    LIMIT 3
)
ORDER BY purchase_count DESC