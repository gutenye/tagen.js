describe 'Tagen', ->
  describe '.reopen', ->
    it 'a Class', ->
      Tagen.reopen Object,
        c: 1
      a = {a: 1} 

      expect(a.c).toEqual 1

      keys = []
      for k of a
        keys.push k
      expect(keys).toEqual ['a']

    it 'a Guten', ->
      class Guten
        # pass
      Tagen.reopen Guten,
        c: 1

      g = new Guten
      expect(g.c).toEqual 1

    it 'a <#Object>', ->
      a = {a: 1}
      a.reopen
        c: 1

      expect(a.c).toEqual 1

    it 'alias mixin', ->
      expect(Tagen.mixin).toBe Tagen.reopen

  describe '.reopenClass', ->
    it 'an Object', -> 
      Tagen.reopenClass Object,
        c: 1

      expect(Object.c).toEqual 1

  describe '.uniqueId', ->
    it 'can generate a globally-unique stream', ->
      [ a, b ] = [ [], [] ]
      for i in [0...100]
        a.push i.toString()
        b.push Tagen.uniqueId()

      expect(a).toEqual b

    it 'with prefix', ->
      expect(Tagen.uniqueId('guten')).toEqual 'guten100'

  describe '.try', ->
    it 'return null if object is null', ->
      expect(Tagen.try(null, 'length')).toBeNull()

    it 'calls a method with arguments', ->
      expect(Tagen.try([1,2], 'slice', 1)).toEqual [2]

    it 'return null if no method', ->
      expect(Tagen.try({}, 'foo_method')).toBeNull()

  describe '.escape', ->
    it 'return safe HTML characters', ->
      chars = {
        '"': '&quot;'
        "'": '&#x27;'
        '/': '&#x2F;'
        '>': '&gt;'
        '<': '&lt;'
      }

      for k, v of chars
        expect(Tagen.escape(k)).toEqual v

  describe '.isEqual', ->
    it 'Number', ->
      expect(Tagen.isEqual(1, 1)).toTruthy
      expect(Tagen.isEqual(1, 2)).toFalsy

    it 'String', ->
      expect(Tagen.isEqual('1', '1')).toTruthy
      expect(Tagen.isEqual('1', '2')).toFalsy

    it 'Object', ->
      expect(Tagen.isEqual({a:1}, {a:1})).toTruthy
      expect(Tagen.isEqual({a:1}, {a:2})).toFalsy

    it 'Array', ->
      expect(Tagen.isEqual([1], [1])).toTruthy
      expect(Tagen.isEqual([1], [2])).toFalsy
