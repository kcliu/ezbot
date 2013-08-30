util = require '../lib/util'
{expect} = require('chai')

describe 'search', ->
  markers = [
    {
      name: "市政府捷運站"
    },
    {
      name: "捷運國父紀念館站"
    },
    {
      name: "台北車站"
    }
  ]
  it 'should be single match', ->
    expect(util.search('台北', markers)).to.have.length(1)
    expect(util.search('台北', markers)[0].name).to.equal('台北車站')

  it 'should be multiple matches', ->
    expect(util.search('捷運', markers)).to.have.length(2)
    expect(util.search('捷運', markers)[0].name).to.equal('市政府捷運站')
    expect(util.search('捷運', markers)[1].name).to.equal('捷運國父紀念館站')
