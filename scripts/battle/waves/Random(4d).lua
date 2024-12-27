local Nothing, super = Class(Wave)

function Nothing:onStart()
    Game.battle:swapSoul(GreenSoul(x, y, "default", "default", true))
    Game.battle.soul.diagonal_dir = false
    self.time = 16
    
    self.timer:after(0.5, function()
        local spear = self:spawnBullet("spear", "top", 8)
    end)
    self.timer:after(1, function()
        local spear = self:spawnBullet("spear", "right", 8)
    end)
    self.timer:after(1.5, function()
        local spear = self:spawnBullet("spear", "bottom", 8)
    end)
    self.timer:after(2, function()
        local spear = self:spawnBullet("spear", "left", 8)
    end)

    self.timer:after(3, function()
        self.timer:every(1/2.5, function()
            local from = Utils.pick({"top", "right", "bottom", "left"}) -- Possibilities
            local spear = self:spawnBullet("spear", from, 5)
        end)
    end)
end

return Nothing