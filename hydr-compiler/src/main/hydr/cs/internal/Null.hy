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
package cs.internal;

@:classCode('
	//This function is here to be used with Reflection, when the hydr.lang.Null type is known
	public static hydr.lang.Null<T> _ofDynamic(object obj)
	{
		if (obj == null)
		{
			return new hydr.lang.Null<T>(default(T), false);
		} else if (typeof(T).Equals(typeof(double))) {
			return new hydr.lang.Null<T>((T) (object) hydr.lang.Runtime.toDouble(obj), true);
		} else if (typeof(T).Equals(typeof(int))) {
			return new hydr.lang.Null<T>((T) (object) hydr.lang.Runtime.toInt(obj), true);
		} else {
			return new hydr.lang.Null<T>((T) obj, true);
		}
	}
')
@:keep @:struct @:nativeGen @:native("hydr.lang.Null") private class Nullable<T>
{

	@:readOnly public var value:T;
	@:readOnly public var hasValue:Bool;

	@:functionCode('
			if ( !(v is System.ValueType) && System.Object.ReferenceEquals(v, default(T)))
			{
				hasValue = false;
			}

			this.@value = v;
			this.hasValue = hasValue;
	')
	public function new(v:T, hasValue:Bool)
	{
		this.value = v;
		this.hasValue = hasValue;
	}

	@:functionCode('
		if (obj == null)
		{
			return new hydr.lang.Null<D>(default(D), false);
		} else if (typeof(D).Equals(typeof(double))) {
			return new hydr.lang.Null<D>((D) (object) hydr.lang.Runtime.toDouble(obj), true);
		} else if (typeof(D).Equals(typeof(int))) {
			return new hydr.lang.Null<D>((D) (object) hydr.lang.Runtime.toInt(obj), true);
		} else {
			return new hydr.lang.Null<D>((D) obj, true);
		}
	')
	public static function ofDynamic<D>(obj:Dynamic):Nullable<D>
	{
		return null;
	}

	@:functionCode('
		if (this.hasValue)
			return value;
		return null;
	')
	public function toDynamic():Dynamic
	{
		return null;
	}
}