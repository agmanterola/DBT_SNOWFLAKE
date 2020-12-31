with stg_nation as (
    select 
        {{ make_hashpk(['N_NATIONKEY'], pkname='hash_nationkey') }},
        N_NATIONKEY as NATIONKEY,
        N_NAME as NAME,
        N_REGIONKEY as REGIONKEY,
        N_COMMENT as COMMENT,
        {{ make_hashdiff(['N_NAME','N_REGIONKEY','N_COMMENT']) }},
        {{ make_tracefields(source='raw_nation') }}
    from {{ ref('raw_nation') }}
)

select * from stg_nation
UNION ALL
select 
        CAST(MD5_BINARY(CONCAT(
    IFNULL(NULLIF(UPPER(TRIM(CAST(25 AS VARCHAR))), ''),'^^')
		)) AS BINARY(16)) AS hash_nationkey,
        25 as NATIONKEY,
        'MI PAIS' as NAME,
        5 as REGIONKEY,
        'Mi país en el DW.' as COMMENT,
        CAST(MD5_BINARY(CONCAT(
    IFNULL(NULLIF(UPPER(TRIM(CAST('MI PAIS' AS VARCHAR))), ''),'^^'),'||',
    IFNULL(NULLIF(UPPER(TRIM(CAST(5 AS VARCHAR))), ''),'^^'),'||',
		IFNULL(NULLIF(UPPER(TRIM(CAST('Mi país en el DW.' AS VARCHAR))), ''),'^^'))) AS BINARY(16)) AS hashdiff,
        upper('raw_nation') as RECORD_SOURCE,
    TO_NUMBER(TO_CHAR(SYSDATE(),'YYYYMMDD')) as LOAD_DATE