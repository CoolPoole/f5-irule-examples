# Inserting the TLS version used by the SSL connection
# Insert into a new header

when HTTP_REQUEST {

	HTTP::header insert "tls-version" [SSL::cipher version]

}
