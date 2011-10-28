describe 'Core', ->
  describe 'reopen()', ->
    it 'a Object with defineProperty', ->
      Tagen.reopen Object, 
        c: 1
      a = {a: 1} 

      expect(a.c).toEqual 1

      keys = []
      for k of a
        keys.push k
      expect(keys).toEqual ['a']

    it 'a <#Object>', ->
      a = {a: 1}
      Tagen.reopen a,
        c: 1

      expect(a.c).toEqual 1

    it 'a Guten', ->
      class Guten
        # pass
      Tagen.reopen Guten,
        c: 1

      g = new Guten
      expect(g.c).toEqual 1


  describe 'reopenClass()', ->
    it 'a Class', -> 
      Tagen.reopenClass Object,
        c: 1

      expect(Object.c).toEqual 1
