/*
 * Copyright (C)2013-2013 Julien Polo
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

// This file is generated, do not edit!
package js.html.svg;

/** The <code>SVGMaskElement</code> interface provides access to the properties of <code><a rel="custom" href="https://developer.mozilla.org/en/SVG/Element/mask">&lt;mask&gt;</a></code>
 elements, as well as methods to manipulate them.<br><br>
Documentation for this class was provided by <a href="https://developer.mozilla.org/en/DOM/SVGMaskElement">MDN</a>. */
@:native("SVGMaskElement")
extern class MaskElement extends Element
{
	/** Corresponds to attribute 
<code><a rel="custom" href="https://developer.mozilla.org/en/SVG/Attribute/height">height</a></code> on the given <code><a rel="custom" href="https://developer.mozilla.org/en/SVG/Element/mask">&lt;mask&gt;</a></code>
 element. */
	var height(default,null) : AnimatedLength;

	/** Corresponds to attribute 
<code><a rel="internal" href="https://developer.mozilla.org/en/SVG/Attribute/maskContentUnits" class="new">maskContentUnits</a></code> on the given <code><a rel="custom" href="https://developer.mozilla.org/en/SVG/Element/mask">&lt;mask&gt;</a></code>
 element. Takes one of the constants defined in <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/SVGUnitTypes" class="new">SVGUnitTypes</a></code> */
	var maskContentUnits(default,null) : AnimatedEnumeration;

	/** Corresponds to attribute 
<code><a rel="internal" href="https://developer.mozilla.org/en/SVG/Attribute/maskUnits" class="new">maskUnits</a></code> on the given <code><a rel="custom" href="https://developer.mozilla.org/en/SVG/Element/mask">&lt;mask&gt;</a></code>
 element. Takes one of the constants defined in <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/SVGUnitTypes" class="new">SVGUnitTypes</a></code> */
	var maskUnits(default,null) : AnimatedEnumeration;

	/** Corresponds to attribute 
<code><a rel="custom" href="https://developer.mozilla.org/en/SVG/Attribute/width">width</a></code> on the given <code><a rel="custom" href="https://developer.mozilla.org/en/SVG/Element/mask">&lt;mask&gt;</a></code>
 element. */
	var width(default,null) : AnimatedLength;

	var x(default,null) : AnimatedLength;

	var y(default,null) : AnimatedLength;

}
