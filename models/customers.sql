with
    markup as (

        select
            *,
            first_value(customerid) over (
                partition by companyname, contactname
                order by companyname
                rows between unbounded preceding and unbounded following
            ) as result
        from {{ source("sources", "customers") }}
    ),
    removed as (select distinct result from markup),
    final as (

        select *
        from {{ source("sources", "customers") }}
        where customerid in (select result from removed)

    )

select
    customerid as customer_id,
    companyname as company_name,
    contactname as contact_name,
    contacttitle as contact_title,
    address as address,
    city as city,
    region as region,
    postalcode as postal_code,
    country as country,
    phone as phone
from final
