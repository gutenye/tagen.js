
_.reopenClass(Number, {
  max: function(a, b) {
    if (a < b) {
      return b;
    } else {
      return a;
    }
  },
  min: function(a, b) {
    if (a > b) {
      return b;
    } else {
      return a;
    }
  }
});

_.reopen(Number, {
  times: function(fn) {
    var i, _results;
    _results = [];
    for (i = 0; 0 <= this ? i < this : i > this; 0 <= this ? i++ : i--) {
      _results.push(fn(i));
    }
    return _results;
  }
});
