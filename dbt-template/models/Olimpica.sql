{{ config(materialized='table') }}

SELECT *
FROM {{ source('Supermercado', 'Olimpica_EXT') }}