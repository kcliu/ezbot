'use strict'

moreTextAPI = "http://more.handlino.com/sentences.json"

module.exports = (robot) ->
  robot.respond /.*how (r|are) (u|you).*/i, (msg) ->
    msg.http(moreTextAPI)
      .get() (err, res, body)->
        msg.send JSON.parse(body).sentences[0]
