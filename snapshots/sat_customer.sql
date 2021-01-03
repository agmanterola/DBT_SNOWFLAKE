{% snapshot sat_customer %}

    {% set new_schema = target.schema + '_snapshot' %}

    {{
        config(
            target_database='DV',
            target_schema=new_schema,
            unique_key='hash_customerkey',

            strategy='check',
            check_cols=['hashdiff']
        )
    }}

    select * from {{ ref('stg_customer') }}

{% endsnapshot %}