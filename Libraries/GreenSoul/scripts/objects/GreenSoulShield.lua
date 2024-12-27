local GreenSoulShield, super = Class(Object)

function GreenSoulShield:init(x, y, shield_texture_path)
    super:init(self, x, y)

    self:setSprite(shield_texture_path)
    self:setHitbox(0, 0, self.width, self.height)
end

function GreenSoulShield:onAddToStage(stage)
    Game.battle.soul:setExactPosition(320, 172)
end

function GreenSoulShield:onBlock(proj, blockOnLastMoment)
    if blockOnLastMoment then
        Assets.playSound("bell_bounce_short")
        if self.parent.blockOnLastMomentTP == nil then
            Game:giveTension(proj.tp*2)
        else
            Game:giveTension(self.parent.blockOnLastMomentTP)
        end
        self.parent:flash()
        self:flash()
    else
        Assets.playSound("bell", 0.6)
        if self.parent.blockTP == nil then
            Game:giveTension(proj.tp)
        else
            Game:giveTension(self.parent.blockTP)
        end
    end

    if self.parent.hit_shield_texture == true then
        self:setSprite(self.parent.shield_texture_path.."_hit")
        Game.battle.timer:after(0.1, function(wait)
            self:setSprite(self.parent.shield_texture_path)
        end)
    end
end

function GreenSoulShield:flash()
    local flash = FlashFade(self.sprite.texture, 0, 0)
    flash.layer = 100
    self:addChild(flash)
    return flash
end

function GreenSoulShield:setSprite(sprite)
    if self.sprite then self.sprite:remove() end
    self.sprite = Sprite(sprite)

    self:addChild(self.sprite)
    self:setOrigin(0.5, 0.5)
    self:setSize(self.sprite:getSize())

    if self.parent and sprite ~= self.parent.shield_texture_path.."_hit" then
        self.parent.shield_texture_path = sprite
    end
end

function GreenSoulShield:setSpriteAndAdaptArena(sprite)
    self:setSprite(sprite)
	Game.battle.arena:setSize(self.width, self.height) -- Sets the arena to fit size with the shield, need testing though
end

function GreenSoulShield:setScaleAndAdaptArena(width, height)
    self:setScale(width, height)
	Game.battle.arena:setSize(self.width*width, self.height*height) -- Sets the arena to fit size with the shield, need testing though
end

return GreenSoulShield