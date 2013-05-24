cy = 1
sel = 1
while not (cy == 0) do
	cy = 0
	print("1")
	if turtle.detectDown() then
		turtle.up()
		cy=cy+1
	end
	while not turtle.getItemCount(sel) and not (sel == 16) do
		sel = sel+1
		turtle.select(sel)
	end
	if (sel == 16) and (turtle.getItemCount(sel) == 0) then
		os.shutDown()
	end
	turtle.placeDown()
	redstone.setOutput("bottom",true)
	sleep(5)
	redstone.setOutput("bottom",false)
	while turtle.down() do
		cy= cy-1
	end
end
os.shutDown()