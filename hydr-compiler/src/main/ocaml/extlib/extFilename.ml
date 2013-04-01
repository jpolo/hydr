
module Filename = struct
  include Filename

  let extension (pathname: string) =
    match List.rev (ExtString.String.nsplit pathname ".") with
    | e :: _ -> String.lowercase e
    | [] -> ""
    
  let normalize (pathname: string) =
    let length = String.length pathname in
    if length = 0 then
      "."
    else match pathname.[length - 1] with
      | '\\' | '/' -> String.sub pathname 0 (length - 1)
      | _ -> pathname

end
