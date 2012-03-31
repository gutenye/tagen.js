var Enumerable,
  __slice = Array.prototype.slice;

Enumerable = {
  any: function(iterator) {
    var ret;
    ret = false;
    this.each(function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      if (ret |= iterator.apply(null, args)) return true;
    });
    return !!ret;
  },
  all: function(iterator) {
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
  none: function(iterator) {
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
  one: function(iterator) {
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
  map: function(iterator) {
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
  find: function(iterator) {
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
  findAll: function(iterator) {
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
  reject: function(iterator) {
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
  inject: function() {
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
  max: function() {
    if (this.isEmpty()) {
      return null;
    } else if (_(this).instanceOf(Array)) {
      return Math.max.apply(Math, this);
    }
  },
  min: function(iterator) {
    if (this.isEmpty()) {
      return null;
    } else if (_(this).instanceOf(Array)) {
      return Math.min.apply(Math, this);
    }
  },
  shuffle: function() {
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
  sortBy: function(iterator) {
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
  groupBy: function(iterator) {
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

Enumerable.collect = Enumerable.map;

Enumerable.detect = Enumerable.find;
