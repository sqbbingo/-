keyTimerdown = tmr.create()
keyTimerup = tmr.create()
keyPin = 4
gpio.mode(keyPin, gpio.INT, gpio.PULLUP)

function keyControldown()
    print("7 keyPinState:",gpio.read(keyPin))
    gpio.trig(keyPin)
    tmr.alarm(keyTimerdown, 5000, tmr.ALARM_SINGLE, function()
        if(gpio.read(keyPin) == 0)then
            gpio.trig(keyPin,"up", keyControlup)
        else
            gpio.trig(keyPin,"down", keyControldown)
        end
    end)
    print("down")
    if (water_state() == 1) then            --change led2's state
        water_on()
    else
        water_off()
    end
end

function keyControlup()
    gpio.trig(keyPin)
    tmr.alarm(keyTimerup, 5000, tmr.ALARM_SINGLE, function()
        gpio.trig(keyPin,"down", keyControldown)
    end)
    print("up")
end

gpio.trig(keyPin, "down", keyControldown)