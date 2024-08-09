{% macro learn_variables() %}
    {% set your_name_jijja = "Melwin" %}
    {{ log("Hello " ~ your_name_jijja, info=True )}}
{% endmacro %}
-- To Run individually dbt run-operation learn_variables (last one is the macro function name)