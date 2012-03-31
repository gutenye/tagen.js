describe 'Hash', ->
  _a = H(a: 1, b: 2, c: 3)

  describe '#_each', ->
    it 'works', ->
      a = H(a: 1, b: 2)
      b = {}

      a._each (k, v)->
        b[k] = v

      expect(b).toEqual a.data

    it 'break if throw a BREAKER', ->
      a = H(a: 1, b: 2, c: 3)
      b = {}
      c = {a: 1}

      a._each (k, v) ->
        throw BREAKER if v == 2
        b[k] = v

      expect(b).toEqual c

  describe '#_keys', ->
    it 'works', ->
      Hash::b = 1
      a = H(a: 1)
      b = ['a']
      expect(a._keys()).toEqual b

  describe '#_values', ->
    it 'works', ->
      Hash::b = 2
      a = H(a: 1)
      b = [1]
      expect(a._values()).toEqual b

  describe '#_hasKey', ->
    it 'works', ->
      a = H(a: 1)
      expect(a._hasKey('a')).toBeTruthy
      expect(a._hasKey('b')).toBeFalsy

  describe '#_hasValue', ->
    it 'works', ->
      a = H(a: 1)
      expect(a._hasValue(1)).toBeTruthy
      expect(a._hasValue(2)).toBeFalsy

  describe '#_toHash', ->
    it 'returns itself', ->
      h = H()

      expect(h._toHash()).toBe h

  describe '#_fetch', ->
    it 'return the value', ->
      expect(_a._fetch('a')).toEqual 1

    it "returns null if don't have the key", ->
      expect(_a._fetch('z')).toEqual null

    it 'default value', ->
      expect(_a._fetch('z', 2)).toEqual 2
      expect(_a._fetch('z')).toEqual null
      expect(_a._fetch('a', 2)).toEqual 1

  describe '#store', ->
    _x = null
    beforeEach ->
      _x = H()

    it 'k and v', ->
      _x._store('a', 1)
      expect(_x._fetch('a')).toEqual 1

  describe '#_fetch_or_store', ->
    _x = null
    beforeEach ->
      _x = H(a: 1)

    it 'fetch the existing value', ->
      expect(_x._fetch_or_store('a', 2)).toEqual 1

    it 'store the missing value', ->
      expect(_x._fetch_or_store('b', 2)).toEqual 2
      expect(_x._fetch('b')).toEqual 2

  describe '#toString', ->
    it 'works', ->
      a = {a: 1}
      expect(H(a).toString()).toEqual a.toString()
