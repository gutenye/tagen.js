describe "_", ->
  describe ".reopen", ->
    it "a Class", ->
      _.reopen Array,
        happy: 1
      expect(Array::happy).toEqual 1

    it "overwrite=false", ->
      Array::a = 1
      _.reopen Array,
        a: 2
        
      expect(Array::a).toEqual 1

    it "overwrite=true", ->
      Array::a = 1
      _.reopen Array, {
        a: 2
      }, true

      expect(Array::a).toEqual 2

    it "a Guten", ->
      class Guten
        # pass
      _.reopen Guten,
        c: 1

      g = new Guten
      expect(g.c).toEqual 1

    it "alias mixin", ->
      expect(_.mixin).toBe _.reopen

  describe ".reopenClass", ->
    it "a Class", -> 
      _.reopenClass Object,
        c: 1

      expect(Object.c).toEqual 1

  describe ".uniqueId", ->
    it "can generate a globally-unique stream", ->
      [ a, b ] = [ [], [] ]
      for i in [0...100]
        a.push i.toString()
        b.push _.uniqueId()

      expect(a).toEqual b

    it "with prefix", ->
      expect(_.uniqueId("guten")).toEqual "guten100"

  describe ".try", ->
    it "return null if object is null", ->
      expect(_.try(null, "length")).toBeNull()

    it "calls a method with arguments", ->
      expect(_.try([1,2], "slice", 1)).toEqual [2]

    it "return null if no method", ->
      expect(_.try({}, "foo_method")).toBeNull()

  describe ".escape", ->
    it "return safe HTML characters", ->
      chars = {
        """: "&quot;"
        """: "&#x27;"
        "/": "&#x2F;"
        ">": "&gt;"
        "<": "&lt;"
      }

      for k, v of chars
        expect(_.escape(k)).toEqual v

  describe ".isEqual", ->
    it "Number", ->
      expect(_.isEqual(1, 1)).toTruthy
      expect(_.isEqual(1, 2)).toFalsy

    it "String", ->
      expect(_.isEqual("1", "1")).toTruthy
      expect(_.isEqual("1", "2")).toFalsy

    it "Object", ->
      expect(_.isEqual({a:1}, {a:1})).toTruthy
      expect(_.isEqual({a:1}, {a:2})).toFalsy

    it "Array", ->
      expect(_.isEqual([1], [1])).toTruthy
      expect(_.isEqual([1], [2])).toFalsy

describe "Object", ->
  describe "#reopen", ->
    it "works", ->
      a = [1]
      _(a).reopen
        a: 1

      expect(a.a).toEqual 1

  describe "(R) prorotype", ->
    it "is Wrapper.property", ->
      _::a = 1
      expect(_("x").a).toEqual 1


  describe "#instanceOf", ->
    it "Boolean", ->
      expect(_(true).instanceOf(Boolean)).toBeTruthy()
      expect(_(false).instanceOf(Boolean)).toBeTruthy()

    it "Number", ->
      expect(_(1).instanceOf(Number)).toBeTruthy()
      expect(_(1.0).instanceOf(Number)).toBeTruthy()

    it "String", ->
      expect(_("x").instanceOf(String)).toBeTruthy()

    it "Array", ->
      expect(_([]).instanceOf(Array)).toBeTruthy()

    it "Object", ->
      expect(_({}).instanceOf(Object)).toBeTruthy()

    it "Function", ->
      expect(_(->).instanceOf(Function)).toBeTruthy()

    it "Date", ->
      expect(_(new Date()).instanceOf(Date)).toBeTruthy()

    it "RegExp", ->
      expect(_(//).instanceOf(RegExp)).toBeTruthy()

    it "Arguments", ->
      getArguments = -> arguments
      expect(_(getArguments()).instanceOf("Arguments")).toBeTruthy()

    it "coffescript Class", ->
      class Guten
        # pass
      expect(_(new Guten).instanceOf(Guten)).toBeTruthy()

  describe "#constructorName", ->
    it "Boolean", ->
      expect(_(true).constructorName()).toEqual "Boolean"
      expect(_(false).constructorName()).toEqual "Boolean"

    it "Number", ->
      expect(_(1).constructorName()).toEqual "Number"
      expect(_(1.0).constructorName()).toEqual "Number"

    it "String", ->
      expect(_("x").constructorName()).toEqual "String"

    it "Array", ->
      expect(_([]).constructorName()).toEqual "Array"

    it "Object", ->
      expect(_({}).constructorName()).toEqual "Object"

    it "Function", ->
      expect(_(->).constructorName()).toEqual "Function"

    it "Date", ->
      expect(_(new Date).constructorName()).toEqual "Date"

    it "RegExp", ->
      expect(_(//).constructorName()).toEqual "RegExp"

    it "Arguments", ->
      getArguments = -> arguments
      expect(_(getArguments()).constructorName()).toEqual "Arguments"

    it "coffescript Class", ->
      class Guten
        # pass
      expect(_(new Guten).constructorName()).toEqual "Guten"
      
  describe "#isNaN", ->
    it "works", ->
      expect(_(NaN).isNaN()).toBeTruthy
      expect(_("x").isNaN()).toBeFalsy

  describe "#tap", ->
    it "works", ->
      a = {a: 1}
      b = []
      c = [1]
      _(a).tap (self)->
        b.push self.a

      expect(a).toBe a
      expect(b).toEqual [1]

  describe "#clone", ->
    it "return a shallow clone", ->
      a = {a: 1}
      
      expect(_(a).clone()).toEqual {a: 1}

  describe "#methods", ->
    it "return all methods of the object", ->
      class Guten
        a: ->
        b: 2
      a = new Guten
      expect(_(a).methods()).toEqual ["a"]

  describe ".under_alias", ->
    it "works", ->
      Object::test_foo = 1
      Object::test_bar = ->

      _.under_alias Object, "test_foo", "test_bar"

      Object::_test_foo.should == Object::test_foo
      Object::_test_bar.should == Object::test_bar
