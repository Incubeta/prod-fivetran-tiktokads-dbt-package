{% macro add_custom_fields() %}
  {%- if var('tiktok_custom_fields', None) is not none -%}
    {%- set custom_fields = var('tiktok_custom_fields').split(',') -%}
    {%- for field in custom_fields -%}
      SAFE_CAST({{ field }} AS STRING) AS {{ field }},
    {%- endfor -%}
  {%- endif -%}
{% endmacro %}
