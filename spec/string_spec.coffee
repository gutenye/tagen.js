describe 'String', ->
  describe '#_toInteger', ->
    it 'convert a string to integer', ->
      expect('123'._toInteger()).toEqual 123

  describe '#_pluralize', ->
    it 'pluralize a word', ->
      expect('car'._pluralize()).toEqual 'cars'

  describe '#_capitalize', ->
    it 'capitalize a word', ->
      expect('car'._capitalize()).toEqual 'Car'

  describe '#_endsWith', ->
    it "check a string's end", ->
      expect('car'._endsWith('r')).toBeTruthy()
      expect('car'._endsWith('ar')).toBeTruthy()

  describe '#_reverse', ->
    it 'reverse a string', ->
      expect('car'._reverse()).toEqual 'rac'

  describe '#_isEmpty', ->
    it 'works', ->
      expect(''._isEmpty()).toBeTruthy()
      expect('x'._isEmpty()).toBeFalsy()
