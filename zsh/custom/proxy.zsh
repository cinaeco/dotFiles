# Set proxy environment variables
function setproxy() {
  proxy_address=${1:-}
  export HTTP_PROXY=$proxy_address
  export HTTPS_PROXY=$proxy_address
  export FTP_PROXY=$proxy_address
  export http_proxy=$proxy_address
  export https_proxy=$proxy_address
  export ftp_proxy=$proxy_address
  echo "Proxy envvars set to '$proxy_address'"
}
