
-- setup I2c and connect display
function init_i2c_display()
     -- SDA and SCL can be assigned freely to available GPIOs
     local sda = 5 -- GPIO14
     local scl = 6 -- GPIO12
     local sla = 0x3c
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(sla)
end

-- the draw() routine
function draw(text1,text2,text3,text4,text5)
     --print("text1 ",text1, " text2 ", text2, " text3 ",text3, " text4 ", text4, " text5 ", text5)
     disp:setFont(u8g.font_6x10)
     disp:drawStr( 0, 10, text1)
     disp:drawStr( 0, 26, text2)
     disp:drawStr( 0, 36, text3)
     disp:drawStr( 0, 46, text4)
     disp:drawStr( 0, 56, text5)

    
end

function dispDown(text1,text2,text3,text4,text5)
     disp:firstPage()
     repeat
        disp:drawTriangle(84,16, 124,16, 104,56);
        draw(text1,text2,text3,text4,text5)
     until disp:nextPage() == false
end

function dispUp(text1,text2,text3,text4,text5)
     disp:firstPage()
     repeat
        disp:drawTriangle(104,16, 124,56, 84,56);
        draw(text1,text2,text3,text4,text5)
     until disp:nextPage() == false
end

function carre(text1,text2,text3,text4,text5)
     disp:firstPage()
     repeat
        disp:drawBox(88,16,40,40);
        draw(text1,text2,text3,text4,text5)
     until disp:nextPage() == false
  
end

function write(text1,text2,text3,text4,text5)
     disp:firstPage()
     repeat
     draw(text1,text2,text3,text4,text5)
     until disp:nextPage() == false
end

init_i2c_display();
--init_spi_display()

