{{ config(materialized='table') }}

SELECT *
FROM {{ source('Supermercado', 'Exito_EXT') }}