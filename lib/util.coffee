util = module.exports = {}

util.search = (query, markers) ->
  re = new RegExp(query, "i")
  markers.filter (station) ->
    re.test station.name
