var s = "";
var p:hydr.PosInfos = null;
var old = hydr.Log.trace;
hydr.Log.trace = function(v, ?i) {
	s = v;
	p = i;
}
trace("test trace");
s == "test trace";
p.fileName == "Log.unit.hx";
p.lineNumber == 8;
hydr.Log.trace = null;
exc(function() trace("exc test"));
hydr.Log.trace = old;