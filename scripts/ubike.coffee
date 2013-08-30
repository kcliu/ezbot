module.exports = (robot) ->
  robot.respond /ubike (.*)/i, (msg) ->
    msg.send msg.match
