if set --query proxy_host
    __proxy.set "http://$proxy_host"
end

function _plugin-proxy_uninstall --on-event plugin-proxy_uninstall
    echo 'Erasing proxy environment variables'
    # Unset proxy variables
    set --local envars http_proxy HTTP_PROXY \
        https_proxy HTTPS_PROXY \
        ftp_proxy FTP_PROXY \
        all_proxy ALL_PROXY

    for envar in $envars
        set --erase $envar
    end

    functions --erase _plugin-proxy_uninstall
end