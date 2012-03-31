
_.reopen(String, {
  toInteger: function() {
    return parseInt(this);
  },
  pluralize: function() {
    return "" + this + "s";
  },
  capitalize: function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
  },
  chop: function() {
    if (this.length === 0) {
      return "";
    } else {
      return this.substring(0, this.length - 1);
    }
  },
  endsWith: function(str) {
    return this.length - str.length === this.lastIndexOf(str);
  },
  reverse: function() {
    var i, s;
    s = "";
    i = this.length;
    while (i > 0) {
      s += this.substring(i - 1, i);
      i--;
    }
    return s;
  },
  isEmpty: function() {
    return this.length === 0;
  }
});
