# Example for using a data group to filter traffic

when HTTP_REQUEST {
	
	#Looks to see if Client IP is in DataGroup
	#If not, send 404
	if { (![class match [IP::client_addr] equals <datagroup name>]) } {
			
			#log local0. "404 Error"
			HTTP::respond 404 content [ifile get STANDARD404]
			
		}
	
}
