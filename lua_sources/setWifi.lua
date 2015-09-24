file.open("wifiMode.lua", "r")
mode=file.readline()
file.close()
print ("mode " .. mode)
write("Loading","wifi mode",mode,"","")
if ( mode == "ap" )
 then
    dofile("wifi_ap.lc")
 else
    dofile("wifi_station.lc")
end