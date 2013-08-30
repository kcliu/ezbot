xml = require '../lib/xml'
util = require '../lib/util'

module.exports = (robot) ->
  robot.respond /ubike (.*)/i, (msg) ->
    query = "http://www.youbike.com.tw/genxml9.php?lat=25.037525&lng=121.56378199999995&radius=5&mode=0"
    msg.http(query)
      .get() (err, res, body) ->
        xml.parse_xml(body)
          .then (markers) ->
            if markers
              msg.send "#{station.name}: 剩餘車輛：#{station.tot}台, 總共：#{station.qqq}台" for station in util.search(msg.match[1], markers)
            else
              msg.send 'ubike request error'
          .done()


