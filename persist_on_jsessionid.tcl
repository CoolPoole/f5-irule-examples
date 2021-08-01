# Reference https://devcentral.f5.com/questions/jsessionids-with-null-or-empty-values
# Some apps use JSESSION_ID and you can use a universal persistence profile to call this irule


when HTTP_REQUEST {

   # Log details for the request

   set log_prefix "[IP::client_addr]:[TCP::client_port]"
   #log local0. "$log_prefix: Request to [HTTP::uri] with cookie: [HTTP::cookie value JSESSIONID]"

   # Check if there is a JSESSIONID cookie
   if { [HTTP::cookie "JSESSIONID"] ne "" }{

      # Persist off of the cookie value with a timeout of 1 hour (3600 seconds)
      persist uie [string tolower [HTTP::cookie "JSESSIONID"]] 3600

      # Log that we're using the cookie value for persistence and the persistence key if it exists.
      #log local0. "$log_prefix: Used persistence record from cookie. Existing key? [persist lookup uie [string tolower [HTTP::cookie "JSESSIONID"]]]"

   } else {

      # Parse the jsessionid from the path. The jsessionid, when included in the URI, is in the path, 
      # not the query string: /path/to/file.ext;jsessionid=1234?param=value
      set jsess [findstr [string tolower [HTTP::path]] "jsessionid=" 11]

      # Use the jsessionid from the path for persisting with a timeout of 1 hour (3600 seconds)
      if { $jsess != "" } {

         persist uie $jsess 3600

         # Log that we're using the path jessionid for persistence and the persistence key if it exists.
         #log local0. "$log_prefix: Used persistence record from path: [persist lookup uie $jsess]"
      }
   }
}
when HTTP_RESPONSE {

   # Check if there is a jsessionid cookie in the response
   if { [string map {\" ""} [HTTP::cookie "JSESSIONID"]] ne "" }{

      # Persist off of the cookie value with a timeout of 1 hour (3600 seconds)
      persist add uie [string tolower [HTTP::cookie "JSESSIONID"]] 3600

      #log local0. "$log_prefix: Added persistence record from cookie: [persist lookup uie [string tolower [HTTP::cookie "JSESSIONID"]]]"

   }
}
