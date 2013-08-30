xml = require '../lib/xml'
{expect} = require('chai')

describe 'xml parser', ->
  it 'should get structured data', ->
    example = """
    <markers>
    <marker name="捷運市政府站(3號出口)-1" address="忠孝東路/松仁路(東南側)" nameen="MRT Taipei City Hall Stataion(Exit 3)-1" addressen=" " lat="25.040670" lng="121.568283" tot="26" sus="65" distance="8175.23245403446" mday="08/30 18:32:05" icon_type="2" qqq="92" />
    <marker name="捷運市政府站(3號出口)-2" address="忠孝東路/松仁路(東南側)" nameen="MRT Taipei City Hall Stataion(Exit 3)-2" addressen="" lat="25.040857" lng="121.567902" tot="30" sus="58" distance="8175.20609091164" mday="08/30 18:32:17" icon_type="2" qqq="88" />
    <marker name="捷運國父紀念館站" address="捷運國父紀念館站(3號出口) " nameen="MRT S.Y.S Memorial Hall Stataion" addressen="" lat="25.041082" lng="121.557800" tot="32" sus="6" distance="8174.59015736048" mday="08/30 18:32:12" icon_type="2" qqq="38" />
    </markers>
    """
    xml.parse_xml(example)
      .then (markers) ->
        expect(markers).to.have.length(3)
        expect(markers[0].name).to.equal('捷運市政府站(3號出口)-1')
      .done()
