CREATE VIEW store_type AS
SELECT
    store_type,
    SUM(sale_price) AS total_sales,
    COUNT(*) AS total_orders,
    SUM(percentage_of_sales) AS percentage_of_sales
FROM
    forview
GROUP BY
    store_type;
