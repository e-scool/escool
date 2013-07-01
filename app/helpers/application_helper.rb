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

  def header_subtitle
    if current_user.teacher?
      current_user.current_classroom.name
    elsif current_user.parent?
      current_user.current_child.name
    end
  end

  def active?(boolean)
    boolean ? " class=active" : ''
  end

  def active_path?(path)
    active?(request.path == path)
  end

  def admin_remote_request(type, path, target_tag_id, params={})
    "$.#{type}('#{path}', {#{params.collect { |p| "#{p[0]}: #{p[1]}" }.join(", ")}}, function(data) {$('##{target_tag_id}').html(data);});"
  end

  def current_classroom
    if current_user.parent?
      current_user.current_child.classroom
    else
      current_user.current_classroom
    end
  end

  def sidebar_menu(classroom)
    menu_list = "<ul class='nav nav-list sidemenu'>"
    menu_list << "<li#{active_path?(dashboard_path)}><a href='#{dashboard_url}'><img src='#{asset_path('icons/dashboard-mini.png')}' />#{t ('sections.dashboard')}</a></li>"
    menu_list << "<li#{active_path?(calendar_path)}><a href='#{calendar_url}'><img src='#{asset_path('icons/calendar-mini.png')}' />#{t ('sections.calendar')}</a></li>"

    optional_sections = ['daily_activities', 'lunch_reports', 'materials', 'communications']

    optional_sections.each do |i|
      menu_list << "<li#{active_path?(eval(i + '_path'))}><a href='#{eval(i + '_url')}'><img src='#{asset_path('icons/' + i + '-mini.png')}' />#{t ('sections.' + i)}</a></li>" if eval("classroom.classroom_type.#{i}?")
    end

    menu_list << "<li#{active_path?(teachers_path)}><a href='#{teachers_url}'><img src='#{asset_path('icons/docents-mini.png')}' />#{t ('sections.docents')}</a></li>"
    menu_list << "</ul>"

    menu_list.html_safe
  end
  
end
