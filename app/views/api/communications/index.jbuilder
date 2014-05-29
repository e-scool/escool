json.communications @communications do |c|
  json.partial! 'api/communications/communication', communication: c
end