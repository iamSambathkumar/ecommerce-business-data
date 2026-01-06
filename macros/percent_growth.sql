{% macro percent_growth(old_value, new_value) %}
    CASE
        WHEN {{ old_value }} IS NULL OR {{ old_value }} = 0 THEN NULL
        ELSE ({{ new_value }} - {{ old_value }}) / {{ old_value }} * 100
    END
{% endmacro %}