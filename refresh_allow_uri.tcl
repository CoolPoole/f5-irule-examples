# This irule is inteneted to only allow access to defined URLs and will present
# a 404 error should a match not exist

when HTTP_REQUEST {

	#log local0. "[HTTP::host] is the HOST and [HTTP::uri] is the URI"

	#passing URI into variable
	set uri [string tolower [HTTP::uri]]

	#allow only the host refresh-upg.pubsvs.com
	#check URI for match, no match 404 error displayed
	if { [HTTP::host] equals "<domain>" } {

		switch -glob $uri {

			"/some-uri*" - 
			"/some-uri*" {

				#log local0. "Meets Host and URI conditions"

				pool <pool name>

			}
			default {

			#log local0. "404 Error if none of the above conditions are true"

			HTTP::respond 404 content [ifile get STANDARD404]

			}
		}
	}
	else {

		#log local0. "404 Error for any other domain name"

		HTTP::respond 404 content [ifile get STANDARD404]

	}
}
