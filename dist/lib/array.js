var __slice = Array.prototype.slice;

Array.toArray = function(iterable) {
  if (!iterable) return [];
  if (iterable.toArray) return iterable.toArray();
  if (_.isArray(iterable)) return slice.call(iterable);
  if (_.isArguments(iterable)) return slice.call(iterable);
  return _.values(iterable);
};

_.mixin(Array, Enumerable);

_.reopen(Array, {
  each: function(iterator) {
    var i, v, _len, _results;
    if (!iterator) return new Enumerator(this);
    try {
      _results = [];
      for (i = 0, _len = this.length; i < _len; i++) {
        v = this[i];
        _results.push(iterator(v, i, this));
      }
      return _results;
    } catch (err) {
      if (err !== BREAKER) throw err;
    }
  },
  isEqual: function(ary) {
    var i, v, _len;
    if (this.length !== ary.length) return false;
    for (i = 0, _len = this.length; i < _len; i++) {
      v = this[i];
      if (_(v).instanceOf(Array)) {
        return v.isEqual(ary[i]);
      } else {
        if (v !== ary[i]) return false;
      }
    }
    return true;
  },
  isInclude: function(obj) {
    return this.indexOf(obj) !== -1;
  },
  isEmpty: function() {
    return this.length === 0;
  },
  clone: function() {
    return this.slice();
  },
  random: function() {
    var i;
    i = Math.random() * this.length;
    return this[Math.floor(i)];
  },
  zip: function() {
    var args, i, length, ret;
    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    args = [this].concat(__slice.call(args));
    length = args.pluck('length').max();
    ret = new Array(length);
    for (i = 0; 0 <= length ? i < length : i > length; 0 <= length ? i++ : i--) {
      ret[i] = args.pluck("" + i);
    }
    return ret;
  },
  first: function(n) {
    if (n) {
      return this.slice(0, n);
    } else {
      return this[0];
    }
  },
  last: function(n) {
    if (n) {
      return this.slice(this.length - n);
    } else {
      return this[this.length - 1];
    }
  },
  compact: function() {
    return this.findAll(function(value) {
      return value !== null;
    });
  },
  flatten: function(shallow) {
    var ret;
    ret = [];
    this.each(function(v) {
      if (_(v).instanceOf(Array)) {
        v = shallow ? v : v.flatten();
        return ret = ret.concat(v);
      } else {
        return ret.push(v);
      }
    });
    return ret;
  },
  uniq: function(isSorted) {
    var ret;
    ret = [];
    this.each(function(v, i) {
      if (0 === i || (isSorted === true ? ret.last() !== v : !ret.isInclude(v))) {
        ret.push(v);
      }
      return ret;
    });
    return ret;
  },
  without: function() {
    var args;
    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return this.findAll(function(value) {
      return !args.isInclude(value);
    });
  },
  pluck: function(key) {
    return this.map(function(data) {
      return data[key];
    });
  },
  findIndex: function(obj) {
    var iterator, ret;
    switch (_(obj).constructorName()) {
      case 'Function':
        iterator = obj;
        break;
      default:
        iterator = function(v) {
          return v === obj;
        };
    }
    ret = -1;
    this.each(function(v, i, self) {
      if (iterator(v, i, self)) {
        ret = i;
        throw BREAKER;
      }
    });
    return ret;
  },
  invoke: function() {
    var args, methodName;
    methodName = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    return this.map(function(value) {
      var method;
      method = value[methodName];
      if (method) {
        return method.apply.apply(method, [value].concat(__slice.call(args)));
      } else {
        return null;
      }
    });
  },
  indexOf: Array.prototype.indexOf || function(item, isSorted) {
    var i, k, _len;
    if (this === null) return -1;
    if (isSorted) {
      i = _.sortedIndex(this, item);
      if (this[i] === item) {
        return i;
      } else {
        return -1;
      }
    }
    for (i = 0, _len = this.length; i < _len; i++) {
      k = this[i];
      if (k === item) return i;
    }
    return -1;
  },
  lastIndexOf: Array.prototype.lastIndexOf || function(item) {
    var i;
    if (this === null) return -1;
    i = this.length;
    while (i--) {
      if (this[i] === item) return i;
    }
    return -1;
  }
});

Array.prototype.contains = Array.prototype.isInclude;
