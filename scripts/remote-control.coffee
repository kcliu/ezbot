# Description:
#
# Commands:
#
# Examples:
https = require 'https'

Q = require 'q'
_ = require 'underscore'

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

  robot.respond /remote send ([^ .]+) (.+)/, (msg)->
    room = msg.match[1].toString('utf-8').trim()
    robot.messageRoom "58367_#{room}@conf.hipchat.com", msg.match[2]

  robot.respond /remote rooms/, (msg)->
    getJSON("https://api.hipchat.com/v1/rooms/list?auth_token=#{process.env.HIPCHAT_API_KEY}")
      .fail (e)->
        console.log e
      .done ({rooms})->
        rooms = _.chain(rooms)
          .filter((room)-> not room.is_private)
          .pluck('xmpp_jid')
          .reduce(((current, xmpp)-> current + "\n" + xmpp), "rooms: ")
          .value()

        msg.send rooms

