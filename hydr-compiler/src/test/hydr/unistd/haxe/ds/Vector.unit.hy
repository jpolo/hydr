var vec = new hydr.ds.Vector(3);
var vNullInt = #if (flash9 || cpp || java || cs) 0 #else null #end;
var vNullBool = #if (flash9 || cpp || java || cs) false #else null #end;
var vNullFloat = #if (flash9 || cpp || java || cs) 0.0 #else null #end;

vec.length == 3;
vec.get(0) == vNullInt;
vec.get(1) == vNullInt;
vec.get(2) == vNullInt;
vec.set(1, 2);
vec.length == 3;
vec.get(0) == vNullInt;
vec.get(1) == 2;
vec.get(2) == vNullInt;

// float init
var vec = new hydr.ds.Vector<Float>(3);
vec.get(0) == vNullFloat;
vec.get(1) == vNullFloat;
vec.get(2) == vNullFloat;

// bool init
// Adobe's compilers seem to have a bug here that gives null instead of false
#if !as3
var vec = new hydr.ds.Vector<Bool>(3);
vec.get(0) == vNullBool;
vec.get(1) == vNullBool;
vec.get(2) == vNullBool;
#end

// fromArray
var arr = ["1", "2", "3"];
var vec:hydr.ds.Vector<String> = hydr.ds.Vector.fromArrayCopy(arr);
#if (!flash && !neko && !cs && !java)
arr != vec.toData();
#end
vec.length == 3;
vec.get(0) == "1";
vec.get(1) == "2";
vec.get(2) == "3";

// objects
var tpl = new C();
var vec:hydr.ds.Vector<C> = hydr.ds.Vector.fromArrayCopy([tpl]);
tpl == vec.get(0);

// toData + fromData
var vec:hydr.ds.Vector<String> = hydr.ds.Vector.fromArrayCopy(["1", "2", "3"]);
var data = vec.toData();
var vec2 = hydr.ds.Vector.fromData(data);
vec2.get(0) == "1";
vec2.get(1) == "2";
vec2.get(2) == "3";

// []
vec2[0] == "1";
vec2[1] == "2";
vec2[2] == "3";
vec2[1] = "4";
vec2[1] == "4";
vec2[0] += "a";
vec2[0] = "1a";

// blit
var vec3 = hydr.ds.Vector.fromArrayCopy([0,1,2,3,4,5,6]);
var vec4 = new hydr.ds.Vector(5);

hydr.ds.Vector.blit(vec3, 0, vec4, 1, 3);
vec4[1] == 0;
vec4[2] == 1;
vec4[3] == 2;
vec4[4] == vNullInt;
vec4[0] == vNullInt;

hydr.ds.Vector.blit(vec3, 0, vec4, 0, 5);
vec4[0] == 0;
vec4[1] == 1;
vec4[2] == 2;
vec4[3] == 3;
vec4[4] == 4;

hydr.ds.Vector.blit(vec4, 1, vec3, 0, 4);
//vec3 should be [1,2,3,4,4,5,6]
vec3[0] == 1;
vec3[1] == 2;
vec3[2] == 3;
vec3[3] == 4;
vec3[4] == 4;
vec3[5] == 5;
vec3[6] == 6;
