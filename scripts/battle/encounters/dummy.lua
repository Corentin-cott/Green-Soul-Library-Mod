local Dummy, super = Class(Encounter)

function Dummy:init()
    super:init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* (Go into the ACT button to select a wave.)"

    -- Battle music ("battle" is rude buster)
    self.music = "Spear Of Justice"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("dummy")
end

return Dummy