
# Description:
#   點餐
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot 點餐開始
#   hubot <item>
#   hubot 點餐結束
#
_ = require 'underscore'

class Order
  constructor: (@item, @user)->

  toString: ()->
    "#{@user} 點了 #{@item}"

module.exports = (robot) ->

  isOrdering = false
  orders = []

  robot.respond /點餐開始/i, (msg) ->
    if not isOrdering
      msg.send "大家請開始點餐吧!"
      isOrdering = true

    msg.finish()

  robot.respond /點餐結束/i, (msg)->
    isOrdering = false
    # send summary
    msg.send _.reduce(
      orders,
      ((current, order)-> current + "\n" + order.toString()),
      "點餐結束，統計如下："
    )
    msg.finish()

  robot.respond /(.+)/i, (msg)->
    if isOrdering
      item = msg.match[1].trim()
      user = msg.message.user.name or "路人"
      orders.push new Order(item, user)
    else
      msg.send "還沒開始點餐"
