# Food search
https = require 'https'

Q = require 'q'
_ = require 'underscore'

{gmap} = require "#{__dirname}/../data/feedme.json"

url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
print = -> # no-op

getJSON = (options) ->
  deferred = do Q.defer
  cache = ''

  cb = (res) ->
    print "recieved status code #{res.statusCode}"
    res.setEncoding 'utf8'

    res
      .on 'data', (chunk) ->
        cache += chunk
        print 'recieved chunk'
      .on 'end', ->
        deferred.resolve JSON.parse cache
        print 'connection ended without error'

  print "requesting #{options}"

  https
    .get(options, cb)
    .on 'error', (err) ->
      deferred.reject err

  deferred.promise

module.exports = (robot) ->

  robot.respond /feed me/, (msg) ->
    param = ("#{k}=#{v}" for k, v of gmap).join '&'

    getJSON("#{url}#{param}")
      .fail (e) ->
        print e
      .done ({results}) ->
        msg.send _.chain(results)
          .pluck('name')
          .shuffle()
          .first(3)
          .value()
