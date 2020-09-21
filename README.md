### **Welcome to the PimpMyCeliane wiki!**

![PimpMyCeliane](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/fond.png?raw=true)

## **Quick description**

The purpose is to build an automated and wifi controlled rolling shutter switch.
Numbers of existings switchs are either expansives (zwave) either risky for rolling shutter (chacon shortcuts), or simply closed protocols.The other constraint : keeping my Legrand Celiane switch.

From base of simple NodeMcu (ESP8266) Module and Legrand Celiane wall switch, we're going to **Pimp my Celiane** Switch !

_All starts with a virtual overview:_

![virtualOverview](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/virtual.png?raw=true)

## **Features**

_Here are the indispensable features i have implemented:_

**1.Control from switch wall**, when you push a button, a http request is sent (over wifi) to a server of your choice. The action is displayed on OLED screen.

![feature1](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/feature1.png?raw=true)

**2.Control from remote**, the NodeMcu connect to your network and provide a trivial website that allows you to up/down/stop your rolling shutter. The website is embedded into to ESP8266. You can choose wifi mode (Access Point or Station). You can also change id of switch, switch function and restart.

![feature2](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/feature2.png?raw=true)

**3.Control from application**, use wget, curl, or anything else who can generate a http request with GET parameters.

![feature3](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/feature3.png?raw=true)

**4.Admin function from wallswitch**, allows you to control other devices (like rolling shutter, light, ...). Each action is posted to you Homeautomation Box.

![feature4](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/feature4.png?raw=true)

**5.Display some information on OLED**, allows you to display some data (T°, %humidity, mp3 played, etc ..) on the remote OLED Screen via a HTTP request.

![feature5](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/feature5.png?raw=true)

**6.Up or Down for only 5 seconds**, allows you to move your rolling shutter not entirely, for example half-opened. Precise time for pressed button (1,2...x Seconds)

![feature6](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/feature6.png?raw=true)

**7.Control all switchs from one**, allows you to move all your rolling shutters from only one wall switch.

![feature7](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/feature7.png?raw=true)

## **Installation**

No more hole, just hide the box(red) (nodeMcu, relay and power supply up to your Celiane Switch (behind your wall).
The oled screen is linked with 4 small wires, very thin.

![installation](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/installation.png?raw=true)

## **Configuration**

Very simple, one file by switch (containing id and wifi information).

![configuration](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/configuration.png?raw=true)

## **Hardware**

Less than 25euros, found on known electronics websites.

![hardware](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/hardware.png?raw=true)

 Please note the 3Dmodel disc viewable/downloadable [here](https://github.com/coxifred/PimpMyCeliane/blob/master/3d_printed/obturateur.stl).

![obturator](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/obturateur.jpg?raw=true)

## **Wiring**
![wiring](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/wiring.jpg?raw=true)

## **Adding MQTT Messages**

Last update, adding mqtt message for each events.

![mqtt](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/mqtt.png?raw=true)

## **More stage dives**

 ![init](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/initNow.jpg?raw=true)

## **Shots of reality (Proto #0)**

The initial Legrand Celiane Switch:

![switch](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/switch.jpg?raw=true)

The obturator (3D PRUSA I3 freshly printed and painted):

![obt_real](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/obturator_real.jpg?raw=true)

The original double deck Legrand Celiane :

![deck](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/double_deck.jpg?raw=true)

Backside with glue :

![back_glue](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/back.jpg?raw=true)

Oled with glue :

![oled_glue](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/glue.jpg?raw=true)

Main off :

![main_off](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/main.jpg?raw=true)

Main on (mcu on firstplan):

![main_on](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/main_on.jpg?raw=true)

Main on then down pushed (mcu on firstplan):

![main_on_down](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/main_on_down.jpg?raw=true)

Zoom Main on then down pushed (mcu on firstplan):

![main_on_down_zoom](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/main_on_down_zoom.jpg?raw=true)


Next step PCB :100: 

   Reduce space with Fritzing, and build some PCB, because actually, it's too big/difficult to hide behind a switch.

Work in progress...

![main_on_down_zoom](https://github.com/coxifred/PimpMyCeliane/blob/master/images_resources4wiki/frtizing.png?raw=true)
