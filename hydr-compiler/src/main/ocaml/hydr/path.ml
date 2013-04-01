
module Path  = struct
  open Env

  exception HomeNotFound

  let full (pathname: string) = 
    try Extc.get_full_path pathname with _ -> pathname
    
  let full_unique = 
    if Env.is_windows || Env.is_cygwin then 
      (fun f -> String.lowercase (full f)) 
    else full
    
  let extension (pathname: string) =
    ExtFilename.Filename.extension pathname
    
  let normalize (pathname: string) =
    ExtFilename.Filename.normalize pathname

  let executable (basename: string) = 
    basename ^ (if Env.is_windows then ".exe" else "")
    
  let source (partial_path: string) =
    let f = String.concat "/" (ExtString.String.nsplit partial_path "\\") in
    let cl = ExtString.String.nsplit f "." in
    let cl = (match List.rev cl with
      | ["hy";path] -> ExtString.String.nsplit path "/"
      | _ -> cl
    ) in
    let error() =
      let msg =
        if String.length f == 0 then
          "Class name must not be empty"
        else match (List.hd (List.rev cl)).[0] with
          | 'A'..'Z' -> "Invalid class name"
          | _ -> "Class name must start with uppercase character"
      in
      failwith msg
    in
    let invalid_char x =
      for i = 1 to String.length x - 1 do
        match x.[i] with
        | 'A'..'Z' | 'a'..'z' | '0'..'9' | '_' -> ()
        | _ -> error()
      done;
      false
    in
    let rec loop = function
      | [] -> error()
      | [x] -> if String.length x = 0 || not (x.[0] = '_' || (x.[0] >= 'A' && x.[0] <= 'Z')) || invalid_char x then error() else [] , x
      | x :: l ->
        if String.length x = 0 || x.[0] < 'a' || x.[0] > 'z' || invalid_char x then error() else
          let path , name = loop l in
          x :: path , name
    in
    loop cl

  let resolve file_paths (partial_path:string) =
    let rec loop = function
      | [] -> raise Not_found
      | file_path :: rest ->
        let file = Filename.concat (normalize file_path) partial_path in
        if Sys.file_exists file then
          file
        else
          loop rest
    in
    loop file_paths

  let self_dir =
    let base_path = (try Extc.executable_path() with _ -> "./") in
    normalize (Extc.get_real_path base_path)
    
  let home_resolve(name: string) =
    let homes_env = (
      try normalize (Env.home())::[] 
      with _ -> []
    ) in
    let homes_relative = (Filename.dirname self_dir)::[] in
    let homes_sys = 
      if Env.is_unix then 
        ["/usr/lib/" ^ name;"/usr/local/lib/" ^ name] 
      else 
        ["C:\\Program Files\\" ^ name] 
    in
    let paths = homes_env @ homes_relative @ homes_sys in
    try
      let filter = (fun dir -> 
        try Sys.is_directory(dir) 
        with _ -> false
      ) in
      let filtered = List.filter filter paths in
      List.hd filtered
    with
    | Failure(m) -> raise HomeNotFound
    | e ->  raise e(* catch all exceptions *)
    
  
  (*let self_bin =*)
  

end
