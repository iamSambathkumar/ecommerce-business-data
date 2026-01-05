SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.subcategory,
    s.supplier_name,
    p.unit_price,
    p.cost,
    p.discontinued
FROM {{ ref('stg_products') }} p
LEFT JOIN {{ ref('stg_suppliers') }} s
  ON p.supplier_id = s.supplier_id;
