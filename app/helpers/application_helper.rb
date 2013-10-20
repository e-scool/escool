module ApplicationHelper

	def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def header_title
    content_tag(:p, "#{t(controller_name, scope: 'sections')} - <span class='subtitle'>#{header_subtitle}</span>".html_safe, class: "title #{controller_name}")
  end

  def header_subtitle
    if current_user.teacher?
      current_user.current_classroom.name
    elsif current_user.parent?
      current_user.current_child.name
    end
  end

  def admin_remote_request(type, path, target_tag_id, params={})
    "$.#{type}('#{path}', {#{params.collect { |p| "#{p[0]}: #{p[1]}" }.join(", ")}}, function(data) {$('##{target_tag_id}').html(data);});"
  end

end
