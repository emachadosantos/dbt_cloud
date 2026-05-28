--model employees
with funcionarios as (
    select
        date_part('year', current_date) - date_part('year', BirthDate) as age,
        date_part('year', current_date) - date_part('year', HireDate) as length_of_service,
        concat(FirstName,' ', LastName) as full_name,
        EmployeeID as employee_id,
        LastName as last_name,
        FirstName as first_name,
        Title as title,
        TitleOfCourtesy as title_of_courtesy,
        BirthDate as birth_date,
        HireDate as hire_date,
        Address as address,
        City as city,
        Region as region,
        PostalCode as postal_code,
        Country as country,
        HomePhone as home_phone,
        Extension as extension,
        Notes as notes,
        Reportsto as reports_to,
        PhotoPath as photo_path,
        Salary as salary
    from {{source('sources', 'employees')}}
)

select

*
from funcionarios

