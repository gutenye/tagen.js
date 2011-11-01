describe 'Hash', ->
  _a = H(a: 1, b: 2, c: 3)

  describe '#each', ->
    it 'works', ->
      a = H(a: 1, b: 2)
      b = {}

      a.each (k, v)->
        b[k] = v

      expect(b).toEqual a.data

    it 'break if throw a BREAKER', ->
      a = H(a: 1, b: 2, c: 3)
      b = {}
      c = {a: 1}

      a.each (k, v) ->
        throw BREAKER if v == 2
        b[k] = v

      expect(b).toEqual c

  describe '#keys', ->
    it 'works', ->
      Hash::b = 1
      a = H(a: 1)
      b = ['a']
      expect(a.keys()).toEqual b

  describe '#values', ->
    it 'works', ->
      Hash::b = 2
      a = H(a: 1)
      b = [1]
      expect(a.values()).toEqual b

  describe '#hasKey', ->
    it 'works', ->
      a = H(a: 1)
      expect(a.hasKey('a')).toBeTruthy
      expect(a.hasKey('b')).toBeFalsy

  describe '#hasValue', ->
    it 'works', ->
      a = H(a: 1)
      expect(a.hasValue(1)).toBeTruthy
      expect(a.hasValue(2)).toBeFalsy

  describe '#toHash', ->
    it 'returns itself', ->
      h = H()

      expect(h.toHash()).toBe h

  describe '#fetch', ->
    it 'return the value', ->
      expect(_a.fetch('a')).toEqual 1

    it "returns null if don't have the key", ->
      expect(_a.fetch('z')).toEqual null

    it 'default value', ->
      expect(_a.fetch('z', 2)).toEqual 2
      expect(_a.fetch('z')).toEqual null
      expect(_a.fetch('a', 2)).toEqual 1

  describe '#store', ->
    _x = null
    beforeEach ->
      _x = H()

    it 'k and v', ->
      _x.store('a', 1)
      expect(_x.fetch('a')).toEqual 1

  describe '#fetch_or_store', ->
    _x = null
    beforeEach ->
      _x = H(a: 1)

    it 'fetch the existing value', ->
      expect(_x.fetch_or_store('a', 2)).toEqual 1

    it 'store the missing value', ->
      expect(_x.fetch_or_store('b', 2)).toEqual 2
      expect(_x.fetch('b')).toEqual 2

  describe '#toString', ->
    it 'works', ->
      a = {a: 1}
      expect(H(a).toString()).toEqual a.toString()
