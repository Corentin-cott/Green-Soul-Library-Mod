This library gives you the possibility to use the green soul of Undertale!
I tried to make it as customizable as possible, but as it's my first one, there are certainly some defaults, that's why I'm taking all feedback!
Here is a brief documentation below.

-- Short Documentation :
- GreenSoul (Game.battle.soul) :
Variables :
hit_shield_texture -- If the shield should change texture when hit
diagonal_dir -- Enables 8 diagonal shield direction
blockTP -- Tension earned on any block. If nil, takes the tension from the projectile.
blockOnLastMoment -- Enables the tp boost when a projectile is stopped near the soul.
tolerance -- In pixel, the distance from the soul at which the TP boost is given.
blockOnLastMomentTension -- Tension earned on any block. If nil, takes the tension from the projectile multiplied by 2.

Function :
setCircle(circle_texture_path)
flash(shield_flash) -- If (shield_flash) is true, the soul's shield will also flash.
setFacing(facing) -- (facing) is the direction to face. Can be "top", "right", "bottom", "left", "top-right", "bottom-right", "bottom-left", "top-left".
 
- GreenSoulShield (Game.battle.soul.shield) :
Function :
flash()
setSprite(sprite) -- Change the sprite of the shield. Won't adapt the arena tho, so use setSpriteAndAdaptArena().
setSpriteAndAdaptArena(sprite, keep_anim) -- Same as setSprite,² but adapt the arena.
setScaleAndAdaptArena(width, height) -- Same as setScale for classic object, but adapt the arena.

- spear (Bullet):
Variables :
from -- From where the projectile come from. Should'nt be changed.
highlight -- If the projectile should highlight or not.
sprite_path -- Path to the sprite of the projectile
sprite_highlight_path -- Path to the highlight sprite of the projectile. By default : sprite_path + "_highlight"
distance -- The distance in pixel between the soul and the projectile.

Function :
spawnBullet("spear", from, speed, sprite_path, highlight)