{% macro null_non_existing_fields() %}
  {%- if var('tiktok_non_existing_fields', None) is not none -%}
    {%- set custom_fields = var('tiktok_non_existing_fields').split(',') -%}
    {%- for field in custom_fields -%}
      SAFE_CAST(NULL AS STRING) AS {{ field }}{{ "," if not loop.last }}
    {%- endfor -%}
  {%- endif -%}
{% endmacro %}
