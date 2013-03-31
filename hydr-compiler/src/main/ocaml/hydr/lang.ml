type paths = {
    home_dir : string;
    bin_dir : string;
    std_dir : string;
    addons_dir : string;
  }
module Lang = struct
  open Env
  open Filename
  open Path
  open List
  open Version
  

  (* 
   * General Information 
   *)
  let name = "hydr"
  let name_pretty = "Hydr"
  let version = Version(3, 0, 0)
  let version_string = Version.print version
  
  (* 
   * File Utils
   * 
   *)
  let filename_source_extension = "hy"
  let filename_build_extension = "hyml"
  let filename_exe (basename: string) = 
    basename ^ (if Env.is_windows then ".exe" else "")

  let filename_source (basename: string) =
    basename ^ "." ^ filename_source_extension
  
  (* 
   * File information 
   * 
   * hydr ∕ hydrlib
   *)
  let filename_compiler = 
    filename_exe (name ^ "c")
  let filename_libmanager = 
    filename_exe (name ^ "lib")
  
  let paths_resolve() =
    let home = Path.home_resolve name in
    let bin = Filename.concat home "bin" in
    let std = Filename.concat home "std" in
    let addons = Filename.concat home "addons" in
    {
      home_dir = home;
      bin_dir = bin;
      std_dir = std;
      addons_dir = addons;
    }
      

  

  
    
end
