# iRule was written to block a certain user agent (Opera) for one a couple of URIs
# log local0. is used to log locally on the BIG-IP...hard if the system is very busy

when HTTP_REQUEST {

     # Variable Section

     #log local0. "[HTTP::uri] is the URI"
     set uri [string tolower [HTTP::uri]]
     set uagent [string tolower [HTTP::header "User-Agent"]]

     # Switch Statement is nice if you need to add multiple
     # Wildcards are allowed as well so you don't need to add every individual path

     switch -glob $uri {

     "/nano*" -
	"/vi*" {

          # Filter for User-Agent value 

          if { [string tolower $uagent] starts_with "opera/9.80" and [string tolower $uagent] ends_with "presto/2.12.388 version/12.17" }
          {
               
               # With F5, you can use static content to render
               # Here, I'm using a static HTML page uploaded to iFile (F5 thing) and respond with a 404 HTTP code

               #log local0. "404 Error"
               HTTP::respond 404 content [ifile get STANDARD404]
          }
          else {

               # Directing traffic to the pool of servers
               
               #log local0. "pool"
               pool <pool name>
          }
	  }
  }
}
