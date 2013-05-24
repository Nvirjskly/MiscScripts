--(c) Nvirjskly 2013
--

if fs.exists("mobs.farm") then
	file = io.open("mobs.farm","r")
else
	file = io.open("mobs.farm","w")
	file:write("111_left Sample Mob")
	file:close()
	file = io.open("mobs.farm","r")
end

mobs = {}
for line in file:lines() do
	computer, side, mob = line:match '([^_]+)_(%S+)%s+(%w[%w%p%s]*)'
	table.insert(mobs,{computer,side,mob,true})
end

local monitor;

for i,side in ipairs(rs.getSides()) do
	ptype = peripheral.getType(side)
	if ptype == "monitor" then
		monitor = peripheral.wrap(side)
	elseif ptype == "modem" then
		rednet.open(side)
	end
end

turtlesOn = true;

monitor.clear()
monitor.setTextScale(2)
monitor.setTextColor(colors.cyan)
monitor.setBackgroundColor(colors.red)


maxL = 0
for i = 1, #mobs do
	l = string.len(mobs[i][3])
	if l > maxL then maxL=l end
end

--function printTurtles()
-- monitor.setCursorPos(35,13)
-- if turtlesOn then
--  monitor.setBackgroundColor(colors.lime)
-- else
--  monitor.setBackgroundColor(colors.red)
-- end
-- monitor.write("  ")
--end

function printMobs()
	for i = 1, #mobs do
		if not mobs[i][4] then
			monitor.setBackgroundColor(colors.lime)
			monitor.setTextColor(colors.magenta)
		else
			monitor.setBackgroundColor(colors.red)
			monitor.setTextColor(colors.cyan)
		end
		monitor.setCursorPos(1,i)
		l = string.len(mobs[i][3])
		monitor.write(mobs[i][3]..string.rep(' ',maxL-l))
	end
end
printMobs()
--printTurtles()
while 1 do 
	ev,b,x,y = os.pullEvent("monitor_touch")
	if mobs[y] and x<=maxL then 
		mobs[y][4]=(not mobs[y][4])
		message=textutils.serialize({mobs[y][2],mobs[y][4]}) 
		rednet.send(tonumber(mobs[y][1]),message)
	--elseif y==13 and x>=35 and x<=36 then
	--	turtlesOn=not turtlesOn
	--	rednet.send(263,tostring(turtlesOn))
	end
	printMobs()
	--printTurtles()
end