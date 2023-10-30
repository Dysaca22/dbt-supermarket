{{ config(materialized='table') }}

SELECT *
FROM {{ source('Supermercado', 'Compras_EXT') }}