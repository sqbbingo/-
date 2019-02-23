function isConnect()
    ip, _, _ = wifi.sta.getip()
    if ip ~= nil then
        print(ip)
        return true
    else
        print("without ip:time_get_7")
        return false
    end
end

function refreshTime()
    sec,usec,rate = rtctime.get()
    sys_time = rtctime.epoch2cal(sec+(8*60*60),usec,rate)
    sys_time_year = sys_time["year"]
    sys_time_mon = sys_time["mon"]
    sys_time_day = sys_time["day"]
    sys_time_hour = sys_time["hour"]
    sys_time_min = sys_time["min"]
--    print(sys_time_hour,sys_time_min)
--[[    print(string.format("%04d/%02d/%02d %02d:%02d:%02d", 
                        time["year"], 
                        time["mon"], 
                        time["day"], 
                        time["hour"], 
                        time["min"], 
                        time["sec"]))--]]
end
stime_timer = tmr.create()
tmr.alarm(stime_timer, 1000, tmr.ALARM_AUTO, function() 
    if isConnect() == true then
        tmr.stop(stime_timer)
        sntp.sync("120.24.166.46", 
            function()
                print("sync succeeded")
                tmr.alarm(stime_timer, 1000, tmr.ALARM_AUTO, refreshTime)
            end,
            function(index)
                print("failed : "..index)
            end
        )
    end
end)
