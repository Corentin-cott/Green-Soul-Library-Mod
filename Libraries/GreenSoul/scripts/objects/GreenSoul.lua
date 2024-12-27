local GreenSoul, super = Class(Soul)

function GreenSoul:init(x, y, shield_texture_path, circle_texture_path, flash)
    super:init(self, x, y)

    self.color = {0, 1, 0}
	self.facing = "top" -- Default facing when the soul is called | To change it inside a wave, you can use the setFacing(facing) function

	-- Green Circle Thing spawn (It's just a sprite)
	self:setCircle(circle_texture_path)

	-- Spawn shield object
	if shield_texture_path == nil or shield_texture_path == "default" then
		self.shield_texture_path = "GreenSoul/Shield/default_shield"
	elseif shield_texture_path ~= "none" then
		self.shield_texture_path = shield_texture_path
	end

	self.shield = Game.world:spawnObject(GreenSoulShield(0, 0, self.shield_texture_path))
	self:addChild(self.shield)

	-- Variable
	self.hit_shield_texture = true -- If the shield should change texture when hit
	self.diagonal_dir = true -- Enables 8 diagonal shield direction
	self.blockTP = nil -- Tension earned on any block. If nil, takes the tension from the projectile.

	self.blockOnLastMoment = true -- Enables the tp boost when a projectile is stopped near the soul.
	self.tolerance = 20 -- In pixel, the distance from the soul at which the TP boost is given.
	self.blockOnLastMomentTP = nil -- Tension earned on any block. If nil, takes the tension from the projectile multiplied by 2.

	Game.battle.arena:setSize(self.shield.width, self.shield.height) -- Sets the arena to fit size with the shield

	if flash then
		self:flash(true) -- True to make the shield flash too
	end
end

function GreenSoul:setCircle(circle_texture_path)
	if self.Circle then self.Circle:remove() end

	if circle_texture_path ~= "none" then
		if circle_texture_path == nil or circle_texture_path == "default" then
			self.circle_texture_path = "GreenSoul/Circle/default_green_circle"
		else
			self.circle_texture_path = circle_texture_path
		end
		self.Circle = Sprite(self.circle_texture_path, 0, 0)
		self.Circle:setOrigin(0.5, 0.5)
		self:addChild(self.Circle)
	end
end

function GreenSoul:doMovement()
	-- 4 direction input
	if Input.down("up") then
		self:setFacing("top")
	elseif Input.down("right") then
		self:setFacing("right")
	elseif Input.down("down") then
		self:setFacing("bottom")
	elseif Input.down("left") then
		self:setFacing("left")
	end
	
	-- 8 direction input
	if self.diagonal_dir then
		if Input.down("up") and Input.down("right") then
			self:setFacing("top-right")
		elseif Input.down("down") and Input.down("right") then
			self:setFacing("bottom-right")
		elseif Input.down("down") and Input.down("left") then
			self:setFacing("bottom-left")
		elseif Input.down("up") and Input.down("left") then
			self:setFacing("top-left")
		end
	end
end

function GreenSoul:setFacing(facing) -- facing can be "top", "right", "bottom", "left", "top-right", "bottom-right", "bottom-left", "top-left".
	self.facing = facing
	if facing == "top" then
		self.shield.rotation = math.rad(0)
	elseif facing == "right" then
		self.shield.rotation = math.rad(90)
	elseif facing == "bottom" then
		self.shield.rotation = math.rad(180)
	elseif facing == "left" then
		self.shield.rotation = math.rad(270)
	elseif facing == "top-right" then
		self.shield.rotation = math.rad(45)
	elseif facing == "bottom-right" then
		self.shield.rotation = math.rad(135)
	elseif facing == "bottom-left" then
		self.shield.rotation = math.rad(225)
	elseif facing == "top-left" then
		self.shield.rotation = math.rad(315)
	end
end

function GreenSoul:flash(shield_flash)
    local flash = FlashFade(self.sprite.texture, -self.width/2, -self.height/2)
    flash.layer = 100
    self:addChild(flash)

	if flash and self.shield then
		self.shield:flash()
	end

    return flash
end

function GreenSoul:onRemove(parent)
    super:onRemove(self, parent)
	if self.shield then self.shield:remove() end
	if self.circle then self.circle:remove() end
end

return GreenSoul