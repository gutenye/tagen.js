tagenjs, bring Ruby into Javascript world.
===================================

| Homepage:      |  https://github.com/GutenYe/tagenjs       |
|----------------|------------------------------------------------------       |
| Author:	       | Guten                                                 |
| License:       | MIT-LICENSE                                                |
| Issue Tracker: | https://github.com/GutenYe/tagenjs/issues |


Features
--------

* Ruby compability. let's write javascript as easy as Ruby.
* Extend Javascript prototype without confict. e.g. `#_<method>`
* Inspried by underscore.

Getting Started
----------

	arr = [1, 2]
	arr._isEmpty() #=> false

for Object,  use `_(x).constructorName()`

others are extend prorotype, so `[].isEmpty()`

and don't use Object for data directly, use Hash instead, `H(a: 1).isEmpty()`


API
------

	Number
	.
	max(a, b) min(a, b)

	String
	#
	isEmpty()
	toInteger()
	endsWith(str)
	pluralize() capitalize()
	reverse()
	chop()

	Array
	#
	isEmpty()
	contains(x)
	equals(x)
	random()

	Math
	.
	mod(val, mod)

	window
	.
	pd()
	getInnerWidth() getInnerHeight()

	...

see source code.

INSTALL
-------

with rails 3.1

	# Gemfile
		gem "tagenjs"

	# app/assets/javascripts/application.js
		//= require 'tagenjs'

Resources
---------

* [ruby](http://www.ruby-lang.org/en): A Programmer's Best Friend.
* [coffee-script](http://coffeescript.org/): Unfancy JavaScript.
* [rake-pipeline](https://github.com/livingsocial/rake-pipeline): this project build by rake-pipeline.
* [underscore](http://underscorejs.org/) a utility-belt library.

Copyright
---------

(the MIT License)

Copyright (c) 2011-2012 Guten

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
