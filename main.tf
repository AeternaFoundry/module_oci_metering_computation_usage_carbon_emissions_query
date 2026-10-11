resource "oci_metering_computation_usage_carbon_emissions_query" "metering_computation_usage_carbon_emissions_queries" {
  for_each = var.metering_computation_usage_carbon_emissions_queries

  compartment_id = each.value.compartment_id

  query_definition {
    cost_analysis_ui {
      graph               = each.value.query_definition.cost_analysis_ui.graph
      is_cumulative_graph = each.value.query_definition.cost_analysis_ui.is_cumulative_graph
    }
    display_name = each.value.query_definition.display_name
    report_query {
      compartment_depth           = each.value.query_definition.report_query.compartment_depth
      date_range_name             = each.value.query_definition.report_query.date_range_name
      emission_calculation_method = each.value.query_definition.report_query.emission_calculation_method
      emission_type               = each.value.query_definition.report_query.emission_type
      granularity                 = each.value.query_definition.report_query.granularity
      group_by                    = each.value.query_definition.report_query.group_by
      dynamic "group_by_tag" {
        for_each = each.value.query_definition.report_query.group_by_tag != null ? each.value.query_definition.report_query.group_by_tag : []
        content {
          key       = group_by_tag.value.key
          namespace = group_by_tag.value.namespace
          value     = group_by_tag.value.value
        }
      }
      is_aggregate_by_time                = each.value.query_definition.report_query.is_aggregate_by_time
      tenant_id                           = each.value.query_definition.report_query.tenant_id
      time_usage_ended                    = each.value.query_definition.report_query.time_usage_ended
      time_usage_started                  = each.value.query_definition.report_query.time_usage_started
      usage_carbon_emissions_query_filter = each.value.query_definition.report_query.usage_carbon_emissions_query_filter
    }
    version = each.value.query_definition.version
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

