currentMenu="Volet"
local oldCurrentMenu="Volet"
currentNumber="0"
local version="Legrand Celiane v1.0"
currentState="unknown"



gpio.mode(1,gpio.INPUT,gpio.PULLUP)
gpio.mode(2,gpio.INPUT,gpio.PULLUP)
gpio.mode(3, gpio.OUTPUT,gpio.PULLUP)
gpio.mode(4, gpio.OUTPUT,gpio.PULLUP)

function launchHttp(action)
newHttp=http .. "nodeId=" .. nodeId .. "&mode=" .. oldCurrentMenu .. "&objId=" .. currentNumber.."&action="..action
print (newHttp)
sk=net.createConnection(net.TCP, 0)
sk:on("receive", function(conn, payload) print(payload) end )
sk:connect(80,serveur)
sk:send("GET " .. newHttp .. " HTTP/1.1\r\nHost: " .. serveur .. "\r\nConnection: keep-alive\r\nAccept: */*\r\n\r\n")
end

function all_trim(s)
   return s:match( "^%s*(.-)%s*$" )
end

function changeMenu()
  if ( currentMenu == "Volet" ) then
      currentMenu = "Lampes"
    elseif ( currentMenu == "Lampes" ) then
      currentMenu = "Led"
    elseif (currentMenu == "Led" ) then
      currentMenu = "Volet"
  end
  write(version,currentMenu,currentNumber,"","")
end

function changeNumber()
     
     oldCurrentMenu=currentMenu
     if ( currentNumber ==  "ALL" )
      then
       currentNumber=0
      else
       currentNumber=currentNumber + 1
     end
     if ( currentNumber > 10 )
      then
       currentNumber="ALL"
      end
     write(version,currentMenu,currentNumber,"","")
end

function upSecond(time)
     write(version,"Up for ",time,"ms","")
     up()
     tmr.alarm(0,  tonumber(time), 0, function() 
       stop()
     end )
end
function downSecond(time)
     write(version,"Up for ",time,"ms","")
     down()
     tmr.alarm(0, tonumber(time), 0, function() 
       stop()
     end )
end

function beAdmin()
     write(version,"admin exit in 10 secs !","","","")
     tmr.alarm(0, 10000, 0, function() 
       currentMode="noAdmin"
       write(version,"exit admin now!","","","")
     end )
     currentMode="admin"
end

function noAdmin()
     currentMode="noAdmin"
end

function changeMode()
   realLevel1=readLevel(1)
   realLevel2=readLevel(2)
   --print("realLevel1 ",realLevel1, " realLevel2 ", realLevel2)
   if  ( realLevel1 == 1 and realLevel2 == 1 and currentMode ~= "admin" )
    then
     --
     stop()
     beAdmin()
   end
   
end

function stop()
  gpio.write(4, gpio.LOW)
  carre(version,currentMenu .. "(" .. currentNumber ..")","","","stop now!")
  launchHttp("stop");
end

function unstop()
 gpio.write(4, gpio.HIGH)
end


function up()
unstop()
 if ( currentMode ~= "admin" )
 then
   dispUp(version,currentMenu .. "(" .. currentNumber ..")","up now!","","")
   print("currentMenu ",currentMenu, " currentNumber ", currentNumber," nodeId ", nodeId)
   if ( currentMenu == "Volet" and currentNumber == nodeId )
    then
       gpio.write(3, gpio.HIGH)
       
       gpio.trig(1, "down")
       currentState="up"
    end
       launchHttp("up")
 end 
end

function down()
unstop()
if ( currentMode ~= "admin" )
 then
   dispDown(version,"","",currentMenu .. "(" .. currentNumber ..")","down now!")
   print("currentMenu ",currentMenu, " currentNumber ", currentNumber," nodeId ", nodeId)
   if ( currentMenu == "Volet" and currentNumber == nodeId )
    then
       gpio.write(3, gpio.LOW)
       gpio.trig(2, "down")
       
       currentState="down"
    end
       launchHttp("down")
 end 
end
 
-- Fonction appelee en cas de branchement sur le pin1
function pin1cb(level)
      realLevel=readLevel(1)
      realLevel2=readLevel(2)
      --print ("Change on pin1 reallevel " , realLevel, " reallevel2 ", realLevel2)
      if ( currentMode == "admin" )
       then
        if ( realLevel2 == 1 ) then
           changeMenu()
        end
      else
      
      if realLevel == 1 then
             up()
          else 
             gpio.trig(1, "up")
          end
          changeMode()
     end
end

-- Fonction appelee en cas de branchement sur le pin2
function pin2cb(level)
      
      realLevel=readLevel(2)
      realLevel1=readLevel(1)
      --print ("Change on pin2 reallevel" , realLevel)
      print ("Change on pin2 reallevel " , realLevel, " reallevel1 ", realLevel1)
      if ( currentMode == "admin" )
       then
        if ( realLevel == 0 )
         then
          changeNumber()
        end
      else
      if realLevel == 1 then
         down()
      else
         gpio.trig(2, "up")
      end
      changeMode()
      end
end


function readLevel(index)
  i=0
  sum=0
  tmr.delay(200)
  while i <= 5 do
     sum=sum + gpio.read(index)
     i= i + 1
   end
   if sum >= 5
    then
      return 1
    else
      return 0
   end
end




if (gpio.read(1) == 0 )
 then
  gpio.trig(1, "down",pin1cb)
 else
  gpio.trig(1, "up",pin1cb)
end

if (gpio.read(2) == 0 )
 then
  gpio.trig(2, "down",pin2cb)
 else
  gpio.trig(2, "up",pin2cb)
end
