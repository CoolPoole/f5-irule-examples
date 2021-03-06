# What It says...Log All Headers!

when HTTP_REQUEST {
   set LogString "Client [IP::client_addr]:[TCP::client_port] -> [HTTP::host][HTTP::uri]"
   log local0. "============================================="
   log local0. "$LogString (request)"
   foreach aHeader [HTTP::header names] {
      log local0. "$aHeader: [HTTP::header value $aHeader]"
   }
   log local0. "============================================="
}

when HTTP_RESPONSE {
   log local0. "============================================="
   log local0. "$LogString (response) - status: [HTTP::status]"
   foreach aHeader [HTTP::header names] {
      log local0. "$aHeader: [HTTP::header value $aHeader]"
   }
   log local0. "============================================="   
}
