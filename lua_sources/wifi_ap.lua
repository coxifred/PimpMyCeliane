wifi.setmode(wifi.STATIONAP)
cfg={}
cfg.ssid="VoletCeliane" .. nodeId
cfg.pwd="fred12345"
wifi.ap.config(cfg)
ipcfg={
  ip=wifi_ip,
  netmask=wifi_netmask,
  gateway=wifi_gateway
}
wifi.ap.setip(ipcfg)
print("Access Point " , wifi.ap.getip())
