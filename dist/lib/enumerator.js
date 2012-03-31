var Enumerator,
  __slice = Array.prototype.slice;

Enumerator = (function() {

  function Enumerator(data) {
    this.data = data;
  }

  Enumerator.prototype.with_object = function(memo, iterator) {
    this.data.each(function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return iterator.apply(null, [memo].concat(__slice.call(args)));
    });
    return memo;
  };

  Enumerator.prototype.each = function() {
    var args, _ref;
    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return (_ref = this.data).each.apply(_ref, args);
  };

  return Enumerator;

})();

root['Enumerator'] = Enumerator;
