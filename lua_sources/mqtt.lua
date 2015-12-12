m = mqtt.Client(nodeName .. nodeId, 120)
print ('Mqtt client' , nodeName .. nodeId)
connected = 0

function connectionCheck()
    if wifi.sta.status() == 5 and wifi.sta.getip() ~= nil and connected == 0 then
        print ("Mqtt reconnecting...") 
        m:connect(mqtt_server, mqtt_port, 0,  function(conn)
        print('Mqtt connected')
        write("","ready","","","")
        connected = 1
        end)
    end
end



connectionCheck()

tmr.alarm(3, 5000, 1, function()
     connectionCheck()
     end)

m:on("offline", function(con) 
     connected=0
end)

function sendMqtt(message)
 if ( connected == 1 ) then
  print ("Mqtt sending..." ,message, " " , node.heap() ) 
  --m:connect(mqtt_server, mqtt_port, 0, function(conn)  print("connected") end)
  --m:connect("192.168.1.29", 1883, 0, function(conn)  print("connected") end)
   m:publish(mqtt_topic,message,0,0, function(conn) print("Mqtt sent") end)
   --m:close()
   --mqtt.Client:close()
   else
   print ("Mqtt not ready or not connected, please wait") 
 end
end





