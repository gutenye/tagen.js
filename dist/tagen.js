(function() {
(function() {
var BREAKER, Wrapper, eq, exports, idCounter, root, _,
  __hasProp = Object.prototype.hasOwnProperty,
  __slice = Array.prototype.slice;

_ = function(obj) {
  return new Wrapper(obj);
};

_.VERSION = '0.0.1';

BREAKER = new Error('BREAKER');

root = this.root = this;

if (typeof exports !== "undefined" && exports !== null) {
  exports = _;
} else {
  root['_'] = _;
}

if (typeof global !== "undefined" && global !== null) {
  global['BREAKER'] = BREAKER;
} else {
  root['BREAKER'] = BREAKER;
}

_.reopenClass = function(klass, attrs, overwrite) {
  var k, v, _results;
  _results = [];
  for (k in attrs) {
    if (!__hasProp.call(attrs, k)) continue;
    v = attrs[k];
    if (!klass[k]) {
      _results.push(Object.defineProperty(klass, k, {
        value: v,
        writable: true
      }));
    } else {
      _results.push(void 0);
    }
  }
  return _results;
};

_.reopen = _.mixin = function(klass, attrs, overwrite) {
  var k, target, v, _results;
  target = klass.prototype;
  _results = [];
  for (k in attrs) {
    if (!__hasProp.call(attrs, k)) continue;
    v = attrs[k];
    if (target[k] && !overwrite) {} else {
      _results.push(target[k] = v);
    }
  }
  return _results;
};

_["try"] = function() {
  var args, method, obj, _ref;
  obj = arguments[0], method = arguments[1], args = 3 <= arguments.length ? __slice.call(arguments, 2) : [];
  if (obj === null) return null;
  if (obj[method]) {
    return (_ref = obj[method]).call.apply(_ref, [obj].concat(__slice.call(args)));
  }
  return null;
};

idCounter = 0;

_.uniqueId = function(prefix) {
  var id;
  id = idCounter++;
  if (prefix) {
    return "" + prefix + id;
  } else {
    return "" + id;
  }
};

_.escape = function(str) {
  str = str.toString();
  return str.replace(/&(?!\w+;|#\d+;|#x[\da-f]+;)/gi, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#x27;').replace(/\//g, '&#x2F;');
};

_.isEqual = function(a, b) {
  return eq(a, b, []);
};

eq = function(a, b, stack) {
  var isBooleanA, isBooleanB, isDateA, isDateB, isNumberA, isNumberB, isRegExpA, isRegExpB, isStringA, isStringB, key, length, result, size, typeA, _ref, _ref2, _ref3, _ref4, _ref5, _ref6;
  if (a === b) return a !== 0 || 1 / a === 1 / b;
  if ((a === null) || (b === null)) return a === b;
  if (a.isEqual && _(a.isEqual).instanceOf(Function)) return a.isEqual(b);
  if (b.isEqual && _(b.isEqual).instanceOf(Function)) return b.isEqual(a);
  typeA = typeof a;
  if (typeA !== typeof b) return false;
  if (!a !== !b) return false;
  if (_(a).isNaN()) return _(b).isNaN();
  _ref = [_(a).instanceOf(String), _(b).instanceOf(String)], isStringA = _ref[0], isStringB = _ref[1];
  if (isStringA || isStringB) {
    return isStringA && isStringB && String(a) === String(b);
  }
  _ref2 = [_(a).instanceOf(Number), _(b).instanceOf(Number)], isNumberA = _ref2[0], isNumberB = _ref2[1];
  if (isNumberA || isNumberB) return isNumberA && isNumberB && +a === +b;
  _ref3 = [_(a).instanceOf(Boolean), _(b).instanceOf(Boolean)], isBooleanA = _ref3[0], isBooleanB = _ref3[1];
  if (isBooleanA || isBooleanB) return isBooleanA && isBooleanB && +a === +b;
  _ref4 = [_(a).instanceOf(Date), _(b).instanceOf(Date)], isDateA = _ref4[0], isDateB = _ref4[1];
  if (isDateA || isDateB) return isDateA && isDateB && a.getTime() === b.getTime();
  _ref5 = [_(a).instanceOf(RegExp), _(b).instanceOf(RegExp)], isRegExpA = _ref5[0], isRegExpB = _ref5[1];
  if (isRegExpA || isRegExpB) {
    return isRegExpA && isRegExpB && a.source === b.source && a.global === b.global && a.multiline === b.multiline && a.ignoreCase === b.ignoreCase;
  }
  if (typeA !== 'object') return false;
  if (a.length !== b.length) return false;
  if (a.constructor !== b.constructor) return false;
  length = stack.length;
  while (length--) {
    if (stack[length] === a) return true;
  }
  stack.push(a);
  _ref6 = [0, true], size = _ref6[0], result = _ref6[1];
  for (key in a) {
    if (!__hasProp.call(a, key)) continue;
    size++;
    if (!(result = hasOwnProperty.call(b, key) && eq(a[key], b[key], stack))) {
      break;
    }
  }
  if (result) {
    for (key in b) {
      if (hasOwnProperty.call(b, key) && !size--) break;
    }
    result = !size;
  }
  stack.pop();
  return result;
};

Wrapper = (function() {

  function Wrapper(obj) {
    this.object = obj;
  }

  Wrapper.prototype.reopen = function(attrs) {
    var k, v, _results;
    _results = [];
    for (k in attrs) {
      if (!__hasProp.call(attrs, k)) continue;
      v = attrs[k];
      _results.push(this.object[k] = v);
    }
    return _results;
  };

  Wrapper.prototype.constructorName = function() {
    var results;
    if (Object.prototype.toString.call(this.object) === '[object Arguments]') {
      return 'Arguments';
    } else {
      results = this.object.constructor.toString().match(/function (.{1,})\(/);
      if (results && results.length > 1) {
        return results[1];
      } else {
        return '';
      }
    }
  };

  Wrapper.prototype.instanceOf = function(constructorClass) {
    if (constructorClass === 'Arguments' && Object.prototype.toString.call(this.object) === '[object Arguments]') {
      return true;
    } else {
      return this.object.constructor === constructorClass;
    }
  };

  Wrapper.prototype.isNaN = function() {
    return this.object !== this.object;
  };

  Wrapper.prototype.tap = function(interceptor) {
    interceptor(this.object);
    return this;
  };

  Wrapper.prototype.clone = function() {
    var prop, ret;
    ret = {};
    for (prop in this.object) {
      ret[prop] = this.object[prop];
    }
    return ret;
  };

  Wrapper.prototype.methods = function() {
    var k, names, v, _ref;
    names = [];
    _ref = this.object;
    for (k in _ref) {
      v = _ref[k];
      if (_(v).instanceOf(Function)) names.push(k);
    }
    return names.sort();
  };

  return Wrapper;

})();

_.prototype = Wrapper.prototype;

})();

(function() {
var Enumerable,
  __slice = Array.prototype.slice;

Enumerable = {
  _any: function(iterator) {
    var ret;
    ret = false;
    this.each(function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      if (ret |= iterator.apply(null, args)) return true;
    });
    return !!ret;
  },
  _all: function(iterator) {
    var ret;
    ret = true;
    this.each(function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      if (!iterator.apply(null, args)) {
        ret = false;
        throw BREAKER;
      }
    });
    return ret;
  },
  _none: function(iterator) {
    var ret;
    ret = true;
    this.each(function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      if (iterator.apply(null, args)) {
        ret = false;
        throw BREAKER;
      }
    });
    return ret;
  },
  _one: function(iterator) {
    var counts;
    counts = 0;
    this.each(function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      if (iterator.apply(null, args)) {
        counts += 1;
        if (counts === 2) throw BREAKER;
      }
    });
    if (counts === 1) {
      return true;
    } else {
      return false;
    }
  },
  _map: function(iterator) {
    var ret,
      _this = this;
    ret = [];
    this.each(function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return ret.push(iterator.apply(null, args));
    });
    return ret;
  },
  _find: function(iterator) {
    var ret,
      _this = this;
    ret = null;
    this.each(function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      if (iterator.apply(null, args)) {
        ret = _(_this).instanceOf(Hash) ? [args[0], args[1]] : args[0];
        throw BREAKER;
      }
    });
    return ret;
  },
  _findAll: function(iterator) {
    var ret,
      _this = this;
    ret = [];
    this.each(function() {
      var args, value;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      if (iterator.apply(null, args)) {
        value = _(_this).instanceOf(Hash) ? [args[0], args[1]] : args[0];
        return ret.push(value);
      }
    });
    return ret;
  },
  _reject: function(iterator) {
    var ret,
      _this = this;
    ret = [];
    this.each(function() {
      var args, value;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      if (!iterator.apply(null, args)) {
        value = _(_this).instanceOf(Hash) ? [args[0], args[1]] : args[0];
        return ret.push(value);
      }
    });
    return ret;
  },
  _inject: function() {
    var args, initial, iterator, memo;
    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    switch (args.length) {
      case 1:
        initial = null;
        iterator = args[0];
        break;
      case 2:
        initial = args[0];
        iterator = args[1];
        break;
      default:
        throw 'wrong argument';
    }
    memo = initial;
    this.each(function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      if (initial === null) {
        memo = args[0];
        return initial = true;
      } else {
        return memo = iterator.apply(null, [memo].concat(__slice.call(args)));
      }
    });
    return memo;
  },
  _max: function() {
    if (this.isEmpty()) {
      return null;
    } else if (_(this).instanceOf(Array)) {
      return Math.max.apply(Math, this);
    }
  },
  _min: function(iterator) {
    if (this.isEmpty()) {
      return null;
    } else if (_(this).instanceOf(Array)) {
      return Math.min.apply(Math, this);
    }
  },
  _shuffle: function() {
    var rand, shuffled, _ref;
    _ref = [[], null], shuffled = _ref[0], rand = _ref[1];
    this.each(function(value, index) {
      if (index === 0) {
        return shuffled[0] = value;
      } else {
        rand = Math.floor(Math.random() * (index + 1));
        shuffled[index] = shuffled[rand];
        return shuffled[rand] = value;
      }
    });
    return shuffled;
  },
  _sortBy: function(iterator) {
    var ret;
    ret = (this.map(function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return {
        value: args[0],
        criteria: iterator.apply(null, args)
      };
    })).sort(function(a, b) {
      var _ref;
      _ref = [a.criteria, b.criteria], a = _ref[0], b = _ref[1];
      if (a < b) {
        return -1;
      } else if (a > b) {
        return 1;
      } else {
        return 0;
      }
    });
    return ret.pluck('value');
  },
  _groupBy: function(iterator) {
    var ret,
      _this = this;
    ret = H();
    this.each(function() {
      var args, key, value;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      key = iterator.apply(null, args);
      value = _(_this).instanceOf(Hash) ? [args[0], args[1]] : args[0];
      return ret.fetch_or_store(key, []).push(value);
    });
    return ret;
  }
};

root['Enumerable'] = Enumerable;

Enumerable._collect = Enumerable._map;

Enumerable._detect = Enumerable._find;

})();

(function() {
var H, Hash,
  __hasProp = Object.prototype.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

Hash = (function(_super) {

  __extends(Hash, _super);

  function Hash(data) {
    var k, v;
    this.data = new Object;
    if (data) {
      for (k in data) {
        if (!__hasProp.call(data, k)) continue;
        v = data[k];
        this.data[k] = v;
      }
    }
  }

  Hash.prototype._each = function(iterator) {
    var k, v, _ref, _results;
    try {
      _ref = this.data;
      _results = [];
      for (k in _ref) {
        if (!__hasProp.call(_ref, k)) continue;
        v = _ref[k];
        _results.push(iterator(k, v, this.data));
      }
      return _results;
    } catch (err) {
      if (err !== BREAKER) throw err;
    }
  };

  Hash.prototype._isEmpty = function() {
    var k, v, _ref;
    _ref = this.data;
    for (k in _ref) {
      if (!__hasProp.call(_ref, k)) continue;
      v = _ref[k];
      return false;
    }
  };

  Hash.prototype._keys = function() {
    return Object.keys(this.data);
  };

  Hash.prototype._values = function() {
    var k, ret, _i, _len, _ref;
    ret = [];
    _ref = this.keys();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      k = _ref[_i];
      ret.push(this.data[k]);
    }
    return ret;
  };

  Hash.prototype._fetch = function(k, defaultValue) {
    var ret;
    defaultValue = defaultValue === void 0 ? null : defaultValue;
    ret = this.data[k];
    if (ret === void 0) {
      return defaultValue;
    } else {
      return ret;
    }
  };

  Hash.prototype._store = function(k, v) {
    return this.data[k] = v;
  };

  Hash.prototype._fetch_or_store = function(k, v) {
    var _base;
    if ((_base = this.data)[k] == null) _base[k] = v;
    return this.data[k];
  };

  Hash.prototype._toHash = function() {
    return this;
  };

  Hash.prototype._toObject = function() {
    return new Object(this.data);
  };

  Hash.prototype._keys = function() {
    var keys;
    keys = [];
    this.each(function(k) {
      return keys.push(k);
    });
    return keys;
  };

  Hash.prototype._values = function() {
    return this.map(function(k, v) {
      return v;
    });
  };

  Hash.prototype._hasKey = function(key) {
    var ret;
    ret = false;
    this.each(function(k) {
      if (k === key) {
        ret = true;
        throw BREAKER;
      }
    });
    return ret;
  };

  Hash.prototype._hasValue = function(value) {
    var ret;
    ret = false;
    this.each(function(k, v) {
      if (v === value) {
        ret = true;
        throw BREAKER;
      }
    });
    return ret;
  };

  return Hash;

})(Object);

Hash.prototype._get = Hash.prototype._fetch;

Hash.prototype._set = Hash.prototype._store;

Hash.prototype._get_or_set = Hash.prototype._fetch_or_store;

_.mixin(Hash, Enumerable);

H = function(data) {
  return new Hash(data);
};

root['Hash'] = Hash;

root['H'] = H;

})();

(function() {
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
  _each: function(iterator) {
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
  _isEqual: function(ary) {
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
  _isInclude: function(obj) {
    return this.indexOf(obj) !== -1;
  },
  _isEmpty: function() {
    return this.length === 0;
  },
  _clone: function() {
    return this.slice();
  },
  _random: function() {
    var i;
    i = Math.random() * this.length;
    return this[Math.floor(i)];
  },
  _zip: function() {
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
  _first: function(n) {
    if (n) {
      return this.slice(0, n);
    } else {
      return this[0];
    }
  },
  _last: function(n) {
    if (n) {
      return this.slice(this.length - n);
    } else {
      return this[this.length - 1];
    }
  },
  _compact: function() {
    return this.findAll(function(value) {
      return value !== null;
    });
  },
  _flatten: function(shallow) {
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
  _uniq: function(isSorted) {
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
  _without: function() {
    var args;
    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return this.findAll(function(value) {
      return !args.isInclude(value);
    });
  },
  _pluck: function(key) {
    return this.map(function(data) {
      return data[key];
    });
  },
  _findIndex: function(obj) {
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
  _invoke: function() {
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
  _indexOf: Array.prototype.indexOf || function(item, isSorted) {
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
  _lastIndexOf: Array.prototype.lastIndexOf || function(item) {
    var i;
    if (this === null) return -1;
    i = this.length;
    while (i--) {
      if (this[i] === item) return i;
    }
    return -1;
  }
});

Array.prototype._contains = Array.prototype._isInclude;

})();

(function() {
var Enumerator,
  __slice = Array.prototype.slice;

Enumerator = (function() {

  function Enumerator(data) {
    this.data = data;
  }

  Enumerator.prototype._with_object = function(memo, iterator) {
    this.data.each(function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return iterator.apply(null, [memo].concat(__slice.call(args)));
    });
    return memo;
  };

  Enumerator.prototype._each = function() {
    var args, _ref;
    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return (_ref = this.data).each.apply(_ref, args);
  };

  return Enumerator;

})();

root['Enumerator'] = Enumerator;

})();

(function() {

_.reopen(String, {
  _toInteger: function() {
    return parseInt(this);
  },
  _pluralize: function() {
    return "" + this + "s";
  },
  _capitalize: function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
  },
  _chop: function() {
    if (this.length === 0) {
      return "";
    } else {
      return this.substring(0, this.length - 1);
    }
  },
  _endsWith: function(str) {
    return this.length - str.length === this.lastIndexOf(str);
  },
  _reverse: function() {
    var i, s;
    s = "";
    i = this.length;
    while (i > 0) {
      s += this.substring(i - 1, i);
      i--;
    }
    return s;
  },
  _isEmpty: function() {
    return this.length === 0;
  }
});

})();

(function() {

_.reopenClass(Math, {
  _mod: function(val, mod) {
    if (val < 0) {
      while (val < 0) {
        val += mod;
      }
      return val;
    } else {
      return val % mod;
    }
  }
});

})();

(function() {

_.reopenClass(Number, {
  _max: function(a, b) {
    if (a < b) {
      return b;
    } else {
      return a;
    }
  },
  _min: function(a, b) {
    if (a > b) {
      return b;
    } else {
      return a;
    }
  }
});

_.reopen(Number, {
  _times: function(fn) {
    var i, _results;
    _results = [];
    for (i = 0; 0 <= this ? i < this : i > this; 0 <= this ? i++ : i--) {
      _results.push(fn(i));
    }
    return _results;
  }
});

})();

(function() {

})();


})();

