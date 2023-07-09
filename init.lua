--[[
    Minetest Random Teleport Mod
    Version: 2.0.0
    License: GNU Affero General Public License version 3 (AGPLv3)
]]--

local players = {}

-- Register the random teleport command "/rtp".
minetest.register_chatcommand("rtp", {
    description = "Random Teleport",
    privs = {
        interact = true,
    },
    func = function(name)players[name]
		if players[name] then
			return false, "Please wait a few seconds before using /rtp again."
		end
		local player = minetest.get_player_by_name(name)
		if not player then
			return false, "Please do not run this command in the console!"
		end
		local old_pos = player:get_pos()
		players[name] = true

		local x = math.random(-30000, 30000)
		local y = 20
		local z = math.random(-30000, 30000)
		local pos = {x=x,y=y,z=z}


		minetest.chat_send_player(name,"Teleporting...")
		player:set_pos(pos)

		local function loop(times)
			local blockstate = minetest.compare_block_status(pos, "loaded") or minetest.compare_block_status(pos, "active")
			if not blockstate then
				if times > 10 then
					players[name] = false
					player:set_pos(old_pos)
					return false, "Could not load mapblocks."
				end
				minetest.after(1,loop,times + 1)
			end
			local surface = minetest.find_node_near(pos, 30, "air")
			local node_top = minetest.get_node(vector.add(pos,{x=0,y=1,z=0}))
			local node_bottom = minetest.get_node(vector.add(pos,{x=0,y=-1,z=0}))
			local node_top_def = minetest.registered_nodes[node_top.name]
			local node_bottom_def = minetest.registered_nodes[node_bottom.name]
			if node_top_def.walkable or not node_bottom_def.walkable then


    end,
})
