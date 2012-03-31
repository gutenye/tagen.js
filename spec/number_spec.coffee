describe "Number", ->
  describe "._max", ->
    it "get the largest value", ->
      expect(Number._max(1, 2)).toEqual(2)
      expect(Number._max(2, 1)).toEqual(2)

  describe "._min", ->
    it "get the minium value", ->
      expect(Number._min(1, 2)).toEqual(1)
      expect(Number._min(2, 1)).toEqual(1)

  describe "#_times", ->
    it "works", ->
      a = []
      b = [0, 1, 2]
      (3)._times (i) ->
        a.push i

      expect(a).toEqual b

    it "starts with 1", ->
      a = []
      b = [1, 2, 3]
      (3)._times 1, (i)->
        a.push i
      expect(a).toEqual b

  describe "#_div", ->
    it "returns the largest integer less than or equal to a number", ->
      1._div(2).should == 0

  describe "#_fdiv", ->
    it "do float division", ->
      1._fdiv(2).should == 0.5

  describe "#_toInteger", ->
    it "returns the largest integer less than or equal to a number", ->
      0.5._toInteger().should == 0
