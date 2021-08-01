# Used in case both servers are down and client wants traffic to go elsewhere

when LB_FAILED {

		#Logging for Troubleshooting Purposes
		#log local0. "URL is [HTTP::host][HTTP::uri]"

		#Redirect to AWS Page and include Original URL in Query String
		HTTP::respond 302 Location https://somesite.com/some-video.php?URL="[HTTP::host][HTTP::uri]"

}
