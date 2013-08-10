json.materials @materials do |c|
  json.partial! 'api/materials/material', material: c
end