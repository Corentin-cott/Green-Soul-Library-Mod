local Spear, super = Class(Bullet)

function Spear:init(from, speed, sprite_path, highlight)
    super:init(self, 0, 0)

    self.alpha = 0
    self:fadeTo(1)
    self:setScale(1, 1)
    self:setHitbox(0, 0, self.width, self.height)
    
    self.tp = 1
    self.remove_offscreen = false

    self.from = from -- Up, Up-Right, Right, Bottom-Right, Bottom, Bottom-Left, Left, or Up-Left.

    self.physics.match_rotation = true
    if speed == nil then
        self.physics.speed = 2
    else
        self.physics.speed = -speed -- *sight*
    end

    if sprite_path == nil then
        self.sprite_path = "GreenSoul/Projectile/default_spear" -- Default spear sprite
        self:setSprite(self.sprite_path)
    else
        self.sprite_path = sprite_path
    end
    self.sprite_highlight_path = self.sprite_path.."_highlight" -- Sets the sprite path used for the highlight projectile. Only used if "self.highlight" is true. 

    if highlight == nil then
        self.highlight = true
    else
        self.highlight = highlight -- If the projectile should change sprite when it's the first of the Wave.bullets table (and thus the first to have spawned)
    end
    
    -- Move the projectile to the defined origin and adapt its rotation
    if self.from == "top" then
        self:move(Game.battle.soul.x, Game.battle.soul.y - 335)
        self.rotation = math.rad(270)
    elseif self.from == "right" then
        self:move(Game.battle.soul.x + 335, Game.battle.soul.y)
        self.rotation = math.rad(0)
    elseif self.from == "bottom" then
        self:move(Game.battle.soul.x, Game.battle.soul.y + 335)
        self.rotation = math.rad(90)
    elseif self.from == "left" then
        self:move(Game.battle.soul.x - 335, Game.battle.soul.y)
        self.rotation = math.rad(180)
    elseif self.from == "top-right" then
        self:move(Game.battle.soul.x + 335/1.415, Game.battle.soul.y - 335/1.415)
        self.rotation = math.rad(315)
    elseif self.from == "top-left" then
        self:move(Game.battle.soul.x - 335/1.415, Game.battle.soul.y - 335/1.415)
        self.rotation = math.rad(225)
    elseif self.from == "bottom-right" then
        self:move(Game.battle.soul.x + 335/1.415, Game.battle.soul.y + 335/1.415)
        self.rotation = math.rad(45)
    elseif self.from == "bottom-left" then
        self:move(Game.battle.soul.x - 335/1.415, Game.battle.soul.y + 335/1.415)
        self.rotation = math.rad(135)
    end
end

function Spear:onBlock(blockOnLastMoment)
    self:remove()
end

function Spear:update()
    super:update(self)
    self.distance = Utils.dist(Game.battle.soul.x, Game.battle.soul.y, self.x, self.y)

    -- Checks the collision with the shield and if the player looks in the direction of the projectile
    if self:collidesWith(Game.battle.soul.shield) and self.from == Game.battle.soul.facing then
        if Game.battle.soul.blockOnLastMoment and self.distance < Game.battle.soul.tolerance then
            Game.battle.soul.shield:onBlock(self, true)
            self:onBlock(true)
        else
            Game.battle.soul.shield:onBlock(self, false)
            self:onBlock(false)
        end
    end

    if self.highlight and self == self.wave.bullets[1] then
        self:setSprite(self.sprite_highlight_path)
    end
end

return Spear