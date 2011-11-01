tagenjs, Javascript in Ruby way
===================================

compability: IE9 FF4 Webkit # use Object.definePrototype. 

Features
--------

* Ruby compability. e.g. `Enumerable`, `Enumerator`, `each`, `map` ... # write codeing between Ruby and Javascript
* Javascript Name Convention. e.g. `#empty?` -> `isEmpty`, `find_all` -> `FindAll`
* Best used with CoffeeScript. 

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

with bpm

	$ bpm add tagen

with rails 3.1

	$ gem install tagenjs
	# app/assets/javascripts/application.js
		//= require 'tagenjs'

NOTE
----

for sroutcore, need load 'tagen' before 'sproutcore'

Resources
---------

* [ruby](https://github.com/ruby/ruby) The Ruby Programming Language 
* [coffee-script](https://github.com/jashkenas/coffee-script) Unfancy JavaScript
* [bpm](https://github.com/bpm/bpm) a system for managing resource dependencies for client-side browser applications


Copyright
---------

(the MIT License)

Copyright (c) 2011 Guten

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
