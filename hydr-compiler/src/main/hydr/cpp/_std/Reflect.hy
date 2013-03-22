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
@:coreApi class Reflect {

	public  static function hasField( o : Dynamic, field : String ) : Bool untyped {
		return o!=null && o.__HasField(field);
	}

	public static function field( o : Dynamic, field : String ) : Dynamic untyped {
		return (o==null) ? null : o.__Field(field,false);
	}

	public inline static function setField( o : Dynamic, field : String, value : Dynamic ) : Void untyped {
		if (o!=null)
			o.__SetField(field,value,false);
	}

	public static inline function getProperty( o : Dynamic, field : String ) : Dynamic {
		return (o==null) ? null : o.__Field(field,true);
	}

	public static inline function setProperty( o : Dynamic, field : String, value : Dynamic ) : Void {
		if (o!=null)
			o.__SetField(field,value,true);
	}

	public static function callMethod( o : Dynamic, func : Dynamic, args : Array<Dynamic> ) : Dynamic untyped {
			if (func!=null && func.__GetType()==__global__.vtString)
				func = o.__Field(func,true);
			untyped func.__SetThis(o);
         return untyped func.__Run(args);
	}

	public static function fields( o : Dynamic ) : Array<String> untyped {
		if( o == null ) return new Array();
		var a : Array<String> = [];
		o.__GetFields(a);
		return a;
	}

	public static function isFunction( f : Dynamic ) : Bool untyped {
		return f!=null && f.__GetType() ==  __global__.vtFunction;
	}

	public static function compare<T>( a : T, b : T ) : Int {
		return ( a == b ) ? 0 : (((cast a) > (cast b)) ? 1 : -1);
	}

	public static function compareMethods( f1 : Dynamic, f2 : Dynamic ) : Bool {
		if( f1 == f2 )
			return true;
		if( !isFunction(f1) || !isFunction(f2) )
			return false;
		return untyped __global__.__hxcpp_same_closure(f1,f2);
	}

	public static function isObject( v : Dynamic ) : Bool untyped {
		if (v==null) return false;
		var t:Int = v.__GetType();
		return t ==  __global__.vtObject || t==__global__.vtClass || t==__global__.vtString ||
				t==__global__.vtArray;
	}

	public static function deleteField( o : Dynamic, f : String ) : Bool untyped {
		if (o==null) return false;
		return untyped __global__.__hxcpp_anon_remove(o,f);
	}

	public static function copy<T>( o : T ) : T {
		if (o==null) return null;
		if(untyped o.__GetType()==__global__.vtString ) return o;
		if(untyped o.__GetType()==__global__.vtArray )
			return untyped o.__Field("copy",true)();
		var o2 : Dynamic = {};
		for( f in Reflect.fields(o) )
			Reflect.setField(o2,f,Reflect.field(o,f));
		return o2;
	}

	@:overload(function( f : Array<Dynamic> -> Void ) : Dynamic {})
	public static function makeVarArgs( f : Array<Dynamic> -> Dynamic ) : Dynamic {
		return untyped __global__.__hxcpp_create_var_args(f);
	}
}
