-- format is ffaStartPoints[numAllyTeamIDs][startPointNum] = {x,z}
-- initial_spawn will take care of where to place teamIDs about the allyTeamID start point
-- initial_spawn will count how many allyTeamIDs are going spawn units 
-- and will randomly assign each allyTeamID to one of the startpoints in ffaStartPoints[numAllyTeamIDs]

include('luarules/configs/startpoints.lua') --loads the startpoints table, format is startpoints[i]={x,z}

ffaStartPointsAll = { --ffaStartPointsAll[#allyteams][id] = {table of keys of startpoints table}
	[1] = {
		{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13},{14},{15},{16},
	},
	
	[2] = {
		{1,2},
		{10,11},
		{10,1},
		{6,12},
		{2,7},
		{9,5},
		{13,14},
		{1,14},
		{13,14},
		{1,10},
		{4,10},
		{4,13},
		{2,8},
		{3,6},
	},

	[3] = {
		{1,2,3},
		{12,3,14},
		{10,6,1},
		{4,6,13},
		{5,9,16},
		{7,11,2},
		{8,6,5},
		{15,7,3},
		{2,11,12},
		{1,3,4},
		{1,6,4},
		{8,2,7},
		{8,11,7},
		{4,3,7},
		{4,11,7},
	},

	[4] = {
		{1,2,3,4},
		{12,13,14,3},
		{10,6,12,11},
		{2,4,7,8},
		{2,11,12,4},
		{12,14,6,8},
		{1,13,2,14},
		{7,8,6,15},
		{3,12,15,6},
		{1,3,2,10},
		{1,3,6,10},
	},
	
	[5] = {
		{1,2,3,4,5},
		{7,8,6,5,4},
		{11,1,16,2,10},
		{12,3,13,4,6},
		{10,14,9,8,7},
		{6,10,8,1,5},
		{10,5,2,6,8},
		{7,11,16,14,10},
	},
	
	[6] = {
		{7,3,6,12,15,14},
		{8,11,5,12,2,6},
		{1,8,6,14,10,12},
		{13,11,6,10,14,13},
		{2,4,16,11,1,12},
		{4,5,6,3,7,13},
		{10,2,5,7,13,3},
		{10,15,2,16,11,12},
	},
	
	[7] = {
		{1,12,11,16,6,10,14},
		{10,14,5,6,7,3,13},
		{10,15,2,16,11,13,7},
		{1,12,8,16,15,6,10},
		{10,14,5,9,3,13,7},
		{4,14,9,6,16,1,13},
		{13,8,5,12,14,6,4},
	},

	[8] = {
		{1,2,3,4,15,6,7,8},
		{10,14,6,5,3,8,13,7},
		{1,13,11,3,12,5,14,2},
		{4,10,2,8,7,12,8,16},
		{4,15,2,9,12,7,8,3},
		{12,1,13,5,3,11,2,14},
	},
	
	[9] = {
		{1,2,3,4,5,9,10,7,8},
		{1,7,8,16,5,10,4,2,6},
		{7,13,8,5,3,9,10,4,14},
		{8,3,1,7,5,15,2,9,14},
		{5,15,2,6,16,8,13,1,7},
	},
	
	[10] = {
		{4,14,15,6,9,16,8,13,7,12},
		{1,7,8,3,5,9,10,4,2,14},
		{10,4,14,15,9,16,8,13,7,1},
	},
	
	[11] = {
		{10,4,15,2,9,5,12,7,13,8,3},
		{10,4,15,14,8,11,9,16,1,7,12},
		{11,13,7,5,10,4,14,6,9,16,8},
	},
	
	[12] = {
		{1,2,3,4,5,6,8,10,11,12,13,15},
		{1,2,3,4,5,6,7,8,9,10,13,14},
		{2,4,5,6,7,8,10,11,12,13,14,16},
		{1,2,3,4,8,9,11,12,13,14,15,16},
	},
	
	[13] = {
		{1,2,3,4,5,6,7,8,9,10,12,13,14},
		{2,3,4,5,7,8,9,10,11,12,13,14,16},
		{1,2,3,4,6,7,8,9,10,11,13,14,15},
		{1,3,4,5,6,9,10,11,12,13,14,15,16},
		{1,2,3,4,7,9,10,11,12,13,14,15,16},
	},
	
	[14] = {
		{1,2,3,4,5,6,7,8,9,10,11,12,13,14},
		{1,2,3,4,6,7,8,9,10,11,12,13,14,15},
		{1,2,3,4,5,6,7,8,9,10,11,12,13,15},
		{1,2,3,4,6,7,8,9,10,11,13,14,15,16},
	},
	
	[15] = {
		{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15},
		{1,2,3,4,5,6,7,8,10,11,12,13,14,15,16},
		{1,2,3,4,6,7,8,9,10,11,12,13,14,15,16},
	},
	
	[16] = {
		{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16},
	},
}

-- check that each of the above entries has the right length table
--[[
for i=1,16 do
	for j,v in pairs(ffaStartPointsAll[i]) do
		if #v ~= i then
			Spring.Echo("Error:", i,j)
		end
	end
end
]]

-- now construct ffa startpoints by randomly picking one element from each of the subtables of ffaStartPointsAll
-- and mapping that to a set of startpoints using the startpoints table
ffaStartPoints  = {}

for i=1,16 do
	local n = math.random(#(ffaStartPointsAll[i]))
	ffaStartPoints[i] = {}
	for j = 1,i do
		--Spring.Echo(i,n,j)
		local id = ffaStartPointsAll[i][n][j] 
		local sx = startpoints[id].x
		local sz = startpoints[id].z
		--Spring.Echo(sx,sz)
		ffaStartPoints[i][j] = {x=sx,z=sz} 
	end
end