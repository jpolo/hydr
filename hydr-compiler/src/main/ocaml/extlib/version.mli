type version = Version of int * int * int
type version_query = QueryPatch of int * int * int
           | QueryMinor of int * int
           | QueryMajor of int
type version_part = [ `Major | `Minor | `Patch ]

val string_of_version: version -> string

module Version: sig 

  val parse : string -> version
  val compare : version -> version -> int
  val part : version_part -> version -> int
  val major : version -> int
  val minor : version -> int
  val patch : version -> int
  val increment : version_part -> version -> version
  val decrement : version_part -> version -> version
  val print : version -> string

end
