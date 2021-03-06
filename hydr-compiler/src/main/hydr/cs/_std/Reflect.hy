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
import cs.internal.Function;
/*
 * Copyright (C) 2013-2013 Julien Polo
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *   - Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   - Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE HYDR PROJECT CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE HYDR PROJECT CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 */

/**
	The Reflect API is a way to manipulate values dynamicly through an
	abstract interface in an untyped manner. Use with care.
**/
@:keep @:coreApi class Reflect {

	/**
		Tells if an object has a field set. This doesn't take into account the object prototype (class methods).
	**/
	@:functionCode('
		if (o is hydr.lang.IHxObject)
			return ((hydr.lang.IHxObject) o).__hx_getField(field, hydr.lang.FieldLookup.hash(field), false, true, false) != hydr.lang.Runtime.undefined;

		return hydr.lang.Runtime.slowHasField(o, field);
	')
	public static function hasField( o : Dynamic, field : String ) : Bool
	{
		return false;
	}

	/**
		Returns the field of an object, or null if [o] is not an object or doesn't have this field.
	**/
	@:functionCode('
		if (o is hydr.lang.IHxObject)
			return ((hydr.lang.IHxObject) o).__hx_getField(field, hydr.lang.FieldLookup.hash(field), false, false, false);

		return hydr.lang.Runtime.slowGetField(o, field, false);
	')
	public static function field( o : Dynamic, field : String ) : Dynamic
	{
		return null;
	}


	/**
		Set an object field value.
	**/
	@:functionCode('
		if (o is hydr.lang.IHxObject)
			((hydr.lang.IHxObject) o).__hx_setField(field, hydr.lang.FieldLookup.hash(field), value, false);
		else
			hydr.lang.Runtime.slowSetField(o, field, value);
	')
	public static function setField( o : Dynamic, field : String, value : Dynamic ) : Void
	{

	}

	/**
		Similar to field but also supports property (might be slower).
	**/
	@:functionCode('
		if (o is hydr.lang.IHxObject)
			return ((hydr.lang.IHxObject) o).__hx_getField(field, hydr.lang.FieldLookup.hash(field), false, false, true);

		if (hydr.lang.Runtime.slowHasField(o, "get_" + field))
			return hydr.lang.Runtime.slowCallField(o, "get_" + field, null);

		return hydr.lang.Runtime.slowGetField(o, field, false);
	')
	public static function getProperty( o : Dynamic, field : String ) : Dynamic
	{
		return null;
	}

	/**
		Similar to setField but also supports property (might be slower).
	**/
	@:functionCode('
		if (o is hydr.lang.IHxObject)
			((hydr.lang.IHxObject) o).__hx_setField(field, hydr.lang.FieldLookup.hash(field), value, true);
		else if (hydr.lang.Runtime.slowHasField(o, "set_" + field))
			hydr.lang.Runtime.slowCallField(o, "set_" + field, new Array<object>(new object[]{value}));
		else
			hydr.lang.Runtime.slowSetField(o, field, value);
	')
	public static function setProperty( o : Dynamic, field : String, value : Dynamic ) : Void
	{

	}

	/**
		Call a method with the given object and arguments.
	**/
	@:functionCode('
		return ((hydr.lang.Function) func).__hx_invokeDynamic(args);
	')
	public static function callMethod( o : Dynamic, func : Dynamic, args : Array<Dynamic> ) : Dynamic
	{
		return null;
	}

	/**
		Returns the list of fields of an object, excluding its prototype (class methods).
	**/
	@:functionCode('
		if (o is hydr.lang.IHxObject)
		{
			Array<object> ret = new Array<object>();
				((hydr.lang.IHxObject) o).__hx_getFields(ret);
			return ret;
		} else if (o is System.Type) {
			return Type.getClassFields( (System.Type) o);
		} else {
			return new Array<object>();
		}
	')
	public static function fields( o : Dynamic ) : Array<String>
	{
		return null;
	}

	/**
		Tells if a value is a function or not.
	**/
	@:functionCode('
		return f is hydr.lang.Function;
	')
	public static function isFunction( f : Dynamic ) : Bool
	{
		return false;
	}

	/**
		Generic comparison function, does not work for methods, see [compareMethods]
	**/
	@:functionCode('
		return hydr.lang.Runtime.compare(a, b);
	')
	public static function compare<T>( a : T, b : T ) : Int
	{
		return 0;
	}

	/**
		Compare two methods closures. Returns true if it's the same method of the same instance.
	**/
	@:functionCode('
		if (f1 == f2)
			return true;

		if (f1 is hydr.lang.Closure && f2 is hydr.lang.Closure)
		{
			hydr.lang.Closure f1c = (hydr.lang.Closure) f1;
			hydr.lang.Closure f2c = (hydr.lang.Closure) f2;

			return hydr.lang.Runtime.refEq(f1c.obj, f2c.obj) && f1c.field.Equals(f2c.field);
		}

		return false;
	')
	public static function compareMethods( f1 : Dynamic, f2 : Dynamic ) : Bool
	{
		return false;
	}

	/**
		Tells if a value is an object or not.

	**/
	@:functionCode('
		return v is hydr.lang.DynamicObject;
	')
	public static function isObject( v : Dynamic ) : Bool
	{
		return false;
	}

	/**
		Delete an object field.
	**/
	@:functionCode('
		return (o is hydr.lang.DynamicObject && ((hydr.lang.DynamicObject) o).__hx_deleteField(f, hydr.lang.FieldLookup.hash(f)));
	')
	public static function deleteField( o : Dynamic, f : String ) : Bool
	{
		return false;
	}

	/**
		Make a copy of the fields of an object.
	**/
	public static function copy<T>( o : T ) : T
	{
		var o2 : Dynamic = {};
		for( f in Reflect.fields(o) )
			Reflect.setField(o2,f,Reflect.field(o,f));
		return cast o2;
	}

	/**
		Transform a function taking an array of arguments into a function that can
		be called with any number of arguments.
	**/
	@:overload(function( f : Array<Dynamic> -> Void ) : Dynamic {})
	public static function makeVarArgs( f : Array<Dynamic> -> Dynamic ) : Dynamic
	{
		return new VarArgsFunction(f);
	}

}
