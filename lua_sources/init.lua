print ("Waiting 5sec in case of infinite loop")
tmr.alarm(5,  5000, 0, function() 
       dofile("startMe.lua")
       --print ("No start")
end )

