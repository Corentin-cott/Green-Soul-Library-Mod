return {
    susie_punch = function(cutscene, battler, enemy)
        -- Open textbox and wait for completion
        cutscene:text("* Susie threw a punch at\nthe dummy.")

        -- Hurt the target enemy
        Assets.playSound("damage")
        enemy:hurt(1, battler)
        enemy.color = {1, 0, 0}

        battler:setSprite("shock_right")

        -- Wait 1 second
        cutscene:wait(1)

        -- Susie text
        cutscene:text("* Uh...[next]", "shock", "susie")
        cutscene:text("* what did u just do ?", "face/angry_dummy", "dummy")

        if cutscene:getCharacter("ralsei") then
            -- Ralsei text, if he's in the party
            cutscene:text("* He seems angry...!", "shock_smile", "ralsei")
            cutscene:text("* I FEE-[next]", "shock_nervous", "susie")
        end
        
        cutscene:text("* u dead now[next]", "face/angry_dummy", "dummy")
        battler:explode()
        cutscene:wait(0.1)
        Game:gameOver(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
    end
}