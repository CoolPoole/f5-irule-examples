# This irule performs pool redirection based on domain otherwise client
# receives 404 error

 when HTTP_REQUEST {

     #log local0. "[HTTP::host] is the HOST and [HTTP::uri] is the URI"

     if { [HTTP::host] contains "<domain>" } {

          #log local0. "<domain>"

          pool <pool name>

     }
     else {

          #log local0. "404 Error"

          HTTP::respond 404 content [ifile get STANDARD404]

     }

}
