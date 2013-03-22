#if !(java || cs)
var http1 = new hydr.Http("_");
var r = "";
http1.onStatus = function(_) r = "status";
http1.onError = function(_) r = "error";
r = "sync";
http1.request(false);
r in ["sync", "status", "error"];

#if js
http1.async = false;
r = "sync";
http1.request(false);
r == "error";
#end
#if !flash
exc(function() hydr.Http.requestUrl("_"));
#end
#end
