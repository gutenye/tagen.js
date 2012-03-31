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

  Hash.prototype.each = function(iterator) {
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

  Hash.prototype.isEmpty = function() {
    var k, v, _ref;
    _ref = this.data;
    for (k in _ref) {
      if (!__hasProp.call(_ref, k)) continue;
      v = _ref[k];
      return false;
    }
  };

  Hash.prototype.keys = function() {
    return Object.keys(this.data);
  };

  Hash.prototype.values = function() {
    var k, ret, _i, _len, _ref;
    ret = [];
    _ref = this.keys();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      k = _ref[_i];
      ret.push(this.data[k]);
    }
    return ret;
  };

  Hash.prototype.fetch = function(k, defaultValue) {
    var ret;
    defaultValue = defaultValue === void 0 ? null : defaultValue;
    ret = this.data[k];
    if (ret === void 0) {
      return defaultValue;
    } else {
      return ret;
    }
  };

  Hash.prototype.store = function(k, v) {
    return this.data[k] = v;
  };

  Hash.prototype.fetch_or_store = function(k, v) {
    var _base;
    if ((_base = this.data)[k] == null) _base[k] = v;
    return this.data[k];
  };

  Hash.prototype.toHash = function() {
    return this;
  };

  Hash.prototype.toObject = function() {
    return new Object(this.data);
  };

  Hash.prototype.keys = function() {
    var keys;
    keys = [];
    this.each(function(k) {
      return keys.push(k);
    });
    return keys;
  };

  Hash.prototype.values = function() {
    return this.map(function(k, v) {
      return v;
    });
  };

  Hash.prototype.hasKey = function(key) {
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

  Hash.prototype.hasValue = function(value) {
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

Hash.prototype.get = Hash.prototype.fetch;

Hash.prototype.set = Hash.prototype.store;

Hash.prototype.get_or_set = Hash.prototype.fetch_or_store;

_.mixin(Hash, Enumerable);

H = function(data) {
  return new Hash(data);
};

root['Hash'] = Hash;

root['H'] = H;
