var path = "/dir1/dir2/file.ext";
var path2 = "/dir1/dir.with.dots\\file";
var path3 = ".htaccess";
var path4 = "/dir/";

var p1 = new hydr.io.Path(path);
var p2 = new hydr.io.Path(path2);
var p3 = new hydr.io.Path(path3);
var p4 = new hydr.io.Path(path4);

p1.ext == "ext";
p1.dir == "/dir1/dir2";
p1.file == "file";

p2.ext == null;
p2.dir == "/dir1/dir.with.dots";
p2.file == "file";

p3.ext == "htaccess";
p3.dir == null;
p3.file == "";

p4.ext == null;
p4.dir == "/dir";
p4.file == "";

// toString
p1.toString() == path;
p2.toString() == path2;
p3.toString() == path3;
p4.toString() == path4;

// withoutExtension
hydr.io.Path.withoutExtension(path) == "/dir1/dir2/file";
hydr.io.Path.withoutExtension(path2) == path2;
hydr.io.Path.withoutExtension(path3) == "";
hydr.io.Path.withoutExtension(path4) == "/dir/";

// withoutDirectory
hydr.io.Path.withoutDirectory(path) == "file.ext";
hydr.io.Path.withoutDirectory(path2) == "file";
hydr.io.Path.withoutDirectory(path3) == ".htaccess";
hydr.io.Path.withoutDirectory(path4) == "";

// directory
hydr.io.Path.directory(path) == "/dir1/dir2";
hydr.io.Path.directory(path2) == "/dir1/dir.with.dots";
hydr.io.Path.directory(path3) == "";
hydr.io.Path.directory(path4) == "/dir";

// extension
hydr.io.Path.extension(path) == "ext";
hydr.io.Path.extension(path2) == "";
hydr.io.Path.extension(path3) == "htaccess";
hydr.io.Path.extension(path4) == "";

// withExtension
hydr.io.Path.withExtension(path, "foo") == "/dir1/dir2/file.foo";
hydr.io.Path.withExtension(path2, "foo") == "/dir1/dir.with.dots\\file.foo";
hydr.io.Path.withExtension(path3, "foo") == ".foo";
hydr.io.Path.withExtension(path4, "foo") == "/dir/.foo";

// addTrailingSlash
hydr.io.Path.addTrailingSlash("") == "/";
hydr.io.Path.addTrailingSlash("a") == "a/";
hydr.io.Path.addTrailingSlash("a/") == "a/";
hydr.io.Path.addTrailingSlash("a/b") == "a/b/";
hydr.io.Path.addTrailingSlash("a/b/") == "a/b/";
hydr.io.Path.addTrailingSlash("a\\") == "a\\";
hydr.io.Path.addTrailingSlash("a\\b") == "a\\b\\";
hydr.io.Path.addTrailingSlash("a\\b\\") == "a\\b\\";