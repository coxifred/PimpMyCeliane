currentLoading=0


--print ("srv " , srv)
if ( srv == nil )
 then
  --print ("serveur n'était pas demarré")
 else
  --print ("serveur était demarré, arret avant")
  srv:close()
end



    srv=net.createServer(net.TCP)
    
    srv:listen(80,wifi_ip,function(conn)
      conn:on("receive",function(conn,payload)
        local req = dofile("httpserver-request.lc")(payload)
        realResource=string.sub(req.request,2)
        print ("real resource " .. realResource)
        if ( realResource == "" )
         then
          --print ("read index.html")
          realResource="index.html"
          file.open(realResource)
          dofile("httpserver-header.lc")(conn, 200, "html")
          sendFile(conn,realResource)
          --conn:send(file.read(2048))
          --print ("finish2 index.html")
          else 
           --print ("realresource " .. realResource)
           if ( realResource == "up" )
           then
             up()
             conn:send("up")
           end
           if ( realResource == "down" )
           then
             down()
             conn:send("down")
           end
           if ( realResource == "currentState" )
           then
             conn:send(currentState)
           end
           if ( realResource == "currentNumber" )
           then
             conn:send(currentNumber)
           end
           if ( realResource == "currentMenu" )
           then
             conn:send(currentMenu)
           end
           if ( begin(realResource,"display"))
            then
              local retour=split(realResource,"&")
              --print (retour[1])
              write(retour[2],retour[3],retour[4],retour[5],retour[6])
              conn:send("displayed")
           end
           if ( begin(realResource,"secondUp"))
            then
              local retour=split(realResource,"=")
              --print ("retour : " .. retour[1])
              conn:send("send secondUp in background")
              upSecond(retour[2])
              
           end
           if ( begin(realResource,"secondDown"))
            then
              local retour=split(realResource,"=")
              --print ("retour : " .. retour[1])
              conn:send("send secondDown in background")
              downSecond(retour[2])
              
           end
           
           
           if ( realResource == "restart" )
           then
             node.restart()
           end
           if ( realResource == "wifiMode" )
           then
               file.open("wifiMode.lua", "r")
               mode=file.readline()
               file.close()
               file.open("wifiMode.lua", "w+")
               print ("mode " .. mode)
               if ( mode == "ap" )
                then
                file.write('station')
                print ("setting station")
                mode="station"
               else
                file.write('ap')
                print ("setting ap")
                mode="ap"
               end
               file.close()
               write("","wifi mode",mode,"restart","please")
               conn:send(mode)
           end
           if ( realResource == "stop" )
           then
             beAdmin()
             stop()
             noAdmin()
             conn:send("stop")
           end
           if ( realResource == "addNumber" )
           then
             beAdmin()
             changeNumber()
             noAdmin()
             conn:send(currentNumber)
           end
           if ( realResource == "switchMenu" )
           then
             beAdmin()
             changeMenu()
             noAdmin()
             conn:send(currentMenu)
           end
         end
        tmr.wdclr() 
      end)
      conn:on("sent",function(conn) conn:close() end)
    end)
 

function sendFile(conn, aFile)
   local continue = true
   local bytesSent = 0
   while continue do
      collectgarbage()
       -- NodeMCU file API lets you open 1 file at a time.
      -- So we need to open, seek, close each time in order
      -- to support multiple simultaneous clients.
      file.open(aFile)
      file.seek("set", bytesSent)
      local chunk = file.read(256)
      file.close()
      if chunk == nil then
         continue = false
      else
        --coroutine.yield()
         conn:send(chunk)
         --tmr.delay(10)
         bytesSent = bytesSent + #chunk
         chunk = nil
         --print("Sent" .. args.file, bytesSent)
      end
   end
end
function begin(chaine,motif)
   return string.sub(chaine,1,string.len(motif))==motif
end

function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end
