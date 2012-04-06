
describe("Array", function() {
  describe("#_each", function() {
    it("works", function() {
      var a, b, ret;
      a = [1, 2];
      b = [[1, 0], [2, 1]];
      ret = [];
      a._each(function(v, i) {
        return ret.push([v, i]);
      });
      return expect(ret).toEqual(b);
    });
    it("return <#Enumerator> when called without any arguments", function() {
      var a, b;
      a = [1, 2];
      b = a._each();
      expect(b.constructor).toEqual(Enumerator);
      return expect(b.data).toEqual(a);
    });
    return it("break if throw BREAKER", function() {
      var a, b, c;
      a = [1, 2, 3];
      b = [];
      c = [1];
      a._each(function(v) {
        if (v === 2) throw BREAKER;
        return b.push(v);
      });
      return expect(b).toEqual(c);
    });
  });
  describe("#_isEqual", function() {
    it("works", function() {
      expect([1, 2]._isEqual([1, 2])).toBeTruthy();
      return expect([1, 2]._isEqual([1, 3])).toBeFalsy();
    });
    return it("with nested array", function() {
      return expect([1, [2]]._isEqual([1, [2]])).toBeTruthy();
    });
  });
  describe("#_isInclude", function() {
    it("works", function() {
      expect([1, 2]._isInclude(2)).toBeTruthy();
      return expect([1, 2]._isInclude(9)).toBeFalsy();
    });
    return it("alias as _contains", function() {
      return expect([]._contains).toBe([]._isInclude);
    });
  });
  describe("#_isEmpty", function() {
    return it("works", function() {
      expect([]._isEmpty()).toBeTruthy();
      return expect([1]._isEmpty()).toBeFalsy();
    });
  });
  describe("#_clone", function() {
    return it("return a shadow-clone", function() {
      var a, b;
      b = [1];
      a = b._clone();
      expect(a).toEqual(b);
      return expect(a).not.toBe(b);
    });
  });
  describe("#_random", function() {
    return it("works", function() {
      var counts, data, i, k;
      data = [0, 1];
      counts = {};
      for (i = 0; i <= 9; i++) {
        k = data._random();
        if (counts[k] == null) counts[k] = 0;
        counts[k] += 1;
      }
      expect(counts[0] + counts[1]).toEqual(10);
      return expect(counts[0]).not.toEqual(10);
    });
  });
  describe("#_zip", function() {
    return it("works", function() {
      var a, b;
      a = [1, 2]._zip([3, 4]);
      b = [[1, 3], [2, 4]];
      return expect(a).toEqual(b);
    });
  });
  describe("#_first", function() {
    return it("return the first element of the array", function() {
      return expect([1, 2]._first()).toEqual(1);
    });
  });
  describe("#_last", function() {
    return it("return the last element of the array", function() {
      return expect([1, 2]._last()).toEqual(2);
    });
  });
  describe("#_compact", function() {
    return it("remove all null values", function() {
      var a, b;
      a = [1, true, null, false, []];
      b = [1, true, false, []];
      return expect(a._compact()).toEqual(b);
    });
  });
  describe("#_flatten", function() {
    it("flatten one-level", function() {
      var a, b;
      a = [1, [2]];
      b = [1, 2];
      return expect(a._flatten()).toEqual(b);
    });
    return it("flatten multi-levels", function() {
      var a, b, c;
      a = [1, [2, [3]]];
      b = [1, 2, 3];
      c = [1, 2, [3]];
      expect(a._flatten()).toEqual(b);
      return expect(a._flatten(true)).toEqual(c);
    });
  });
  describe("#_uniq", function() {
    return it("removes duplicate-values", function() {
      var a, b;
      a = [1, 3, 2, 1, 3];
      b = [1, 3, 2];
      return expect(a._uniq()).toEqual(b);
    });
  });
  describe("#_without", function() {
    return it("Take the difference between one array and another.", function() {
      var a, b, c;
      a = [1, 2, 3, 4];
      b = [2, 4];
      c = [1, 3];
      return expect(a._without.apply(a, b)).toEqual(c);
    });
  });
  describe("#_pluck", function() {
    return it("works", function() {
      var a, b;
      a = [
        {
          a: 1
        }, {
          a: 2
        }
      ];
      b = [1, 2];
      return expect(a._pluck("a")).toEqual(b);
    });
  });
  describe("#_findIndex", function() {
    it("find with a value", function() {
      var a, b;
      a = [1, 2, 3];
      b = 1;
      return expect(a._findIndex(2)).toEqual(b);
    });
    return it("find with an iterator", function() {
      var a, b, ret;
      a = [1, 2, 3];
      b = 1;
      ret = a._findIndex(function(v) {
        return v === 2;
      });
      return expect(ret).toEqual(b);
    });
  });
  describe("#_invoke", function() {
    return it("call each method", function() {
      var a, b;
      a = [1, 2];
      b = ["1", "2"];
      return expect(a._invoke("toString")).toEqual(b);
    });
  });
  describe("#_transpose", function() {
    return it("transposes an array", function() {
      var a, b;
      a = [[1, 2], [3, 4]];
      b = [[1, 3], [2, 4]];
      return expect(a._transpose()).toEqual(b);
    });
  });
  return describe("_x", function() {
    return it("works", function() {
      var a;
      a = [];
      a._push(1);
      return expect(a).toEqual([1]);
    });
  });
});

describe("_", function() {
  describe(".reopen", function() {
    it("a Class", function() {
      _.reopen(Array, {
        happy: 1
      });
      return expect(Array.prototype.happy).toEqual(1);
    });
    it("overwrite=false", function() {
      Array.prototype.a = 1;
      _.reopen(Array, {
        a: 2
      });
      return expect(Array.prototype.a).toEqual(1);
    });
    it("overwrite=true", function() {
      Array.prototype.a = 1;
      _.reopen(Array, {
        a: 2
      }, true);
      return expect(Array.prototype.a).toEqual(2);
    });
    it("a Guten", function() {
      var Guten, g;
      Guten = (function() {

        function Guten() {}

        return Guten;

      })();
      _.reopen(Guten, {
        c: 1
      });
      g = new Guten;
      return expect(g.c).toEqual(1);
    });
    return it("alias mixin", function() {
      return expect(_.mixin).toBe(_.reopen);
    });
  });
  describe(".reopenClass", function() {
    return it("a Class", function() {
      _.reopenClass(Object, {
        c: 1
      });
      return expect(Object.c).toEqual(1);
    });
  });
  describe(".uniqueId", function() {
    it("can generate a globally-unique stream", function() {
      var a, b, i, _ref;
      _ref = [[], []], a = _ref[0], b = _ref[1];
      for (i = 0; i < 100; i++) {
        a.push(i.toString());
        b.push(_.uniqueId());
      }
      return expect(a).toEqual(b);
    });
    return it("with prefix", function() {
      return expect(_.uniqueId("guten")).toEqual("guten100");
    });
  });
  describe(".try", function() {
    it("return null if object is null", function() {
      return expect(_["try"](null, "length")).toBeNull();
    });
    it("calls a method with arguments", function() {
      return expect(_["try"]([1, 2], "slice", 1)).toEqual([2]);
    });
    return it("return null if no method", function() {
      return expect(_["try"]({}, "foo_method")).toBeNull();
    });
  });
  describe(".escape", function() {
    return it("return safe HTML characters", function() {
      var chars, k, v, _results;
      chars = {
        ": \"&quot;\"": "&#x27;",
        "/": "&#x2F;",
        ">": "&gt;",
        "<": "&lt;"
      };
      _results = [];
      for (k in chars) {
        v = chars[k];
        _results.push(expect(_.escape(k)).toEqual(v));
      }
      return _results;
    });
  });
  return describe(".isEqual", function() {
    it("Number", function() {
      expect(_.isEqual(1, 1)).toTruthy;
      return expect(_.isEqual(1, 2)).toFalsy;
    });
    it("String", function() {
      expect(_.isEqual("1", "1")).toTruthy;
      return expect(_.isEqual("1", "2")).toFalsy;
    });
    it("Object", function() {
      expect(_.isEqual({
        a: 1
      }, {
        a: 1
      })).toTruthy;
      return expect(_.isEqual({
        a: 1
      }, {
        a: 2
      })).toFalsy;
    });
    return it("Array", function() {
      expect(_.isEqual([1], [1])).toTruthy;
      return expect(_.isEqual([1], [2])).toFalsy;
    });
  });
});

describe("Object", function() {
  describe("#reopen", function() {
    return it("works", function() {
      var a;
      a = [1];
      _(a).reopen({
        a: 1
      });
      return expect(a.a).toEqual(1);
    });
  });
  describe("(R) prorotype", function() {
    return it("is Wrapper.property", function() {
      _.prototype.a = 1;
      return expect(_("x").a).toEqual(1);
    });
  });
  describe("#instanceOf", function() {
    it("Boolean", function() {
      expect(_(true).instanceOf(Boolean)).toBeTruthy();
      return expect(_(false).instanceOf(Boolean)).toBeTruthy();
    });
    it("Number", function() {
      expect(_(1).instanceOf(Number)).toBeTruthy();
      return expect(_(1.0).instanceOf(Number)).toBeTruthy();
    });
    it("String", function() {
      return expect(_("x").instanceOf(String)).toBeTruthy();
    });
    it("Array", function() {
      return expect(_([]).instanceOf(Array)).toBeTruthy();
    });
    it("Object", function() {
      return expect(_({}).instanceOf(Object)).toBeTruthy();
    });
    it("Function", function() {
      return expect(_(function() {}).instanceOf(Function)).toBeTruthy();
    });
    it("Date", function() {
      return expect(_(new Date()).instanceOf(Date)).toBeTruthy();
    });
    it("RegExp", function() {
      return expect(_(/(?:)/).instanceOf(RegExp)).toBeTruthy();
    });
    it("Arguments", function() {
      var getArguments;
      getArguments = function() {
        return arguments;
      };
      return expect(_(getArguments()).instanceOf("Arguments")).toBeTruthy();
    });
    return it("coffescript Class", function() {
      var Guten;
      Guten = (function() {

        function Guten() {}

        return Guten;

      })();
      return expect(_(new Guten).instanceOf(Guten)).toBeTruthy();
    });
  });
  describe("#constructorName", function() {
    it("Boolean", function() {
      expect(_(true).constructorName()).toEqual("Boolean");
      return expect(_(false).constructorName()).toEqual("Boolean");
    });
    it("Number", function() {
      expect(_(1).constructorName()).toEqual("Number");
      return expect(_(1.0).constructorName()).toEqual("Number");
    });
    it("String", function() {
      return expect(_("x").constructorName()).toEqual("String");
    });
    it("Array", function() {
      return expect(_([]).constructorName()).toEqual("Array");
    });
    it("Object", function() {
      return expect(_({}).constructorName()).toEqual("Object");
    });
    it("Function", function() {
      return expect(_(function() {}).constructorName()).toEqual("Function");
    });
    it("Date", function() {
      return expect(_(new Date).constructorName()).toEqual("Date");
    });
    it("RegExp", function() {
      return expect(_(/(?:)/).constructorName()).toEqual("RegExp");
    });
    it("Arguments", function() {
      var getArguments;
      getArguments = function() {
        return arguments;
      };
      return expect(_(getArguments()).constructorName()).toEqual("Arguments");
    });
    return it("coffescript Class", function() {
      var Guten;
      Guten = (function() {

        function Guten() {}

        return Guten;

      })();
      return expect(_(new Guten).constructorName()).toEqual("Guten");
    });
  });
  describe("#isNaN", function() {
    return it("works", function() {
      expect(_(NaN).isNaN()).toBeTruthy;
      return expect(_("x").isNaN()).toBeFalsy;
    });
  });
  describe("#tap", function() {
    return it("works", function() {
      var a, b, c;
      a = {
        a: 1
      };
      b = [];
      c = [1];
      _(a).tap(function(self) {
        return b.push(self.a);
      });
      expect(a).toBe(a);
      return expect(b).toEqual([1]);
    });
  });
  describe("#clone", function() {
    return it("return a shallow clone", function() {
      var a;
      a = {
        a: 1
      };
      return expect(_(a).clone()).toEqual({
        a: 1
      });
    });
  });
  describe("#methods", function() {
    return it("return all methods of the object", function() {
      var Guten, a;
      Guten = (function() {

        function Guten() {}

        Guten.prototype.a = function() {};

        Guten.prototype.b = 2;

        return Guten;

      })();
      a = new Guten;
      return expect(_(a).methods()).toEqual(["a"]);
    });
  });
  return describe(".under_alias", function() {
    return it("works", function() {
      Object.prototype.test_foo = 1;
      Object.prototype.test_bar = function() {};
      _.under_alias(Object, "test_foo", "test_bar");
      Object.prototype._test_foo.should === Object.prototype.test_foo;
      return Object.prototype._test_bar.should === Object.prototype.test_bar;
    });
  });
});

describe("Enumerable", function() {
  var _a, _b;
  _a = [1, 2];
  _b = H({
    a: 1,
    b: 2
  });
  describe("#_any", function() {
    it("any one is true => true", function() {
      var ret;
      ret = _a._any(function(v) {
        return v === 1;
      });
      return expect(ret).toBeTruthy();
    });
    return it("all false => false", function() {
      var ret;
      ret = _a._any(function(v) {
        return v === -1;
      });
      return expect(ret).toBeFalsy();
    });
  });
  describe("#_all", function() {
    it("all true => true", function() {
      var ret;
      ret = _a._all(function(v) {
        return v === 1 || v === 2;
      });
      return expect(ret).toBeTruthy();
    });
    return it("one false => false", function() {
      var ret;
      ret = _a._all(function(v) {
        return v === 1;
      });
      return expect(ret).toBeFalsy();
    });
  });
  describe("#_none", function() {
    it("all false => true", function() {
      var ret;
      ret = _a._none(function(v) {
        return v === -1;
      });
      return expect(ret).toBeTruthy();
    });
    return it("one true => false", function() {
      var ret;
      ret = _a._none(function(v) {
        return v === 1;
      });
      return expect(ret).toBeFalsy();
    });
  });
  describe("#_one", function() {
    it("only one true => true", function() {
      var ret;
      ret = _a._one(function(v) {
        return v === 1;
      });
      return expect(ret).toBeTruthy();
    });
    it("more than two true => false", function() {
      var ret;
      ret = _a._one(function(v) {
        return v === 1 || v === 2;
      });
      return expect(ret).toBeFalsy();
    });
    return it("all false => false", function() {
      var ret;
      ret = _a._one(function(v) {
        return v === -1;
      });
      return expect(ret).toBeFalsy();
    });
  });
  describe("#_map", function() {
    return it("use native", function() {
      var a, b, ret;
      a = [1, 2];
      b = ["1", "2"];
      ret = a._map(function(v) {
        return v.toString();
      });
      return expect(ret).toEqual(b);
    });
  });
  describe("#_find", function() {
    it("find first value is true", function() {
      var ret;
      ret = _a._find(function(v) {
        return v === 1;
      });
      return expect(ret).toEqual(1);
    });
    it("retuns null if not found", function() {
      var ret;
      ret = _a._find(function(v) {
        return v === -1;
      });
      return expect(ret).toBeNull;
    });
    return it("works for Hash", function() {
      var ret;
      ret = _b._find(function(k, v) {
        return v === 1;
      });
      return expect(ret).toEqual(["a", 1]);
    });
  });
  describe("#_findAll", function() {
    it("return all fined values", function() {
      var a, b, ret;
      a = [1, 2, 1, 3, 4];
      b = [1, 1, 3];
      ret = a._findAll(function(v) {
        return v === 1 || v === 3;
      });
      return expect(ret).toEqual(b);
    });
    return it("works for Hash", function() {
      var a, b, ret;
      a = H({
        a: 1,
        b: 2,
        c: 1,
        d: 3,
        e: 4
      });
      b = [["a", 1], ["c", 1], ["d", 3]];
      ret = a._findAll(function(k, v) {
        return v === 1 || v === 3;
      });
      return expect(ret).toEqual(b);
    });
  });
  describe("#_reject", function() {
    it("return all expect rejected values", function() {
      var a, b, ret;
      a = [1, 2, 1, 3, 4];
      b = [2, 4];
      ret = a._reject(function(v) {
        return v === 1 || v === 3;
      });
      return expect(ret).toEqual(b);
    });
    return it("works for Hash", function() {
      var a, b, ret;
      a = H({
        a: 1,
        b: 2,
        c: 1,
        d: 3,
        e: 4
      });
      b = [["b", 2], ["e", 4]];
      ret = a._reject(function(k, v) {
        return v === 1 || v === 3;
      });
      return expect(ret).toEqual(b);
    });
  });
  describe("#_inject", function() {
    it("with initial value", function() {
      var a, b, ret;
      a = [1, 2, 3];
      b = 6;
      ret = a._inject(0, function(memo, v) {
        return memo + v;
      });
      return expect(ret).toEqual(b);
    });
    return it("without initial value", function() {
      var a, b, ret;
      a = [1, 2, 3];
      b = 6;
      ret = a._inject(function(memo, v) {
        return memo + v;
      });
      return expect(ret).toEqual(b);
    });
  });
  describe("#_sum", function() {
    it("works", function() {
      return [1, 2, 3]._sum.should === 6;
    });
    it("with initial value", function() {
      return [1, 2, 3]._sum(1).should === 7;
    });
    it("with callback", function() {
      return [1, 2, 3]._sum(function(v) {
        return 1;
      }).should === 3;
    });
    return it("with initial value and callback", function() {
      return [1, 2, 3]._sum(1, function(v) {
        return 1;
      }).should === 4;
    });
  });
  describe("#_max", function() {
    return it("call without argument", function() {
      return expect(_a._max()).toEqual(2);
    });
  });
  describe("#_min", function() {
    return it("call without arguments", function() {
      return expect(_a._min()).toEqual(1);
    });
  });
  describe("#_shuffle", function() {
    return it("works", function() {
      var i, numbers;
      numbers = (function() {
        var _results;
        _results = [];
        for (i = 0; i < 100; i++) {
          _results.push(i);
        }
        return _results;
      })();
      return expect(numbers._shuffle()).not.toEqual(numbers);
    });
  });
  describe("#_sortBy", function() {
    return it("works", function() {
      var a, b, ret;
      a = [[1, 9], [2, 8]];
      b = [[2, 8], [1, 9]];
      ret = a._sortBy(function(v, i) {
        return v[1];
      });
      return expect(ret).toEqual(b);
    });
  });
  describe("#_groupBy", function() {
    it("works", function() {
      var a, b, ret;
      a = [1, 2, 3, 4];
      b = H({
        a: [1, 3],
        b: [2, 4]
      });
      ret = a._groupBy(function(v) {
        if (v === 1 || v === 3) {
          return "a";
        } else {
          return "b";
        }
      });
      return expect(ret).toEqual(b);
    });
    return it("with Hash", function() {
      var a, b, ret;
      a = H({
        a: 1,
        b: 2,
        c: 3,
        d: 4
      });
      b = H({
        a: [["a", 1], ["c", 3]],
        b: [["b", 2], ["d", 4]]
      });
      ret = a._groupBy(function(k, v) {
        if (v === 1 || v === 3) {
          return "a";
        } else {
          return "b";
        }
      });
      return expect(ret).toEqual(b);
    });
  });
  describe("#_eachSlice", function() {
    return it("works", function() {
      var a, b;
      a = [];
      b = [[1, 2], [3]];
      [1, 2, 3]._eachSlice(2, function(data) {
        return a.push(data);
      });
      return expect(a).toEqual(b);
    });
  });
  return describe("#_eachCons", function() {
    it("works", function() {
      var a, b;
      a = [];
      b = [[1, 2], [2, 3]];
      [1, 2, 3]._eachCons(2, function(data) {
        return a.push(data);
      });
      return expect(a).toEqual(b);
    });
    it("n=0", function() {
      var a;
      a = [];
      [1, 2, 3]._eachCons(0, function(data) {
        return a.push(data);
      });
      return expect(a).toEqual(a);
    });
    return it("n > data.length", function() {
      var a;
      a = [];
      [1, 2, 3]._eachCons(10, function(data) {
        return a.push(data);
      });
      return expect(a).toEqual(a);
    });
  });
});

describe('Enumerator', function() {
  return describe('#_with_object', function() {
    return it('Array', function() {
      var a, b, ret;
      a = new Enumerator([1, 2]);
      b = [[1, 0], [2, 1]];
      ret = a._with_object([], function(memo, v, i) {
        return memo.push([v, i]);
      });
      return expect(ret).toEqual(b);
    });
  });
});

describe('Hash', function() {
  var _a;
  _a = H({
    a: 1,
    b: 2,
    c: 3
  });
  describe('#_each', function() {
    it('works', function() {
      var a, b;
      a = H({
        a: 1,
        b: 2
      });
      b = {};
      a._each(function(k, v) {
        return b[k] = v;
      });
      return expect(b).toEqual(a.data);
    });
    return it('break if throw a BREAKER', function() {
      var a, b, c;
      a = H({
        a: 1,
        b: 2,
        c: 3
      });
      b = {};
      c = {
        a: 1
      };
      a._each(function(k, v) {
        if (v === 2) throw BREAKER;
        return b[k] = v;
      });
      return expect(b).toEqual(c);
    });
  });
  describe('#_keys', function() {
    return it('works', function() {
      var a, b;
      Hash.prototype.b = 1;
      a = H({
        a: 1
      });
      b = ['a'];
      return expect(a._keys()).toEqual(b);
    });
  });
  describe('#_values', function() {
    return it('works', function() {
      var a, b;
      Hash.prototype.b = 2;
      a = H({
        a: 1
      });
      b = [1];
      return expect(a._values()).toEqual(b);
    });
  });
  describe('#_hasKey', function() {
    return it('works', function() {
      var a;
      a = H({
        a: 1
      });
      expect(a._hasKey('a')).toBeTruthy;
      return expect(a._hasKey('b')).toBeFalsy;
    });
  });
  describe('#_hasValue', function() {
    return it('works', function() {
      var a;
      a = H({
        a: 1
      });
      expect(a._hasValue(1)).toBeTruthy;
      return expect(a._hasValue(2)).toBeFalsy;
    });
  });
  describe('#_toHash', function() {
    return it('returns itself', function() {
      var h;
      h = H();
      return expect(h._toHash()).toBe(h);
    });
  });
  describe('#_fetch', function() {
    it('return the value', function() {
      return expect(_a._fetch('a')).toEqual(1);
    });
    it("returns null if don't have the key", function() {
      return expect(_a._fetch('z')).toEqual(null);
    });
    return it('default value', function() {
      expect(_a._fetch('z', 2)).toEqual(2);
      expect(_a._fetch('z')).toEqual(null);
      return expect(_a._fetch('a', 2)).toEqual(1);
    });
  });
  describe('#store', function() {
    var _x;
    _x = null;
    beforeEach(function() {
      return _x = H();
    });
    return it('k and v', function() {
      _x._store('a', 1);
      return expect(_x._fetch('a')).toEqual(1);
    });
  });
  describe('#_fetch_or_store', function() {
    var _x;
    _x = null;
    beforeEach(function() {
      return _x = H({
        a: 1
      });
    });
    it('fetch the existing value', function() {
      return expect(_x._fetch_or_store('a', 2)).toEqual(1);
    });
    return it('store the missing value', function() {
      expect(_x._fetch_or_store('b', 2)).toEqual(2);
      return expect(_x._fetch('b')).toEqual(2);
    });
  });
  return describe('#toString', function() {
    return it('works', function() {
      var a;
      a = {
        a: 1
      };
      return expect(H(a).toString()).toEqual(a.toString());
    });
  });
});

describe('Math', function() {
  return describe('._mod', function() {
    return it('works', function() {
      return expect(Math._mod(3, 2)).toEqual(1);
    });
  });
});

describe("Number", function() {
  describe("._max", function() {
    return it("get the largest value", function() {
      expect(Number._max(1, 2)).toEqual(2);
      return expect(Number._max(2, 1)).toEqual(2);
    });
  });
  describe("._min", function() {
    return it("get the minium value", function() {
      expect(Number._min(1, 2)).toEqual(1);
      return expect(Number._min(2, 1)).toEqual(1);
    });
  });
  describe("#_times", function() {
    it("works", function() {
      var a, b;
      a = [];
      b = [0, 1, 2];
      3.._times(function(i) {
        return a.push(i);
      });
      return expect(a).toEqual(b);
    });
    return it("starts with 1", function() {
      var a, b;
      a = [];
      b = [1, 2, 3];
      3.._times(1, function(i) {
        return a.push(i);
      });
      return expect(a).toEqual(b);
    });
  });
  describe("#_div", function() {
    return it("returns the largest integer less than or equal to a number", function() {
      return 1.._div(2).should === 0;
    });
  });
  describe("#_fdiv", function() {
    return it("do float division", function() {
      return 1.._fdiv(2).should === 0.5;
    });
  });
  return describe("#_toInteger", function() {
    return it("returns the largest integer less than or equal to a number", function() {
      return 0.5._toInteger().should === 0;
    });
  });
});

describe('String', function() {
  describe('#_toInteger', function() {
    return it('convert a string to integer', function() {
      return expect('123'._toInteger()).toEqual(123);
    });
  });
  describe('#_pluralize', function() {
    return it('pluralize a word', function() {
      return expect('car'._pluralize()).toEqual('cars');
    });
  });
  describe('#_capitalize', function() {
    return it('capitalize a word', function() {
      return expect('car'._capitalize()).toEqual('Car');
    });
  });
  describe('#_endsWith', function() {
    return it("check a string's end", function() {
      expect('car'._endsWith('r')).toBeTruthy();
      return expect('car'._endsWith('ar')).toBeTruthy();
    });
  });
  describe('#_reverse', function() {
    return it('reverse a string', function() {
      return expect('car'._reverse()).toEqual('rac');
    });
  });
  return describe('#_isEmpty', function() {
    return it('works', function() {
      expect(''._isEmpty()).toBeTruthy();
      return expect('x'._isEmpty()).toBeFalsy();
    });
  });
});
