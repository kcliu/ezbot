sax = require 'sax'
Q = require 'q'
parser = sax.parser(true)
xml = module.exports = {}

xml.parse_xml = (xml) ->
  markers = []
  deferred = Q.defer()
  parser.onclosetag = (tagName) ->
  parser.onopentag = (tag) =>
    if (tag.name? and tag.name is 'marker')
      markers.push(tag.attributes)
  parser.ontext = (text) ->
  parser.onend = =>
    ubike_stations = JSON.stringify(markers)
    deferred.resolve(markers)
  parser.write(xml).end()
  deferred.promise
