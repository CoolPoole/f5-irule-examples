# Pool Redirection based on Query String

when HTTP_REQUEST {

    # Set query string from URL into a variable
    set query [string tolower [HTTP::query]]

    #Condition is if the query contains newServers=true, it should go to new servers
    #   otherwise go to the old servers 
    if {$query contains "newservers=true"} {

                    # New
                    pool <some pool>

    }
    else {

                    # Old
                    pool <some pool>

    }

}
