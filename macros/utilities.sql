{% macro make_hashpk(fields=[''], pkname='pkhash_default') -%}
	CAST(MD5_BINARY(CONCAT(
    {% for field in fields -%}
		IFNULL(NULLIF(UPPER(TRIM(CAST({{ field }} AS VARCHAR))), ''),'^^')
		{% if not loop.last %}
			,'||',
		{%- endif -%}
	{% endfor -%}
	)) AS BINARY(16)) AS {{ pkname }}
{%- endmacro %}


{% macro make_hashdiff(fields=['']) -%}
	CAST(MD5_BINARY(CONCAT(
    {% for field in fields -%}
		IFNULL(NULLIF(UPPER(TRIM(CAST({{ field }} AS VARCHAR))), ''),'^^')
		{%- if not loop.last -%}
			,'||',
		{% endif -%}
	{%- endfor -%}
	)) AS BINARY(16)) AS hashdiff
{%- endmacro %}


{% macro make_tracefields(source='default') -%}
    upper('{{ source }}') as RECORD_SOURCE,
    TO_NUMBER(TO_CHAR(SYSDATE(),'YYYYMMDD')) as LAST_SEEN
{%- endmacro %}