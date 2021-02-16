function proxy --description "Setup proxy environment variables"
  if not set --query proxy_host
    echo "Error: You must set proxy_host to your proxy hostname:port in config.fish"
    echo "You may also set proxy_user to your username"
    return
  end

  if test "$proxy_auth" = "true"
    # Get user & password
    set --local user $proxy_user
    if not set --query proxy_user
      read --prompt="echo -n 'Proxy User: '" user
    end
    # Read password from different source
    switch (uname)
      case Darwin
        set --local proxy_domain (string split --right --max 1 : "$proxy_host" | head -1)
        set pass (security find-internet-password -a "$proxy_user" -ws "$proxy_domain")
        if test $status -ne 0
          echo "Unable to find proxy password in keychain"
          read --silent --prompt="echo -n 'Proxy password: '" pass
        end
      case '*'
        read --silent --promp="echo -n 'Proxy password: '" pass
    end
    # URL encode password
    set --local encpass (string escape --style=url "$pass")

    __proxy.set "http://$user:$encpass@$proxy_host"
  else
    __proxy.set "http://$proxy_host"
  end
end
