tagenjs, bring Ruby into Javascript world.
===================================

| Homepage:      |  https://github.com/GutenYe/tagenjs       |
|----------------|------------------------------------------------------       |
| Author:	       | Guten                                                 |
| License:       | GPL  |
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

Copyright 2011-2012 Guten Ye

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
