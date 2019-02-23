mq1:on("message", function(client, topic, data)
    print(topic .. ": " .. data)
    if string.find(topic,"/water/on") then --rgb_led control form wx
        water_on()
    elseif string.find(topic,"/water/off") then --/room1/led1 control form wx
        water_off()
    elseif string.find(topic,"$creq") then
        if string.find(data,"ledR:") then
            local i = string.byte(data,string.find(data,"}")+1)-48
            gpio.write(wifi_led_pin,i)
        end
        if string.find(data,"ledB:") then
            
        end
        if string.find(data,"ws2812_") then
            
        end
    end
end)