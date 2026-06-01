{{
    config(
        materialized='ephemeral'
    )
}}

select * from {{source('sources', 'categories')}}