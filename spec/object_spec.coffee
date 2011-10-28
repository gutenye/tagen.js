describe 'Object', ->
  describe '#reopen', ->
    it 'works', ->
      a = {}
      a.reopen
        b: 1

      expect(a.b).toEqual 1

  describe '#isInstanceOf', ->
    it 'Boolean', ->
      expect(true.isInstanceOf(Boolean)).toBeTruthy()
      expect(false.isInstanceOf(Boolean)).toBeTruthy()
    it 'Number', ->
      expect(1.isInstanceOf(Number)).toBeTruthy()
      expect(1.0.isInstanceOf(Number)).toBeTruthy()
    it 'String', ->
      expect('x'.isInstanceOf(String)).toBeTruthy()
    it 'Array', ->
      expect([].isInstanceOf(Array)).toBeTruthy()
    it 'Object', ->
      expect({}.isInstanceOf(Object)).toBeTruthy()
    it 'Function', ->
      expect((->).isInstanceOf(Function)).toBeTruthy()
    it 'Date', ->
      expect((new Date()).isInstanceOf(Date)).toBeTruthy()
    it 'RegExp', ->
      expect(//.isInstanceOf(RegExp)).toBeTruthy()
    #it 'Arguments', ->
      #expect(1.isInstanceOf('Arguments')).toBeTruthy()
    #it 'Element', ->
      #expect(1.isInstanceOf('Element')).toBeTruthy()
    it 'coffescript Class', ->
      class Guten
        # pass
      expect((new Guten).isInstanceOf(Guten)).toBeTruthy()

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

