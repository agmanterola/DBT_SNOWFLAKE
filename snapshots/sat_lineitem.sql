{% snapshot sat_lineitem %}

    {% set new_schema = target.schema + '_snapshot' %}

    {{
        config(
            target_database='DV',
            target_schema=new_schema,
            unique_key='hash_lineitemkey',

            strategy='check',
            check_cols=['hashdiff']
        )
    }}

    select * from {{ ref('stg_lineitem') }}

{% endsnapshot %}