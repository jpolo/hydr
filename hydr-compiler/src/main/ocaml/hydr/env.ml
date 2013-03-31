module Env = struct
  
  let is_debug() =
    try Sys.getenv "HYDR_DEBUG" = "1" with _ -> false
      
  let std_path() =
    Sys.getenv "HYDR_STD_PATH"    
end