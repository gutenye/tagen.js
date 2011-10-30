describe 'String', ->
  describe '#toInteger', ->
    it 'convert a string to integer', ->
      expect('123'.toInteger()).toEqual 123

  describe '#pluralize', ->
    it 'pluralize a word', ->
      expect('car'.pluralize()).toEqual 'cars'

  describe '#capitalize', ->
    it 'capitalize a word', ->
      expect('car'.capitalize()).toEqual 'Car'

  describe '#endsWith', ->
    it "check a string's end", ->
      expect('car'.endsWith('r')).toBeTruthy()
      expect('car'.endsWith('ar')).toBeTruthy()

  describe '#reverse', ->
    it 'reverse a string', ->
      expect('car'.reverse()).toEqual 'rac'

  describe '#isEmpty', ->
    it 'works', ->
      expect(''.isEmpty()).toBeTruthy()
      expect('x'.isEmpty()).toBeFalsy()
