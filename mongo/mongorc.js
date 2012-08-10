prompt = function() {
  var host = db.serverStatus().host;
  return host.toUpperCase() + ":[" + db + "] > ";
}
