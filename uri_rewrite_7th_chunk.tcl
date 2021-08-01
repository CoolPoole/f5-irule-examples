# Help from DevCentral https://devcentral.f5.com/questions/need-help-with-irule-56502#answer150279
# Jason Rahm is fantastic and helped with this one
# O365 was stripping out "." that happened to exist in the URI path on links in emails so client wanted it added back
# The "." existed in the 7th chuck (i.e. /1stchunk/2ndchunk/...)

when HTTP_REQUEST {

	#Set Variables to Hold HOST, URI, and Chunk Information
	set host [HTTP::host]
	set uri [HTTP::uri]
	set uri_chunk [getfield [HTTP::uri] / 8]

	#Logging for Troubleshooting Purposes
	#log local0. "HOST is $host"
	#log local0. "URI is $uri"
	#log local0. "URI Chunk is $uri_chunk"
	#log local0. "URI Chunk Length is $uri_chunk_len"

	#Condition to Check Lenth of Chunk
	if {[string length $uri_chunk] > 25 and !([string tolower $uri_chunk] ends_with ".")}{

	    #Add Period to Last Position of Chunk
	    set new_uri [string map [list ${uri_chunk} ${uri_chunk}.] [HTTP::uri]]

        HTTP::uri $new_uri

	    #Logging for Troubleshooing Purposes
	    #log local0. "New URI is $new_uri"

	}


}
