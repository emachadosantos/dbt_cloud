with prod as (
    select
        ct.CategoryName as category_name,
        sp.CompanyName as supliers,
        pd.UnitPrice as unit_price,
        pd.ProductID as product_id
    from {{source('sources', 'products')}} as pd
        left join {{source('sources', 'suppliers')}} as sp
            on (pd.SupplierID = sp.SupplierID)
        left join {{source('sources', 'categories')}} as ct
            on (pd.CategoryID = ct.CategoryID)
)

, orddetai as(
    select
        pd.*,
        od.order_id,
        od.quantity,
        od.discount
    from {{ref('order_details')}} as od
        left join prod as pd
            on (od.product_id = pd.product_id)

)

, ordrs as (

    select
        ord.OrderDate as order_date,
        ord.OrderID as order_id,
        cs.company_name as customer,
        em.full_name as employee,
        em.age,
        em.length_of_service
    from {{source('sources', 'orders')}} as ord
        left join {{ref('customers')}} as cs
            on (ord.CustomerID = cs.customer_id)
        left join {{ref('employees')}} as em
            on (ord.EmployeeID = em.employee_id)
        left join {{source('sources', 'shippers')}} as sh
            on (ord.ShipVia = sh.ShipperID)

)


, final_join as (
    select
    od.*,
    ord.order_date,
    ord.customer,
    ord.employee,
    ord.age,
    ord.length_of_service
    from orddetai as od
        inner join ordrs as ord
            on (od.order_id = ord.order_id)

)

select * from final_join

