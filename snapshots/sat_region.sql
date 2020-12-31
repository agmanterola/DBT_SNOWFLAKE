{% snapshot sat_region %}

    {% set new_schema = target.schema + '_snapshot' %}

    {{
        config(
            target_database='DV',
            target_schema=new_schema,
            unique_key='hash_regionkey',

            strategy='check',
            check_cols=['hashdiff'],
        )
    }}

    select * from {{ ref('stg_region') }}

{% endsnapshot %}