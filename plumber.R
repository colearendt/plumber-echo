library(plumber)

#* @apiTitle Plumber Echo API

#* Echo back the input
#* @get /echo
#* @post /echo
function(req){
  print(ls(envir = req))
  req_list <- as.list(req)
  print(lapply(req_list, class))
  req_list$args <- NULL
  req_list[["rook.input"]] <- NULL
  req_list[["rook.errors"]] <- NULL
  req_list[["httpuv.version"]] <- NULL
  return(req_list)
}

#* Echo the requester's IP address
#* @get /ip
#* @post /ip
#* @html
function(req){
  # read from FORWARDED_FOR if plumber is behind a proxy
  if (length(req[["HTTP_X_FORWARDED_FOR"]] > 0)){
    forwarded <- req[["HTTP_X_FORWARDED_FOR"]][[1]]
    return(strsplit(forwarded, ",")[[1]][1])
  } else {
    # otherwise REMOTE_ADDR should be reliable
    return(req$REMOTE_ADDR)
  }
}
