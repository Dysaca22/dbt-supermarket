{{ config(materialized='view') }}

SELECT producto, COUNT(*) as purchase_count
FROM {{ ref('Compras') }}
GROUP BY producto
ORDER BY purchase_count DESC
LIMIT 3