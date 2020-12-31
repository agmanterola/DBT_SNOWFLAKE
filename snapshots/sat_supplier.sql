{% snapshot sat_supplier %}

    {% set new_schema = target.schema + '_snapshot' %}

    {{
        config(
            target_database='DV',
            target_schema=new_schema,
            unique_key='hash_supplierkey',

            strategy='check',
            check_cols=['hashdiff'],
        )
    }}

    select * from {{ ref('stg_supplier') }}

{% endsnapshot %}