mq1 = mqtt.Client(message.mqtt.deviceId, 120,message.mqtt.productId, message.mqtt.apiKey)

--mqttConnectMonTimer as a alarm check whether or not connect to mqtt server
mqttConnectMonTimer = tmr.create()
tmr.register(mqttConnectMonTimer,30 * 1000,tmr.ALARM_AUTO,function()
    if (mq1:publish("node_mm", "online", 0, 0) ~= true) then
        do_mqtt_connect()
        tmr.stop(mqttConnectMonTimer)
    end
end)
---------
function connect_success(client)
    tmr.start(mqttConnectMonTimer)   --start the alarm to check mqtt connect state,when connect to mqtt server success
    for k,v in pairs(message.mqtt.subscribe) do
        print(k,v)
        mq1:subscribe(v,0,function()
            print("subscreibe success:".. v)
        end)
    end
    connect_state.mqtt.state = 1
    dofile("time_get.lua")
    dofile("mqttReceive.lua")
    dofile("mqttSend.lua")
end

function handle_mqtt_error(client, reason) 
  tmr.create():alarm(10 * 1000, tmr.ALARM_SINGLE, do_mqtt_connect)
end

function do_mqtt_connect()
    connect_state.mqtt.state = 0
    print("connect to mqtt server: 30")
    mq1:connect("183.230.40.39", 6002,connect_success,handle_mqtt_error)
end
do_mqtt_connect()   --connect to mqtt first
