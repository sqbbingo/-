con_pin = 3

gpio.mode(con_pin,gpio.OUTPUT)
gpio.write(con_pin,gpio.HIGH)

water_stat_timer = tmr.create()         --  1-3
tmr.register(water_stat_timer,60*60*1000,tmr.ALARM_SEMI,function()
    water_off()
end)

function water_on()
    print("7c keyPinState:",gpio.read(keyPin))
    gpio.mode(con_pin,gpio.OUTPUT)
    gpio.write(con_pin,gpio.LOW)        --  1-1
    tmr.start(water_stat_timer)         --  1-3
    print("on")
    upload_data()
    gpio.trig(keyPin)
    tmr.create():alarm(5000, tmr.ALARM_SINGLE, function()
        if(gpio.read(keyPin) == 0)then
            gpio.trig(keyPin,"up", keyControlup)
        else
            gpio.trig(keyPin,"down", keyControldown)
        end
    end)
end

function water_off()
    print("15c keyPinState:",gpio.read(keyPin))
    gpio.mode(con_pin,gpio.OUTPUT)
    gpio.write(con_pin,gpio.HIGH)           --  2-2
    stat_fun(tmr.now(water_stat_timer))     --  2-3
    tmr.stop(water_stat_timer)      --  2-1
    print("off")
    upload_data()
    gpio.trig(keyPin)
    tmr.create():alarm(5000, tmr.ALARM_SINGLE, function()
        if(gpio.read(keyPin) == 0)then
            gpio.trig(keyPin,"up", keyControlup)
        else
            gpio.trig(keyPin,"down", keyControldown)
        end
    end)
end

function water_state()
    return gpio.read(con_pin)
end

