describe 'Number', ->
  describe '._max', ->
    it 'get the largest value', ->
      expect(Number._max(1, 2)).toEqual(2)
      expect(Number._max(2, 1)).toEqual(2)

  describe '._min', ->
    it 'get the minium value', ->
      expect(Number._min(1, 2)).toEqual(1)
      expect(Number._min(2, 1)).toEqual(1)

  describe '#_times', ->
    it 'works', ->
      a = []
      b = [0, 1, 2]
      (3)._times (i) ->
        a.push i

      expect(a).toEqual b
