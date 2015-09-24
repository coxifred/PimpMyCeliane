wifi.sta.config(sid,wifi_pass)
cfg =
  {
    ip=wifi_ip,
    netmask=wifi_netmask,
    gateway=wifi_gateway
  }
wifi.sta.setip(cfg)

wifi.sta.connect()

