# Idea from https://devcentral.f5.com/questions/x-forwarded-for-multiple-ips-chained-need-original-ip-irules-and-http-profile-61021?lc=1
# As traffic passes through multiple proxies, IP addresses get added to the XFF header
# This will strip all that out and use the left most IP address or original client IP

when HTTP_REQUEST {
	
	# log local0. "Client IP: [IP::client_addr], XFF: [HTTP::header X-Forwarded-For]"

	if { [HTTP::header exists X-Forwarded-For] } {

		# If multiple IPs exist in header, strip out and replace with Original Client IP

		#log local0. "Too much in header...replace"
		HTTP::header replace X-Forwarded-For [getfield [HTTP::header X-Forwarded-For] "," 1]


	}
	else {

		# If nothing in header, add Original Client IP

		#log local0. "Nothing in Header"
		HTTP::header insert X-Forwarded-For [IP::remote_addr]

	}

	#log local0. "[HTTP::header X-Forwarded-For]"
	
}
