describe 'Number', ->
  describe '.max', ->
    it 'get the largest value', ->
      expect(Number.max(1, 2)).toEqual(2)
      expect(Number.max(2, 1)).toEqual(2)

  describe '.min', ->
    it 'get the minium value', ->
      expect(Number.min(1, 2)).toEqual(1)
      expect(Number.min(2, 1)).toEqual(1)
