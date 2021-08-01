#  Probably pulled this code from DevCentral but it's good for troubleshooting
#  if statement can be used to limit traffic so you don't log for all traffic on a virtual server

when CLIENTSSL_HANDSHAKE {

    #if {[IP::addr [IP::client_addr] equals <client_IP_addr>] } {
        log local0.debug "Client Side [IP::client_addr]:[TCP::client_port] <-> [IP::local_addr]:[TCP::local_port] :: CLIENT_RANDOM [SSL::clientrandom] [SSL::sessionsecret]"
    #}

}

when SERVERSSL_HANDSHAKE {

    #if {[IP::addr [IP::client_addr] equals <client_IP_addr>] } {
    log local0.debug "Client Side [IP::client_addr]:[TCP::client_port] <-> [clientside {IP::local_addr}]:[clientside {TCP::local_port}] -- Server Side [IP::local_addr]:[TCP::local_port] <-> [IP::server_addr]:[TCP::server_port] :: CLIENT_RANDOM [SSL::clientrandom] [SSL::sessionsecret]"
    #}

}

# use the below to pull from the log files on the F5

# grep -o "CLIENT_RANDOM.*" /var/log/ltm > /var/tmp/pms.log
