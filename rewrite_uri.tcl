# Rewrites the URL before redirecting back to the server
# Was used because old backend system and client didn't want work on updating the strings

when HTTP_REQUEST {

	# host begins with some domain
	if { [HTTP::host] starts_with "something" } {

		# if above condition is met, let's evaluate the URIs
		if { [HTTP::uri] starts_with "/unsubscribe.php" or [HTTP::uri] starts_with "//unsubscribe.php" } {

			# set variable to insert /signup/unsubs/ before /unsubscribe.php but keep all other URI information
			set uri [ string map  {"/unsubscribe.php" "/signup/unsubs/unsubscribe.php"} [HTTP::uri] ]

			# redirect to new URL
			HTTP::redirect "https://[HTTP::host]$uri"

		}
		elseif { [HTTP::uri] starts_with "/resubscribe.php" } {

				# set variable to insert /signup/resubs/ before /resubscribe.php but keep all other URI information
				set uri [ string map {"/resubscribe.php" "/signup/resubs/resubscribe.php"} [HTTP::uri] ]

				# redirect to new URL
				HTTP::redirect "https://[HTTP::host]$uri"

		}

	}

}
