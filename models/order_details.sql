select
    od.OrderID as order_id,
    od.ProductID as product_id,
    od.UnitPrice as unit_price,
    od.Quantity as quantity,
    pr.ProductName as product_name,
    pr.SupplierID as supplier_id,
    pr.CategoryID as category_id,
    od.UnitPrice * od.Quantity as total,
    (pr.UnitPrice * od.Quantity) - (od.UnitPrice * od.Quantity) as discount
from {{source('sources', 'orderdetails')}} as od
    left join {{source('sources', 'products')}} as pr
        on od.ProductID = pr.ProductID




