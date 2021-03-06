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
package sys.db;

/**
	Record Object : the persistent object base type. See the tutorial on Hydr
	website to learn how to use Record.
**/
@:keepSub
@:autoBuild(sys.db.RecordMacros.macroBuild()) @:skipFields
class Object {

	var _lock(default,never) : Bool;
	var _manager(default,never) : sys.db.Manager<Dynamic>;

	public function new() {
		#if php
		if( _manager == null ) untyped _manager = Type.getClass(this).manager;
		#end
	}

	public function insert() {
		untyped _manager.doInsert(this);
	}

	public function update() {
		untyped _manager.doUpdate(this);
	}

	public function lock() {
		untyped _manager.doLock(this);
	}

	public function delete() {
		untyped _manager.doDelete(this);
	}

	public function isLocked() {
		return _lock;
	}

	public function toString() : String {
		return untyped _manager.objectToString(this);
	}

}
