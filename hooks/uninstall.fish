# Unset proxy variables
set --local envars http_proxy HTTP_PROXY \
  https_proxy HTTPS_PROXY \
  ftp_proxy FTP_PROXY \
  all_proxy ALL_PROXY

for envar in $envars
  set --erase $envar
end

# Erase proxy functions
functions --erase noproxy proxy __proxy.set
