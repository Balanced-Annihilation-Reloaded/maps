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
		{1,9},
		{2,8},
		{3,10},
		{1,10},
		{3,9},
		{13,14},
		{5,7},
		{4,6},
		{11,16},
		{12,15},
		{11,15},
		{12,16},
		{13,16},
		{11,14},
		{9,12},
		{1,15},
	},

	[3] = {
		{1,12,15},
		{1,12,16},
		{3,13,15},
		{3,8,15},
		{2,5,16},
		{14,11,10},
		{2,13,16},
		{10,14,12},
		{8,2,7},
		{8,2,5},
	},

	[4] = {
		{3,14,13,10},
		{1,11,16,9},
		{4,5,6,7},
		{1,12,9,15},
		{3,12,15,10},
		{2,8,12,15},
		{2,10,12,15},
		{14,13,11,16},
		{1,7,10,12},
		{5,1,10,15},
		{1,3,9,10},
		{11,12,15,16},
		{3,2,8,10},
	},
	
	[5] = {
		{1,11,13,16,7},
		{3,14,16,9,5},
		{1,15,12,8,4},
		{15,6,9,12,2},
		{12,9,16,14,3},
	},
	
	[6] = {
		{1,3,5,12,10,16},
		{16,15,2,3,12,13},
		{1,2,3,8,9,10},
		{2,8,5,7,11,16},
	},
	
	[7] = {
		{2,14,7,4,8,9,10},
		{1,2,3,5,6,8,13},
		{4,5,11,12,7,15,16},
		{6,7,15,16,4,11,12},
		{11,2,14,15,8,5,6},
	},

	[8] = {
		{1,3,12,5,9,10,7,15},
		{1,3,11,12,9,10,15,16},
		{1,13,11,12,14,15,16,10},
		{4,5,6,7,1,3,9,10},
	},
	
	[9] = {
		{1,3,11,12,9,10,15,16,6},
		{1,3,11,12,9,10,15,16,7},
		{1,2,3,8,9,10,12,5,7},
	},
	
	[10] = {
		{1,2,3,4,5,6,7,8,9,10},
		{1,3,14,15,16,9,10,13,11,12},
	},
	
	[11] = {
		{8,9,10,13,1,2,3,14,7,4,5},
		{11,12,4,5,6,7,16,15,9,10,2},
		{11,12,4,5,6,7,16,15,1,3,8},
		{14,7,15,12,5,13,6,8,10,1,3},
		{14,7,15,12,5,13,6,10,9,2,3},
	},
	
	[12] = {
		{1,2,3,7,15,16,5,11,12,8,9,10},
		{1,3,11,12,13,9,10,16,15,14,5,7},
		{1,3,11,12,13,9,10,16,15,14,4,6},
		{1,3,11,12,13,9,10,16,15,14,2,8},
	},
	
	[13] = {
		{1,3,11,12,13,9,10,16,15,14,5,7,4},
		{1,3,11,12,13,9,10,16,15,14,5,7,6},
		{1,3,11,12,13,9,10,16,15,14,5,4,6},
		{1,3,11,12,13,9,10,16,15,14,4,6,7},
	},
	
	[14] = {
		{1,2,3,8,9,10,7,15,16,6,4,5,11,12},
		{2,4,7,5,6,8,14,13,10,15,16,12,3,11},
		{1,3,11,12,13,9,10,16,15,14,4,6,7,5},
	},
	
	[15] = {
		{1,3,4,5,6,7,8,9,10,11,12,13,14,15,16},
		{1,2,3,4,5,6,7,9,10,11,12,13,14,15,16},
		{1,2,3,4,6,7,8,9,10,11,12,13,14,15,16},
		{1,2,3,4,5,7,8,9,10,11,12,13,14,15,16},
		{1,2,3,4,5,6,7,9,10,11,12,13,14,15,16},
		{1,2,3,5,6,7,8,9,10,11,12,13,14,15,16},
	},
	
	[16] = {
		{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16},
	},
}

-- check that each of the above entries has the right length table
--[[for i=1,16 do
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