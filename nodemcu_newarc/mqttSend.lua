--seng nodemcu data flow states to onenet
function onenetstr(json)           
    buf = {}
    buf[0] = 0x03 -- Byte1 Type=3
    jsonlength = string.len(json)
    print("jsonlength:",jsonlength)
    buf[1] = bit.rshift(bit.band(jsonlength, 0xFF00), 8) 
    buf[2] = bit.band(jsonlength, 0xFF) + 1 
    local x1 = string.char(buf[0])
    print(x1)
    local x2 = string.char(buf[1])
    print(x2)
    local x3 = string.char(buf[2])
    print(x3)
    return x1..x2..x3..json.."\r"
    -- return pcall(string.char(buf[0])..string.char(buf[1])..string.char(buf[2])..json.."\r" error('error...')) 
end

--update the sensor's message
function upload_data()
    if(connect_state.mqtt.state == 1) then
        message.water.state = gpio.read(3)   
        ok, json = pcall(sjson.encode,message)
        if ok then
            file.open("message.config","w")       --update message.json's message
            file.write(json)
            file.close()
            -- mq1:publish("$dp",onenetstr(json), 0, 0)
            mq1:publish("$dp",onenetstr(json), 0, 0)
        else
            print("failed to encode json!")
        end
    end
end

--publish message
function publish(ftheme,fmessage)
    mq1:publish(ftheme,fmessage, 0, 0)
end

upload_data()
--check wifi state
mqttSendTimer = tmr.create()
tmr.register(mqttSendTimer,1000,tmr.ALARM_AUTO,function()
    if wifi.sta.getip() then
        upload_data()
        print("update message")
    end
end)
tmr.stop(mqttSendTimer)