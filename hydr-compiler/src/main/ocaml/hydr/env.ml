module Env = struct
  let is_cygwin = Sys.os_type = "Cygwin"
  let is_windows = Sys.os_type = "Win32"
  let is_unix = Sys.os_type = "Unix"
  
  let is_debug() =
    try Sys.getenv "HYDR_DEBUG" = "1" with _ -> false
      
  let home() = 
    Sys.getenv "HYDR_HOME"
  
  let compilation_server() =
    Sys.getenv "HYDR_COMPILATION_SERVER"
    
  let executable_path =
    Extc.executable_path()
end
