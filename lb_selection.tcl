# iRule to log which server is elected during a LB decision https://support.f5.com/csp/article/K20241153

# Log Locally - Be Careful!!!

when LB_SELECTED {

    log local0. "LB INFO - Client: [IP::remote_addr], Port: [TCP::remote_port], Pool: [LB::server], Ratio: [LB::server ratio], Persist: [persist lookup source_addr [IP::client_addr]]"

}

# Log Remotely

when CLIENT_ACCEPTED {

    set hsl [HSL::open -proto UDP -pool lb_decision_logging_pool]

}
when LB_SELECTED {

    HSL::send $hsl "<134> LB INFO - Client: [IP::remote_addr], Port: [TCP::remote_port], Pool: [LB::server], Ratio: [LB::server ratio], Persist: [persist lookup source_addr [IP::client_addr]]/n"

}