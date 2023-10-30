{{ config(materialized='view') }}

WITH compra_oli AS (
    SELECT DISTINCT cliente AS cliente
    FROM {{ ref('Compras') }}
    WHERE producto LIKE 'OLI%'
), compra_exi AS (
    SELECT DISTINCT cliente AS cliente
    FROM {{ ref('Compras') }}
    WHERE producto LIKE 'EXI%'
)

SELECT *
FROM compra_oli 
LEFT JOIN compra_exi
USING(cliente)
WHERE compra_exi.cliente IS NULL