with stg_region as (
    select 
        {{ make_hashpk(['R_REGIONKEY'], pkname='hash_regionkey') }},
        R_REGIONKEY as REGIONKEY,
        R_NAME as NAME,
        R_COMMENT as COMMENT,
        {{ make_hashdiff(['R_NAME','R_COMMENT']) }},
        {{ make_tracefields(source='raw_region') }}
    from {{ ref('raw_region') }}
)

select * from stg_region
/*UNION ALL
select 
        CAST(MD5_BINARY(CONCAT(
    IFNULL(NULLIF(UPPER(TRIM(CAST(5 AS VARCHAR))), ''),'^^')
		)) AS BINARY(16)) AS hash_regionkey,
        5 as REGIONKEY,
        'UTOPIA' as NAME,
        'Todo va bien en mi DW.' as COMMENT,
        CAST(MD5_BINARY(CONCAT(
    IFNULL(NULLIF(UPPER(TRIM(CAST('UTOPIA' AS VARCHAR))), ''),'^^'),'||',
		IFNULL(NULLIF(UPPER(TRIM(CAST('Todo va bien en mi DW.' AS VARCHAR))), ''),'^^'))) AS BINARY(16)) AS hashdiff,
        upper('raw_region') as RECORD_SOURCE,
    TO_NUMBER(TO_CHAR(SYSDATE(),'YYYYMMDD')) as LOAD_DATE
    */