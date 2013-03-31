
module Path  = struct
  open Env

  exception HomeNotFound

  let full (pathname: string) = 
    try Extc.get_full_path pathname with _ -> pathname
    
  let full_unique = 
    if Env.is_windows || Env.is_cygwin then 
      (fun f -> String.lowercase (full f)) 
    else full
    
  let normalize (pathname: string) =
    let length = String.length pathname in
    if length = 0 then
      "."
    else match pathname.[length - 1] with
      | '\\' | '/' -> String.sub pathname 0 (length - 1)
      | _ -> pathname

  let executable (basename: string) = 
    basename ^ (if Env.is_windows then ".exe" else "")

  let resolve file_paths (partial_path:string) =
    let rec loop = function
      | [] -> raise Not_found
      | file_path :: rest ->
        let file = (normalize file_path) ^ "/" ^ partial_path in
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
