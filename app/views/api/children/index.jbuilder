json.children @children do |child|
  json.partial! 'api/children/child', child: child
end