describe 'Object', ->
  describe '#reopen', ->
    it 'works', ->
      a = {}
      a.reopen
        b: 1

      expect(a.b).toEqual 1

  describe '#instanceOf', ->
    it 'Boolean', ->
      expect(true.instanceOf(Boolean)).toBeTruthy()
      expect(false.instanceOf(Boolean)).toBeTruthy()

    it 'Number', ->
      expect(1.instanceOf(Number)).toBeTruthy()
      expect(1.0.instanceOf(Number)).toBeTruthy()

    it 'String', ->
      expect('x'.instanceOf(String)).toBeTruthy()

    it 'Array', ->
      expect([].instanceOf(Array)).toBeTruthy()

    it 'Object', ->
      expect({}.instanceOf(Object)).toBeTruthy()

    it 'Function', ->
      expect((->).instanceOf(Function)).toBeTruthy()

    it 'Date', ->
      expect((new Date()).instanceOf(Date)).toBeTruthy()

    it 'RegExp', ->
      expect(//.instanceOf(RegExp)).toBeTruthy()

    it 'coffescript Class', ->
      class Guten
        # pass
      expect((new Guten).instanceOf(Guten)).toBeTruthy()

  describe '#constructorName', ->
    it 'Boolean', ->
      expect(true.constructorName()).toEqual 'Boolean'
      expect(false.constructorName()).toEqual 'Boolean'

    it 'Number', ->
      expect(1.constructorName()).toEqual 'Number'
      expect(1.0.constructorName()).toEqual 'Number'

    it 'String', ->
      expect('x'.constructorName()).toEqual 'String'

    it 'Array', ->
      expect([].constructorName()).toEqual 'Array'

    it 'Object', ->
      expect({}.constructorName()).toEqual 'Object'

    it 'Function', ->
      expect((->).constructorName()).toEqual 'Function'

    it 'Date', ->
      expect((new Date).constructorName()).toEqual 'Date'

    it 'RegExp', ->
      expect(//.constructorName()).toEqual 'RegExp'

    it 'coffescript Class', ->
      class Guten
        # pass
      expect((new Guten).constructorName()).toEqual 'Guten'
      
  describe '#isNaN', ->
    it 'works', ->
      expect(NaN.isNaN()).toBeTruthy
      expect('x'.isNaN()).toBeFalsy

  describe '#isEmpty', ->
    it 'works', ->
      expect({}.isEmpty()).toBeTruthy
      expect({a: 1}.isEmpty()).toBeFalsy

    it "don't count Object.prorotype property", ->
      Object::a = 1
      expect({}.isEmpty()).toBeTruthy

  describe '#tap', ->
    it 'works', ->
      b = []
      a = {a: 1}
      ret = a.tap (self)->
        b.push self.a

      expect(ret).toBe a
      expect(b).toEqual [1]

  describe '#clone', ->
    it 'return a shallow clone', ->
      a = {a: 1}
      
      expect(a.clone()).toEqual {a: 1}

  describe '#methods', ->
    it 'return all methods of the object', ->
      Object::b = ->
      a = {a: 1}
      expect(a.methods()).toEqual ['b']

  describe '#each', ->
    it 'works', ->
      a = {a: 1, b: 2}
      b = {}

      a.each (k, v)->
        b[k] = v

      expect(b).toEqual a

    it 'break if throw a BREAKER', ->
      a = {a: 1, b: 2, c: 3}
      b = {}
      c = {a: 1}

      a.each (k, v) ->
        throw BREAKER if v == 2
        b[k] = v

      expect(b).toEqual c

  describe '#keys', ->
    it 'works', ->
      Object::b = 1
      a = {a: 1}
      b = ['a']
      expect(a.keys()).toEqual b

  describe '#values', ->
    it 'works', ->
      Object::b = 2
      a = {a: 1}
      b = [1]
      expect(a.values()).toEqual b

  describe '#hasKey', ->
    it 'works', ->
      Object::c = 2
      a = {a: 1}
      expect(a.hasKey('a')).toBeTruthy
      expect(a.hasKey('b')).toBeFalsy
      expect(a.hasKey('c')).toBeFalsy

  describe '#hasValue', ->
    it 'works', ->
      Object::c = 3
      a = {a: 1}
      expect(a.hasValue(1)).toBeTruthy
      expect(a.hasValue(2)).toBeFalsy
      expect(a.hasValue(3)).toBeFalsy

