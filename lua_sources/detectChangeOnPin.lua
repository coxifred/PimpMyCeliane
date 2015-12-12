currentMenu="Volet"
local oldCurrentMenu="Volet"
currentNumber="0"
local version="Legrand Celiane v1.0"
currentState="unknown"
local pin1Value=0
local oldpin1Value=99
local pin2Value=0
local oldpin2Value=99

gpio.mode(3,gpio.OUTPUT)
gpio.mode(4,gpio.OUTPUT)

tmr.alarm(1,  1000, 1, function() 
        gpio.mode(1,gpio.OUTPUT)
        gpio.write(1,gpio.HIGH)
        gpio.mode(1,gpio.INPUT)
        pin1Value=gpio.read(1)
        --print('PIN 1 ',pin1Value)
        gpio.mode(2,gpio.OUTPUT)
        gpio.write(2,gpio.HIGH)
        gpio.mode(2,gpio.INPUT)
        pin2Value=gpio.read(2)
        --print('PIN 2 ',pin2Value)
        --print('currentMode: ', currentMode,' currentMenu: ' , currentMenu ,' currentNumber: ', currentNumber)

        if ( pin1Value ~= oldpin1Value or pin2Value ~= oldpin2Value) then
            if ( pin1Value == 1 and pin2Value == 1) then
                stop()
                if ( currentMode ~= "admin" ) then
                 beAdmin()
                end
            elseif (  pin1Value == 0 and pin2Value == 1 ) then
                 up()
                elseif (  pin2Value == 0 and pin1Value == 1 ) then
                 down()
            end
            oldpin1Value=pin1Value
            oldpin2Value=pin2Value
         else
          --print ('nothing change')
        end
        
end )

function launchHttp(action)

if ( currentMode ~= "admin" ) then
newHttp=http .. "nodeId=" .. nodeId .. "&mode=" .. oldCurrentMenu .. "&objId=" .. currentNumber.."&action="..action
sendMqtt("{mode:" .. oldCurrentMenu ..", currentNumber:" .. currentNumber ..", action:" .. action .."}")
print (newHttp)
sk=net.createConnection(net.TCP, 0)
sk:on("receive", function(conn, payload) print(payload) end )
sk:connect(80,serveur)
sk:send("GET " .. newHttp .. " HTTP/1.1\r\nHost: " .. serveur .. "\r\nConnection: keep-alive\r\nAccept: */*\r\n\r\n")
end

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



function stop()
 if ( currentMode ~= "admin" ) then
  gpio.write(4, gpio.LOW)
  carre(version,currentMenu .. "(" .. currentNumber ..")","","","stop now!")
  launchHttp("stop");
 end
end

function unstop()
if ( currentMode ~= "admin" ) then
 
 gpio.write(4, gpio.HIGH)
end
end


function up()
unstop()
 if ( currentMode ~= "admin" ) then

   dispUp(version,currentMenu .. "(" .. currentNumber ..")","up now!","","")
   print("currentMenu ",currentMenu, " currentNumber ", currentNumber," nodeId ", nodeId)
   if ( currentMenu == "Volet" and currentNumber == nodeId )
    then
       gpio.write(3, gpio.HIGH)
       currentState="up"
    end
       launchHttp("up")
 else
  changeMenu()
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
       currentState="down"
    end
       launchHttp("down")
 else
  changeNumber()
 end 
end
 
