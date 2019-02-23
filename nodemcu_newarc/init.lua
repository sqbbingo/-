dofile("config_message.lua")    --get the glocal var of <<message>> and functon <<update_message()>> 
dofile("control.lua")
dofile("scan.lua")
dofile("wifi_connec.lua")   --make connect state var <<connect_state>>,monitoring wifi state and connect angin
dofile("mqtt_connect.lua")    --connect to mqtt breaker

--pin
--
--3     GPIO0   jidianqi
--4     GPIO2   OFF
