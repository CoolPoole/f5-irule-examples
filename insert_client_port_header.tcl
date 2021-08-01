# Another example of taking data and inserting into a header

when CLIENT_ACCEPTED {

    set clientsourceport [TCP::client_port]
    set currenttime [clock seconds]
    set formattedtime [clock format $currenttime -format {$T}]
    set client_ip  [IP::client_addr]

    log local0. "Connection on $formattedtime from $client_ip with source port $clientsourceport."
    
}

when HTTP_REQUEST {

    HTTP::header insert X-Client-Source-Port "$clientsourceport"

    log local0. "Request headers [HTTP::request]"

}