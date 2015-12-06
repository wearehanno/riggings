def link_to_page name, url
  path = request.path
  current = false

  current = url + "/index.html" == path

  if path == 'index.html' and url =="/"
    current = true
  end

  class_name = current ? ' class="active"' : ''

  "<li#{class_name}><a href=\"#{url}\">#{name}</a></li>"
end
