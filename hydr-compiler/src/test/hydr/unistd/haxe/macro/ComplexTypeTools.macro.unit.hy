#if macro
var tt = function(c) return Std.string(hydr.macro.ComplexTypeTools.toType(c));
tt(macro : String) == "String";
tt(macro : Int) == "String";
#end