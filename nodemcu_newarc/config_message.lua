--get the start message after sys get power and make the <<message> table to used
--check whether the message.config is existe
if file.exists("message.config") then
    print("Not the first time used")
else
    fw = file.open("message.config", "w")
    fd = file.open("message.json", "r")

    if fd then
        local result = fd:read()
        if fw then
            fw:write(result)
            fw:close()
            fw = file.open("message.config", "r")
            print(fw:read())
        end
    end
    fd:close()
    fw:close()
    fd = nil
    fw = nil
end
--make the global variable table of <<message>>
file.open("message.config","r")
message = sjson.decode(file.read()) -----here
file.close()

--the functon update the global variable message
function update_message()           --functon used by other
    local ok,json = pcall(sjson.encode,message)
    file.open("message.config","w")
    file.write(json)
    file.close()
end

