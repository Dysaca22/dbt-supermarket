# dbt-supermarket

Análisis de los precios del mercado local para dos "marcas" reconocidas y brindaremos información sobre diversas consultas relacionadas con el negocio.

## Transformación
Creación de modelos en dbt para limpiar y transformar los datos. Se imputa los valores faltantes en los diferentes valores a través de la mediana en el supermercado Olimpica.

## Consultas
Se responden las siguientes preguntas como consultas:
1. **Gasto promedio**: gasto promedio en ``Vino Tinto" tanto en las tiendas OLIMPICA como EXITO.
2. **Principales compradores**: compradores destacados en los puntos de venta OLIMPICA y EXITO.
3. **Unique Olimpica Buyers**: clientes que han realizado compras específicamente en OLIMPICA pero no en EXITO
4. **Compras populares**: principales productos que las personas compran con frecuencia.
5. **Artículos no comprados**: productos que nunca han sido comprados por los clientes.

## Persistencia
Se configura dbt para que los resultados de las transformaciones se materializan las tablas y en el caso de las consultas como vistas en BigQuery.

--

__models__

- Clientes
    Materialización de vista a tabla de la tabla de Clientes.
- Compras
    Materialización de vista a tabla de la tabla de Compras.
- Exito
    Materialización de vista a tabla de la tabla de Exito.
- Olimpica
    Imputación de valores faltantes en los diferentes valores a través de la mediana.
    Materialización de vista a tabla de la tabla de Olimpica.

- __querys__
    - AverageSpending
        Se seleccionan los productos que contengan la palabra ``Vino Tinto" del inventario de Olimpica y Exito. Se calcula el recuento de compras por producto y se agrupando por producto. Finalmente, se calcula el total gastado en cada producto multiplicando la cantidad comprada por su precio. Y se calcula el promedio por almacen dividiendo la suma total del gasto entre la suma total de la cantidad, para obtener el costo promedio por unidad de vino tinto en cada almacén.
    - TopBuyers
        Se seleccionan los clientes que más compraron productos tanto en el supermercado Olimpica como Exito, contando cuántas compras hicieron. Se ordena este conjunto combinado por la cantidad de compras en orden descendente para identificar a los principales compradores de ambas tiendas juntos.
    - PopularPurchases
        Se cuenta la cantidad de veces que aparece cada producto se ordena de manera descendente y se toma el top 3 de estos.
    - UniqueOlimpicaBuyers
        Se seleccionan los distintos clientes que han comprado en el supermercado Olimpica y se compara con la selección de los distintos clientes que han comprado en el supermercado Exito para tomar aquellos que han comprado en Olimpica y no en Exito. (No existen clientes que cumplan con estas características)
    - UnpurchasedItems
        Se seleccionan los códigos de productos del supermercado Olimpica y Exito que no están presentes en la tabla de compras. Posteriormente, los códigos de productos que no se han encontrado en las tablas de compras de los supermercados Olimpica y Exito y los presenta en orden ascendente según sus códigos.