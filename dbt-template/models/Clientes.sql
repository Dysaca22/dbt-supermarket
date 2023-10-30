{{ config(materialized='table') }}

SELECT *
FROM {{ source('Supermercado', 'Clientes_EXT') }}