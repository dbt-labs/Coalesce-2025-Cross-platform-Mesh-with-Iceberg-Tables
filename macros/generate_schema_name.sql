{% macro generate_schema_name(custom_schema_name, node) %}
    {# define base default schema, remove underscores and append 'dbx' #}
    {% set default_schema = (target.schema | replace('_', '') ~ 'dbx') | lower %}

    {# seeds go in a global raw schema (underscores removed, lowercase) #}
    {% if node.resource_type == 'seed' %}
        {{ (custom_schema_name | trim | replace('_', '') | lower) }}

    {# non-specified schemas go to the default schema (lowercased) #}
    {% elif custom_schema_name is none %}
        {{ default_schema }}

    {# in prod, combine default and custom schema (remove underscores, lowercase) #}
    {% elif target.name == 'prod' %}
        {{ ((default_schema ~ (custom_schema_name | trim | replace('_', ''))) | lower) }}

    {# for non-prod, use default schema only (lowercased) #}
    {% else %}
        {{ default_schema }}
    {% endif %}
{% endmacro %}