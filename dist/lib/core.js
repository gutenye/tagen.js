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
