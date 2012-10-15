window.Footnotes = 

  Models: {}

  Collections: {}

  Routers: {}
  
  Views: {}

  template: (filename) ->
    return HoganTemplates[filename]

  formToObj: (form) ->
    data = form.serializeArray()
    obj = {}
    for item in data
      obj[item['name']] = item['value']
    return obj




        
