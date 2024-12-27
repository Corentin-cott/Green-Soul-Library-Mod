local Nothing, super = Class(Wave)

function Nothing:onStart()
    Game.battle:swapSoul(GreenSoul(x, y, "GreenSoul/Shield/Axe/axe", "none", true))
    Game.battle.soul.shield:setScaleAndAdaptArena(2, 2)
    self.time = 16

    self.timer:every(1/1.5, function()
        local from = Utils.pick({"top", "right", "bottom", "left", "top-right", "top-left", "bottom-right", "bottom-left"})
        local shieldSprite = Utils.pick({"GreenSoul/Shield/default_shield", "GreenSoul/Shield/Axe/axe", "GreenSoul/Shield/Kris_Shield/shield", "GreenSoul/Shield/Ralsei_Blunt/blunt"})
        local circleSprite = Utils.pick({"default", "none"})

        local spear = self:spawnBullet(Utils.pick({"spear", "spear_explode"}), from, 8)

        Game.battle.soul.shield:setSprite(shieldSprite)
        if shieldSprite == "GreenSoul/Shield/Axe/axe" or shieldSprite == "GreenSoul/Shield/Ralsei_Blunt/blunt" then
            Game.battle.soul.shield:setScaleAndAdaptArena(2, 2)
        else
            Game.battle.soul.shield:setScaleAndAdaptArena(1, 1)
        end
    end)
end

return Nothing