module SidebarHelper

  # Public: The sidebar menu list for the given classroom.
  #
  # classroom - A Classroom.
  #
  # Returns HTML <ul> tag.
  def sidebar_menu(classroom)
    content_tag(:nav, '', id: 'sidebar-menu') do
      concat(link('dashboard'))
      # concat(item('calendar'))

      optional_sections = ClassroomType::OPTIONAL_SECTIONS
      optional_sections.each do |section|
        concat(link(section)) if eval("classroom.classroom_type.#{section}?")
      end

      # concat(item('teachers'))
    end
  end

  private

  # Internal: A link of the sidebar menu.
  #
  # name - String with the name of the section.
  #
  # Returns a HTML <a> tag.
  def link(name)
    item_url = eval(name + '_url')
    css_class = link_class("#{name}")

    link_to(I18n.t(name, scope: 'sections'), item_url, class: css_class)
  end

  # Internal: The class of the link.
  #
  # name - String with the name of the section.
  #
  # Returns a String.
  def link_class(name)
    class_attr = name
    class_attr << ' active' if controller.controller_name == "#{name}"
    class_attr
  end
end