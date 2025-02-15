# frozen_string_literal: true

module ApplicationHelper
  def js_component(component_name, **props)
    content_tag(
      'div',
      id: props[:component_id],
      class: props[:component_class],
      data: {
        js_component: component_name,
        props: component_props(props),
        children: props[:children]&.to_json
      }.compact
    ) { '' }
  end

  private

  def component_props(props)
    props
      .except(:component_id, :component_class, :children)
      .deep_transform_keys! { |key| key.to_s.camelize(:lower) }
      .to_json
  end
end
