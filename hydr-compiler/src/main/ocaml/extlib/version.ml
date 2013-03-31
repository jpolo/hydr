
type version = Version of int * int * int

type version_query = 
  | QueryPatch of int * int * int
  | QueryMinor of int * int
  | QueryMajor of int

type version_part = [ `Major | `Minor | `Patch ]

let string_of_version (Version (v1, v2, v3)) =
  Printf.sprintf "%d.%d.%d" v1 v2 v3

module Version = struct 
  open List
  open Printf
  open Scanf
  
  let parse (input: string) = 
    sscanf input "%d.%d.%d" (fun v1 v2 v3 -> Version (v1, v2, v3))
  
  let compare left right = 
    match left, right with
    Version (l1, l2, l3), Version (r1, r2, r3) ->
      match compare l1 r1, compare l2 r2, compare l3 r3 with
        | 0, 0, res -> res
        | 0, res, _ -> res
        | res, _, _ -> res
  
  let part p ver =
    match p, ver with
    | `Major, Version (l1, _, _) -> l1
    | `Minor, Version (_, l2, _) -> l2
    | `Patch, Version (_, _, l3) -> l3
    
  let major ver = part `Major ver
  let minor ver = part `Minor ver
  let patch ver = part `Patch ver
    
  let increment part ver = 
    match part, ver with
    | `Major, Version (l1, _, _) -> Version (l1 + 1, 0, 0)
    | `Minor, Version (l1, l2, _) -> Version (l1, l2 + 1, 0)
    | `Patch, Version (l1, l2, l3) -> Version (l1, l2, l3 + 1)
  
  let decrement part ver = 
    match part, ver with
    | `Major, Version (l1, _, _) -> Version (l1 - 1, 0, 0)
    | `Minor, Version (l1, l2, _) -> Version (l1, l2 - 1, 0)
    | `Patch, Version (l1, l2, l3) -> Version (l1, l2, l3 - 1)
  
  let print (Version (v1, v2, v3)) = 
    sprintf "%d.%d.%d" v1 v2 v3
    
    
  (* Should this just expect a sorted list instead of sorting it itself? *)
  let query_version query versions =
    let last ls = nth ls (length ls - 1) in
    let compareQuery q v = match q, v with
      | QueryPatch (maj, min, patch), v' -> Version (maj, min, patch) == v'
      | QueryMinor (maj, min), Version (v1, v2, _) -> maj == v1 && min == v2
      | QueryMajor maj, Version (v1, _, _) -> maj == v1 in
    let res = (sort compare (filter (compareQuery query) versions)) in
    if res == [] then None else Some (last res)

  let query_parse input =
    try sscanf input "%d.%d.%d" (fun v1 v2 v3 -> QueryPatch (v1, v2, v3))
    with End_of_file ->
      try sscanf input "%d.%d" (fun v1 v2 -> QueryMinor (v1, v2))
      with End_of_file -> sscanf input "%d" (fun v1 -> QueryMajor v1)

  let query_print = function
    | QueryPatch (maj, min, patch) -> sprintf "%d.%d.%d" maj min patch
    | QueryMinor (maj, min) -> sprintf "%d.%d" maj min
    | QueryMajor maj -> sprintf "%d" maj
     
  let query q vs = query_version (query_parse q) vs
  
end



