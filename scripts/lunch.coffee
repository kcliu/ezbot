# restaurant search
xml = require '../lib/xml'
util = require '../lib/util'
_ = require 'underscore'
lunch = require "#{__dirname}/../data/menuPics.json"
module.exports = (robot) ->
  robot.respond /lunchgod/i, (msg) ->
    console.log lunch
    msg.send "神說...今天就吃:"
    msg.send _.chain(lunch).values()
      .shuffle()
      .first()
      .value()

  robot.respond /lunchall/i, (msg) ->
    console.log _.keys(lunch)
    msg.send _.keys(lunch)

  robot.respond /lunch (.*)/i, (msg) ->
    msg.send lunch[msg.match[1]]


