local Dummy, super = Class(EnemyBattler)

function Dummy:init()
    super:init(self)

    -- Enemy name
    self.name = "Dummy"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("dummy")

    -- Enemy health
    self.max_health = 450
    self.health = 450
    -- Enemy attack (determines bullet damage)
    self.attack = 4
    -- Enemy defense (usually 0)
    self.defense = 0
    -- Enemy reward
    self.money = 100

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 20

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "Random(8d)"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "..."
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 4 DF 0\n* Cotton heart and button eye\n* Looks just like a fluffy guy."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* The dummy gives you a scary\nwide smile.",
        "* This eye patched dummy is not referencing\nanything.",
        "[facec:angry_dummy]* You guys also smell fish\naround here?",
        "[facec:angry_dummy]* NGYAAAA"
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* The dummy looks like it's\nabout to enter his undying form."

    -- C-Stuff, Random(4d), Random(8d), NWave1, NWave2
    self:registerAct("Changing Stuff In Wave")
    self:registerAct("Random(4d)")
    self:registerAct("Random(8d)")
end

function Dummy:onAct(battler, name)
    if name == "Changing Stuff In Wave" then
        self:addMercy(25)
        self.waves = {"Stuff"}

        self.dialogue_override = "Okay you asked for it."
        return "* The Dummy smiles at you.[wait:5]\n* How Nice."
    elseif name == "Random(4d)" then
        self:addMercy(25)
        self.waves = {"Random(4d)"}

        self.dialogue_override = "Classic!!!!!!!"
        return "* Classic Undertale Green Soul."
    elseif name == "Random(8d)" then
        self:addMercy(25)
        self.waves = {"Random(8d)"}

        self.dialogue_override = "Watch!!!!!"
        return "* Here's a Wave with 8 directional input."
    elseif name == "Standard" then
        if battler.chara.id == "ralsei" then
            return "* Ralsei bowed politely.\n* The dummy doesn't care."
        elseif battler.chara.id == "susie" then
            Game.battle:startActCutscene("dummy", "susie_punch")
            return
        else
            -- Text for any other character (like Noelle)
            return "* "..battler.chara:getName().." straightened the\ndummy's hat."
        end
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super:onAct(self, battler, name)
end

return Dummy