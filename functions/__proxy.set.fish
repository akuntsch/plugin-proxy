function __proxy.set --argument-names proxy --description "Set all proxy vars to specified value"

  set --local envars http_proxy HTTP_PROXY \
    https_proxy HTTPS_PROXY \
    ftp_proxy FTP_PROXY \
    all_proxy ALL_PROXY

  for envar in $envars
    if test $proxy = '-e'
      set --erase $envar
    else
      set --universal --export $envar $proxy
    end
  end
end
