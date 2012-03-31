describe 'Enumerator', ->
  describe '#_with_object', ->
    it 'Array', ->
      a = new Enumerator([1,2])
      b = [ [1, 0], [2, 1] ]
      ret = a._with_object [], (memo, v, i) ->
        memo.push [v, i]

      expect(ret).toEqual b
