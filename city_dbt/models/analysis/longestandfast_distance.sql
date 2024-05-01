{{ config(materialized='view') }}


with fastest_and_longest_distance as (
    select *

        from {{ref('fast_vechile')}} 
        
        order by 
            traveled_distance DESC
)

select *
from fastest_and_longest_distance