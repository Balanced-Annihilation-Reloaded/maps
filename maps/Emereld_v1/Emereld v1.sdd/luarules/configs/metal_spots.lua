include('luarules/configs/startpoints.lua') 

local ffaStartPoints = GG.ffaStartPoints --set by game_initial_spawn (within BA)

-- metal spots that are not at startpoints
metal_spots = {
	{x = 2629, z = 6388},
	{x = 2822, z = 5514},
	{x = 4307, z = 8759},
	{x = 7121, z = 2273},
	{x = 5201, z = 4924},
	{x = 6061, z = 5197},
	{x = 8530, z = 4403},
	{x = 8588, z = 5126},
	{x = 6810, z = 8356},
	{x = 4715, z = 2535},
}

-- add mexes for start points
for i=1,#startpoints do
	-- is there an allyteam here?
	local occupied = false
	if ffaStartPoints then
		for j=1,#ffaStartPoints do
			if startpoints[i].x == ffaStartPoints[j].x and startpoints[i].z == ffaStartPoints[j].z then
				occupied = true
				break
			end
		end
	end
	
	-- if an allyteam is starting on this metal spot, place 3 mexes nearby, if not place one right on top 
	if occupied then
		local angle = math.random(360)/360*2*math.pi
		local theta = angle
		for j = 1,3 do
			theta = theta + 2 * math.pi / 3
			local sx = startpoints[i].x + 150 * math.cos(theta)
			local sz = startpoints[i].z + 150 * math.sin(theta)
			metal_spots[#metal_spots+1] = {x=sx,z=sz}
		end
	else
		metal_spots[#metal_spots+1] = {x=startpoints[i].x,z=startpoints[i].z}
	end
end

-- set metal output
for i=1,#metal_spots do
	if ffaStartPoints then
		metal_spots[i].metal = 2.0 + math.random(0,10)/150
	else
		metal_spots[i].metal = 4.0 + math.random(0,10)/100
	end
end

