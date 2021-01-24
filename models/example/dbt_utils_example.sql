
{{ config(materialized='table') }}

with source_data as (

    select {{ dbt_utils.hash('1') }} as id

)

select *
from source_data
