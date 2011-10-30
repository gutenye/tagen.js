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

  describe '(R) constructorName', ->
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

