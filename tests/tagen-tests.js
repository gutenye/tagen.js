
describe('Array', function() {
  describe('#each', function() {
    it('works', function() {
      var a, b, ret;
      a = [1, 2];
      b = [[1, 0], [2, 1]];
      ret = [];
      a.each(function(v, i) {
        return ret.push([v, i]);
      });
      return expect(ret).toEqual(b);
    });
    it('return <#Enumerator> when called without any arguments', function() {
      var a, b;
      a = [1, 2];
      b = a.each();
      expect(b.constructor).toEqual(Enumerator);
      return expect(b.data).toEqual(a);
    });
    return it('break if throw BREAKER', function() {
      var a, b, c;
      a = [1, 2, 3];
      b = [];
      c = [1];
      a.each(function(v) {
        if (v === 2) throw BREAKER;
        return b.push(v);
      });
      return expect(b).toEqual(c);
    });
  });
  describe('#isEqual', function() {
    it('works', function() {
      expect([1, 2].isEqual([1, 2])).toBeTruthy();
      return expect([1, 2].isEqual([1, 3])).toBeFalsy();
    });
    return it('with nested array', function() {
      return expect([1, [2]].isEqual([1, [2]])).toBeTruthy();
    });
  });
  describe('#isInclude', function() {
    it('works', function() {
      expect([1, 2].isInclude(2)).toBeTruthy();
      return expect([1, 2].isInclude(9)).toBeFalsy();
    });
    return it('alias as contains', function() {
      return expect([].contains).toBe([].isInclude);
    });
  });
  describe('#isEmpty', function() {
    return it('works', function() {
      expect([].isEmpty()).toBeTruthy();
      return expect([1].isEmpty()).toBeFalsy();
    });
  });
  describe('#clone', function() {
    return it('return a shadow-clone', function() {
      var a, b;
      b = [1];
      a = b.clone();
      expect(a).toEqual(b);
      return expect(a).not.toBe(b);
    });
  });
  describe('#random', function() {
    return it('works', function() {
      var counts, data, i, k;
      data = [0, 1];
      counts = {};
      for (i = 0; i <= 9; i++) {
        k = data.random();
        if (counts[k] == null) counts[k] = 0;
        counts[k] += 1;
      }
      expect(counts[0] + counts[1]).toEqual(10);
      return expect(counts[0]).not.toEqual(10);
    });
  });
  describe('#zip', function() {
    return it('works', function() {
      var a, b;
      a = [1, 2].zip([3, 4]);
      b = [[1, 3], [2, 4]];
      return expect(a).toEqual(b);
    });
  });
  describe('#first', function() {
    return it('return the first element of the array', function() {
      return expect([1, 2].first()).toEqual(1);
    });
  });
  describe('#last', function() {
    return it('return the last element of the array', function() {
      return expect([1, 2].last()).toEqual(2);
    });
  });
  describe('#compact', function() {
    return it('remove all null values', function() {
      var a, b;
      a = [1, true, null, false, []];
      b = [1, true, false, []];
      return expect(a.compact()).toEqual(b);
    });
  });
  describe('#flatten', function() {
    it('flatten one-level', function() {
      var a, b;
      a = [1, [2]];
      b = [1, 2];
      return expect(a.flatten()).toEqual(b);
    });
    return it('flatten multi-levels', function() {
      var a, b, c;
      a = [1, [2, [3]]];
      b = [1, 2, 3];
      c = [1, 2, [3]];
      expect(a.flatten()).toEqual(b);
      return expect(a.flatten(true)).toEqual(c);
    });
  });
  describe('#uniq', function() {
    return it('removes duplicate-values', function() {
      var a, b;
      a = [1, 3, 2, 1, 3];
      b = [1, 3, 2];
      return expect(a.uniq()).toEqual(b);
    });
  });
  describe('#without', function() {
    return it('Take the difference between one array and another.', function() {
      var a, b, c;
      a = [1, 2, 3, 4];
      b = [2, 4];
      c = [1, 3];
      return expect(a.without.apply(a, b)).toEqual(c);
    });
  });
  describe('#pluck', function() {
    return it('works', function() {
      var a, b;
      a = [
        {
          a: 1
        }, {
          a: 2
        }
      ];
      b = [1, 2];
      return expect(a.pluck('a')).toEqual(b);
    });
  });
  describe('#findIndex', function() {
    it('find with a value', function() {
      var a, b;
      a = [1, 2, 3];
      b = 1;
      return expect(a.findIndex(2)).toEqual(b);
    });
    return it('find with an iterator', function() {
      var a, b, ret;
      a = [1, 2, 3];
      b = 1;
      ret = a.findIndex(function(v) {
        return v === 2;
      });
      return expect(ret).toEqual(b);
    });
  });
  return describe('#invoke', function() {
    return it('call each method', function() {
      var a, b;
      a = [1, 2];
      b = ['1', '2'];
      return expect(a.invoke('toString')).toEqual(b);
    });
  });
});

describe('_', function() {
  describe('.reopen', function() {
    it('a Class', function() {
      _.reopen(Array, {
        happy: 1
      });
      return expect(Array.prototype.happy).toEqual(1);
    });
    it('overwrite=false', function() {
      Array.prototype.a = 1;
      _.reopen(Array, {
        a: 2
      });
      return expect(Array.prototype.a).toEqual(1);
    });
    it('overwrite=true', function() {
      Array.prototype.a = 1;
      _.reopen(Array, {
        a: 2
      }, true);
      return expect(Array.prototype.a).toEqual(2);
    });
    it('a Guten', function() {
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
    return it('alias mixin', function() {
      return expect(_.mixin).toBe(_.reopen);
    });
  });
  describe('.reopenClass', function() {
    return it('a Class', function() {
      _.reopenClass(Object, {
        c: 1
      });
      return expect(Object.c).toEqual(1);
    });
  });
  describe('.uniqueId', function() {
    it('can generate a globally-unique stream', function() {
      var a, b, i, _ref;
      _ref = [[], []], a = _ref[0], b = _ref[1];
      for (i = 0; i < 100; i++) {
        a.push(i.toString());
        b.push(_.uniqueId());
      }
      return expect(a).toEqual(b);
    });
    return it('with prefix', function() {
      return expect(_.uniqueId('guten')).toEqual('guten100');
    });
  });
  describe('.try', function() {
    it('return null if object is null', function() {
      return expect(_["try"](null, 'length')).toBeNull();
    });
    it('calls a method with arguments', function() {
      return expect(_["try"]([1, 2], 'slice', 1)).toEqual([2]);
    });
    return it('return null if no method', function() {
      return expect(_["try"]({}, 'foo_method')).toBeNull();
    });
  });
  describe('.escape', function() {
    return it('return safe HTML characters', function() {
      var chars, k, v, _results;
      chars = {
        '"': '&quot;',
        "'": '&#x27;',
        '/': '&#x2F;',
        '>': '&gt;',
        '<': '&lt;'
      };
      _results = [];
      for (k in chars) {
        v = chars[k];
        _results.push(expect(_.escape(k)).toEqual(v));
      }
      return _results;
    });
  });
  return describe('.isEqual', function() {
    it('Number', function() {
      expect(_.isEqual(1, 1)).toTruthy;
      return expect(_.isEqual(1, 2)).toFalsy;
    });
    it('String', function() {
      expect(_.isEqual('1', '1')).toTruthy;
      return expect(_.isEqual('1', '2')).toFalsy;
    });
    it('Object', function() {
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
    return it('Array', function() {
      expect(_.isEqual([1], [1])).toTruthy;
      return expect(_.isEqual([1], [2])).toFalsy;
    });
  });
});

describe('Object', function() {
  describe('#reopen', function() {
    return it('works', function() {
      var a;
      a = [1];
      _(a).reopen({
        a: 1
      });
      return expect(a.a).toEqual(1);
    });
  });
  describe('(R) prorotype', function() {
    return it('is Wrapper.property', function() {
      _.prototype.a = 1;
      return expect(_('x').a).toEqual(1);
    });
  });
  describe('#instanceOf', function() {
    it('Boolean', function() {
      expect(_(true).instanceOf(Boolean)).toBeTruthy();
      return expect(_(false).instanceOf(Boolean)).toBeTruthy();
    });
    it('Number', function() {
      expect(_(1).instanceOf(Number)).toBeTruthy();
      return expect(_(1.0).instanceOf(Number)).toBeTruthy();
    });
    it('String', function() {
      return expect(_('x').instanceOf(String)).toBeTruthy();
    });
    it('Array', function() {
      return expect(_([]).instanceOf(Array)).toBeTruthy();
    });
    it('Object', function() {
      return expect(_({}).instanceOf(Object)).toBeTruthy();
    });
    it('Function', function() {
      return expect(_(function() {}).instanceOf(Function)).toBeTruthy();
    });
    it('Date', function() {
      return expect(_(new Date()).instanceOf(Date)).toBeTruthy();
    });
    it('RegExp', function() {
      return expect(_(/(?:)/).instanceOf(RegExp)).toBeTruthy();
    });
    it('Arguments', function() {
      var getArguments;
      getArguments = function() {
        return arguments;
      };
      return expect(_(getArguments()).instanceOf('Arguments')).toBeTruthy();
    });
    return it('coffescript Class', function() {
      var Guten;
      Guten = (function() {

        function Guten() {}

        return Guten;

      })();
      return expect(_(new Guten).instanceOf(Guten)).toBeTruthy();
    });
  });
  describe('#constructorName', function() {
    it('Boolean', function() {
      expect(_(true).constructorName()).toEqual('Boolean');
      return expect(_(false).constructorName()).toEqual('Boolean');
    });
    it('Number', function() {
      expect(_(1).constructorName()).toEqual('Number');
      return expect(_(1.0).constructorName()).toEqual('Number');
    });
    it('String', function() {
      return expect(_('x').constructorName()).toEqual('String');
    });
    it('Array', function() {
      return expect(_([]).constructorName()).toEqual('Array');
    });
    it('Object', function() {
      return expect(_({}).constructorName()).toEqual('Object');
    });
    it('Function', function() {
      return expect(_(function() {}).constructorName()).toEqual('Function');
    });
    it('Date', function() {
      return expect(_(new Date).constructorName()).toEqual('Date');
    });
    it('RegExp', function() {
      return expect(_(/(?:)/).constructorName()).toEqual('RegExp');
    });
    it('Arguments', function() {
      var getArguments;
      getArguments = function() {
        return arguments;
      };
      return expect(_(getArguments()).constructorName()).toEqual('Arguments');
    });
    return it('coffescript Class', function() {
      var Guten;
      Guten = (function() {

        function Guten() {}

        return Guten;

      })();
      return expect(_(new Guten).constructorName()).toEqual('Guten');
    });
  });
  describe('#isNaN', function() {
    return it('works', function() {
      expect(_(NaN).isNaN()).toBeTruthy;
      return expect(_('x').isNaN()).toBeFalsy;
    });
  });
  describe('#tap', function() {
    return it('works', function() {
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
  describe('#clone', function() {
    return it('return a shallow clone', function() {
      var a;
      a = {
        a: 1
      };
      return expect(_(a).clone()).toEqual({
        a: 1
      });
    });
  });
  return describe('#methods', function() {
    return it('return all methods of the object', function() {
      var Guten, a;
      Guten = (function() {

        function Guten() {}

        Guten.prototype.a = function() {};

        Guten.prototype.b = 2;

        return Guten;

      })();
      a = new Guten;
      return expect(_(a).methods()).toEqual(['a']);
    });
  });
});

describe('Enumerable', function() {
  var _a, _b;
  _a = [1, 2];
  _b = H({
    a: 1,
    b: 2
  });
  describe('#any', function() {
    it('any one is true => true', function() {
      var ret;
      ret = _a.any(function(v) {
        return v === 1;
      });
      return expect(ret).toBeTruthy();
    });
    return it('all false => false', function() {
      var ret;
      ret = _a.any(function(v) {
        return v === -1;
      });
      return expect(ret).toBeFalsy();
    });
  });
  describe('#all', function() {
    it('all true => true', function() {
      var ret;
      ret = _a.all(function(v) {
        return v === 1 || v === 2;
      });
      return expect(ret).toBeTruthy();
    });
    return it('one false => false', function() {
      var ret;
      ret = _a.all(function(v) {
        return v === 1;
      });
      return expect(ret).toBeFalsy();
    });
  });
  describe('#none', function() {
    it('all false => true', function() {
      var ret;
      ret = _a.none(function(v) {
        return v === -1;
      });
      return expect(ret).toBeTruthy();
    });
    return it('one true => false', function() {
      var ret;
      ret = _a.none(function(v) {
        return v === 1;
      });
      return expect(ret).toBeFalsy();
    });
  });
  describe('#one', function() {
    it('only one true => true', function() {
      var ret;
      ret = _a.one(function(v) {
        return v === 1;
      });
      return expect(ret).toBeTruthy();
    });
    it('more than two true => false', function() {
      var ret;
      ret = _a.one(function(v) {
        return v === 1 || v === 2;
      });
      return expect(ret).toBeFalsy();
    });
    return it('all false => false', function() {
      var ret;
      ret = _a.one(function(v) {
        return v === -1;
      });
      return expect(ret).toBeFalsy();
    });
  });
  describe('#map', function() {
    return it('use native', function() {
      var a, b, ret;
      a = [1, 2];
      b = ['1', '2'];
      ret = a.map(function(v) {
        return v.toString();
      });
      return expect(ret).toEqual(b);
    });
  });
  describe('#find', function() {
    it('find first value is true', function() {
      var ret;
      ret = _a.find(function(v) {
        return v === 1;
      });
      return expect(ret).toEqual(1);
    });
    it('retuns null if not found', function() {
      var ret;
      ret = _a.find(function(v) {
        return v === -1;
      });
      return expect(ret).toBeNull;
    });
    return it('works for Hash', function() {
      var ret;
      ret = _b.find(function(k, v) {
        return v === 1;
      });
      return expect(ret).toEqual(['a', 1]);
    });
  });
  describe('#findAll', function() {
    it('return all fined values', function() {
      var a, b, ret;
      a = [1, 2, 1, 3, 4];
      b = [1, 1, 3];
      ret = a.findAll(function(v) {
        return v === 1 || v === 3;
      });
      return expect(ret).toEqual(b);
    });
    return it('works for Hash', function() {
      var a, b, ret;
      a = H({
        a: 1,
        b: 2,
        c: 1,
        d: 3,
        e: 4
      });
      b = [['a', 1], ['c', 1], ['d', 3]];
      ret = a.findAll(function(k, v) {
        return v === 1 || v === 3;
      });
      return expect(ret).toEqual(b);
    });
  });
  describe('#reject', function() {
    it('return all expect rejected values', function() {
      var a, b, ret;
      a = [1, 2, 1, 3, 4];
      b = [2, 4];
      ret = a.reject(function(v) {
        return v === 1 || v === 3;
      });
      return expect(ret).toEqual(b);
    });
    return it('works for Hash', function() {
      var a, b, ret;
      a = H({
        a: 1,
        b: 2,
        c: 1,
        d: 3,
        e: 4
      });
      b = [['b', 2], ['e', 4]];
      ret = a.reject(function(k, v) {
        return v === 1 || v === 3;
      });
      return expect(ret).toEqual(b);
    });
  });
  describe('#inject', function() {
    it('with initial value', function() {
      var a, b, ret;
      a = [1, 2, 3];
      b = 6;
      ret = a.inject(0, function(memo, v) {
        return memo + v;
      });
      return expect(ret).toEqual(b);
    });
    return it('without initial value', function() {
      var a, b, ret;
      a = [1, 2, 3];
      b = 6;
      ret = a.inject(function(memo, v) {
        return memo + v;
      });
      return expect(ret).toEqual(b);
    });
  });
  describe('#max', function() {
    return it('call without argument', function() {
      return expect(_a.max()).toEqual(2);
    });
  });
  describe('#min', function() {
    return it('call without arguments', function() {
      return expect(_a.min()).toEqual(1);
    });
  });
  describe('#shuffle', function() {
    return it('works', function() {
      var i, numbers;
      numbers = (function() {
        var _results;
        _results = [];
        for (i = 0; i < 100; i++) {
          _results.push(i);
        }
        return _results;
      })();
      return expect(numbers.shuffle()).not.toEqual(numbers);
    });
  });
  describe('#sortBy', function() {
    return it('works', function() {
      var a, b, ret;
      a = [[1, 9], [2, 8]];
      b = [[2, 8], [1, 9]];
      ret = a.sortBy(function(v, i) {
        return v[1];
      });
      return expect(ret).toEqual(b);
    });
  });
  return describe('#groupBy', function() {
    it('works', function() {
      var a, b, ret;
      a = [1, 2, 3, 4];
      b = H({
        a: [1, 3],
        b: [2, 4]
      });
      ret = a.groupBy(function(v) {
        if (v === 1 || v === 3) {
          return 'a';
        } else {
          return 'b';
        }
      });
      return expect(ret).toEqual(b);
    });
    return it('with Hash', function() {
      var a, b, ret;
      a = H({
        a: 1,
        b: 2,
        c: 3,
        d: 4
      });
      b = H({
        a: [['a', 1], ['c', 3]],
        b: [['b', 2], ['d', 4]]
      });
      ret = a.groupBy(function(k, v) {
        if (v === 1 || v === 3) {
          return 'a';
        } else {
          return 'b';
        }
      });
      return expect(ret).toEqual(b);
    });
  });
});

describe('Enumerator', function() {
  return describe('#with_object', function() {
    return it('Array', function() {
      var a, b, ret;
      a = new Enumerator([1, 2]);
      b = [[1, 0], [2, 1]];
      ret = a.with_object([], function(memo, v, i) {
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
  describe('#each', function() {
    it('works', function() {
      var a, b;
      a = H({
        a: 1,
        b: 2
      });
      b = {};
      a.each(function(k, v) {
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
      a.each(function(k, v) {
        if (v === 2) throw BREAKER;
        return b[k] = v;
      });
      return expect(b).toEqual(c);
    });
  });
  describe('#keys', function() {
    return it('works', function() {
      var a, b;
      Hash.prototype.b = 1;
      a = H({
        a: 1
      });
      b = ['a'];
      return expect(a.keys()).toEqual(b);
    });
  });
  describe('#values', function() {
    return it('works', function() {
      var a, b;
      Hash.prototype.b = 2;
      a = H({
        a: 1
      });
      b = [1];
      return expect(a.values()).toEqual(b);
    });
  });
  describe('#hasKey', function() {
    return it('works', function() {
      var a;
      a = H({
        a: 1
      });
      expect(a.hasKey('a')).toBeTruthy;
      return expect(a.hasKey('b')).toBeFalsy;
    });
  });
  describe('#hasValue', function() {
    return it('works', function() {
      var a;
      a = H({
        a: 1
      });
      expect(a.hasValue(1)).toBeTruthy;
      return expect(a.hasValue(2)).toBeFalsy;
    });
  });
  describe('#toHash', function() {
    return it('returns itself', function() {
      var h;
      h = H();
      return expect(h.toHash()).toBe(h);
    });
  });
  describe('#fetch', function() {
    it('return the value', function() {
      return expect(_a.fetch('a')).toEqual(1);
    });
    it("returns null if don't have the key", function() {
      return expect(_a.fetch('z')).toEqual(null);
    });
    return it('default value', function() {
      expect(_a.fetch('z', 2)).toEqual(2);
      expect(_a.fetch('z')).toEqual(null);
      return expect(_a.fetch('a', 2)).toEqual(1);
    });
  });
  describe('#store', function() {
    var _x;
    _x = null;
    beforeEach(function() {
      return _x = H();
    });
    return it('k and v', function() {
      _x.store('a', 1);
      return expect(_x.fetch('a')).toEqual(1);
    });
  });
  describe('#fetch_or_store', function() {
    var _x;
    _x = null;
    beforeEach(function() {
      return _x = H({
        a: 1
      });
    });
    it('fetch the existing value', function() {
      return expect(_x.fetch_or_store('a', 2)).toEqual(1);
    });
    return it('store the missing value', function() {
      expect(_x.fetch_or_store('b', 2)).toEqual(2);
      return expect(_x.fetch('b')).toEqual(2);
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
  return describe('.mod', function() {
    return it('works', function() {
      return expect(Math.mod(3, 2)).toEqual(1);
    });
  });
});

describe('Number', function() {
  describe('.max', function() {
    return it('get the largest value', function() {
      expect(Number.max(1, 2)).toEqual(2);
      return expect(Number.max(2, 1)).toEqual(2);
    });
  });
  describe('.min', function() {
    return it('get the minium value', function() {
      expect(Number.min(1, 2)).toEqual(1);
      return expect(Number.min(2, 1)).toEqual(1);
    });
  });
  return describe('#times', function() {
    return it('works', function() {
      var a, b;
      a = [];
      b = [0, 1, 2];
      3..times(function(i) {
        return a.push(i);
      });
      return expect(a).toEqual(b);
    });
  });
});

describe('String', function() {
  describe('#toInteger', function() {
    return it('convert a string to integer', function() {
      return expect('123'.toInteger()).toEqual(123);
    });
  });
  describe('#pluralize', function() {
    return it('pluralize a word', function() {
      return expect('car'.pluralize()).toEqual('cars');
    });
  });
  describe('#capitalize', function() {
    return it('capitalize a word', function() {
      return expect('car'.capitalize()).toEqual('Car');
    });
  });
  describe('#endsWith', function() {
    return it("check a string's end", function() {
      expect('car'.endsWith('r')).toBeTruthy();
      return expect('car'.endsWith('ar')).toBeTruthy();
    });
  });
  describe('#reverse', function() {
    return it('reverse a string', function() {
      return expect('car'.reverse()).toEqual('rac');
    });
  });
  return describe('#isEmpty', function() {
    return it('works', function() {
      expect(''.isEmpty()).toBeTruthy();
      return expect('x'.isEmpty()).toBeFalsy();
    });
  });
});
