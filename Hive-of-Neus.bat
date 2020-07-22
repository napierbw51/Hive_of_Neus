@echo off
title The Hive of Neus
color 1B
if "%1" neq "" ( goto %1)

:Menu
cls
echo.
echo 888  888d8b                                   q8Y    888888     888                  Y8888P
echo 888  888Y8P                                  q88     888888     888                 d88b d88P
echo 888  888                                    q8b      888 888    888                 Y88b.
echo 88888888888888  888 .d88b.      Y88888P  888888888   888  888   888 .d88b. 888   888 Y888b.
echo 888  888888888  888d8P  Y8b   d88P   Y88b888888888   888   888  888d8P  Y8b888   888    Y88b.
echo 888  888888Y88  88P88888888   888     888   888      888    888 88888888888888   888      888
echo 888  888888 Y8bd8P Y8b.       Y88b   d88P   888      888     888888Y8b.    888   888Y88b d88P
echo 888  888888  Y88P   'Y8888      Y88888P     888      888      88888 'Y8888 888888888 Y8888P
echo.
echo You must enter 1, 2, 3, or 4.
echo.
echo 1. New Game
echo 2. Load Game
echo 3. Credits
echo 4. Exit
set /p answer=Type the number of your option and press enter : 
if %answer%==1 goto New_Game
if %answer%==2 goto Load_Game
if %answer%==3 goto Credits
if %answer%==4 goto Exit
else goto Menu

:Exit
cls
echo Thanks for playing!
pause
exit /b

:Credits
cls
echo Credits
echo.
echo Thank you for playing The Hive of Neus!
echo Game created by Benjamin Napier.
pause
goto Menu

:New_Game
cls
echo Are you sure you would like to start a new game?
echo This will erase any previous saved game data.
echo.
echo 1. Yes, start new game
echo 2. No, back to the menu
set /p answer=Type the number of your option and press enter : 
if %answer%==1 goto Start_1
if %answer%==2 goto Menu
else goto New_Game

:Start_1
cls
SET /A player_health = 100
SET /A player_attack = 5
SET /A battles_won = 0
SET /A health_potions = 1
echo Health: %player_health%     Attack: %player_attack%
echo Health Potions: %health_potions%
(
	echo %player_health%
	echo %player_attack%
    echo %battles_won%
    echo %health_potions%
) > savegame.sav
echo.
echo You find yourself outside of the Hive of Neus, a cavern of dark treachery from which beasts emerge and terrorize the surrounding villages.
echo You have been tasked with getting to the bottom of the cavern and defeating the hive mind which is controlling the beasts.
echo In order to accomplish your task you have been armed with a crudely crafted spear and a health potion.
echo.
pause
goto Load_Game

:Load_Game
cls
(
	set /p player_health=
	set /p player_attack=
    set /p battles_won=
    set /p health_potions =
) < savegame.sav 
echo Health: %player_health%     Attack: %player_attack%
echo Health Potions: %health_potions%
echo.
echo Continue your adventure.
echo.
pause
if %battles_won% GEQ 5 goto Final_Battle
set /a num=%random% %%2 +1
if %num%==1 goto Event_1
if %num%==2 goto Event_2
else goto Menu

:Event_1
SET /A goblin_health = 50
SET /A goblin_attack = 3
goto Event_1_1
:Event_1_1
set /a attackNum1=%random% %%3 +1
SET /A player_damage=%player_attack%+%attackNum1%
set /a attackNum2=%random% %%3 +1
set /A goblin_damage=%goblin_attack%+%attackNum2%
set /a player_defend=%player_damage% - 2
set /a goblin_defend=%goblin_damage% - 3
SET /A potionNum1=%random% %%3 +1
set /a potion_heal=%potionNum1%+15
cls
echo Health: %player_health%     Attack: %player_attack%
echo Health Potions: %health_potions%
echo.
echo As you enter a dark room of the Hive, one goblin warrior emerges with club raised to fight.
echo Goblin Health: %goblin_health%     Goblin Attack: %goblin_attack%
echo.
echo 1. Attack with spear.
echo 2. Defend with spear.
if %health_potions% GEQ 1 echo 3. Drink health potion.
set /p answer=Type the number of your option and press enter : 
if %answer%==1 (
    SET /A goblin_health -= %player_damage%
    SET /A player_health -= %goblin_damage%
    echo.
    echo You stab the goblin and it strikes back!
    echo The goblin takes %player_damage% damage!
    echo You take %goblin_damage% damage!
    pause
)
if %answer%==2 (
    SET /A goblin_health -= %player_defend%
    SET /A player_health -= %goblin_defend%
    echo.
    echo You hold your spear out and the goblin scrapes it as it rushes to club you.
    echo The goblin takes %player_defend% damage!
    echo You take %goblin_defend% damage!
    pause
)
if %answer%==3 (
    if %health_potions% GEQ 1 (
        SET /A player_health += %potion_heal%
        set /a player_health -= %goblin_damage%
        SET /A health_potions -= 1
        echo.
        echo You chug a potion from your inventory and gain %potion_heal% health.
        echo The goblin clubs you and you take %goblin_damage% damage!
    )
    if %health_potions% LEQ 0 (
        echo.
        echo You have no health potions.
        pause
        goto Event_1_1
    )
    pause
)
if %goblin_health% LEQ 0 (
    SET /A battles_won = %battles_won% + 1
    (
	    echo %player_health%
	    echo %player_attack%
        echo %battles_won%
        echo %health_potions%
    ) > savegame.sav

    if %battles_won% GEQ 5 (
        goto Final_Battle
    )
    goto Random_Event_1
)
if %player_health% LEQ 0 (
    goto Credits
)
goto Event_1_1

:Event_2
cls
echo You walk into a dimly lit room with stone floors and walls.
echo ^On the north wall there is a drawing of a dragon etched into the stone.
echo.
echo                      ^/^\         ^/^\^_^_
echo                    ^/^/ ^\       ^(  ^0 ^)^_^_^_^_^_^/^\            ^_^_
echo                   ^/^/ ^\ ^\     ^(^v^v          ^o^|          ^/^^^v^\
echo                 ^/^/    ^\ ^\   ^(^v^v^v^v  ^_^_^_^-^-^-^-^-^^        ^/^^^^^/^\^v^v^\
echo               ^/^/  ^/     ^\ ^\ ^|^v^v^v^v^v^/               ^/^^^^^/    ^\^v^\
echo              ^/^/  ^/       ^(^\^\^/^v^v^v^v^/              ^/^^^^^/       ^\^v^\
echo             ^/^/  ^/  ^/  ^\ ^(  ^/^v^v^v^v^/              ^/^^^^^/^-^-^-^(     ^\^v^\
echo            ^/^/  ^/  ^/    ^\^( ^/^v^v^v^v^/^-^-^-^-^(^O        ^/^^^^^/           ^\^v^\
echo           ^/^/  ^/  ^/  ^\  ^(^/^v^v^v^v^/               ^/^^^^^/             ^\^v^|
echo         ^/^/  ^/  ^/    ^\^( ^v^v^v^v^/                ^/^^^^^/               ^|^|
echo        ^/^/  ^/  ^/    ^(  ^v^v^v^v^/                 ^|^^^^^|              ^/^/
echo       ^/^/  ^/ ^/    ^(  ^|^v^v^v^v^|                  ^/^^^^^/            ^/^/
echo      ^/^/  ^/ ^/   ^(    ^\^v^v^v^v^v^\          ^)^-^-^-^-^-^/^^^^^/           ^/^/
echo     ^/^/ ^/ ^/ ^(          ^\^v^v^v^v^v^\            ^/^^^^^^^/          ^/^/
echo    ^/^/^/ ^/^(               ^\^v^v^v^v^v^\        ^/^^^^^^^^^/          ^/^/
echo   ^/^/^/^(              ^)^-^-^-^-^-^\^v^v^v^v^v^\    ^/^^^^^^^^^/^-^-^-^-^-^(      ^\^\
echo  ^/^/^(                        ^\^v^v^v^v^v^\^/^^^^^^^^^/               ^\^\
echo ^/^(                            ^\^v^v^v^v^^^^^^^/                 ^/^/
echo                                 ^\^v^v^^^/         ^/        ^/^/
echo                                              ^/^<^_^_^_^_^_^_^/^/
echo                                             ^<^<^<^-^-^-^-^-^-^/
echo                                              ^\^<
echo                                               ^\
echo.
rem Art taken from: https://www.asciiart.eu/mythology/dragons, Escape characters added here
pause
cls
echo As you stare at the drawing your ears suddenly are filled with the sound of buzzing.
echo From the cave entrance two giant hornets appear!
echo.
echo                  ^_  ^_
echo                ^| ^)^/ ^)
echo             ^\^\ ^|^/^/^,^' ^_^_
echo             ^(^"^)^(^_^)^-^"^(^)^)^)^=^-
echo                ^(^\^\
echo.
echo.
echo                             ^_  ^_
echo                           ^| ^)^/ ^)
echo                        ^\^\ ^|^/^/^,^' ^_^_
echo                        ^(^"^)^(^_^)^-^"^(^)^)^)^=^-
echo                           ^(^\^\
echo.
rem Art taken from: https://www.asciiart.eu/animals/insects/bees, Escape characters added here
pause
goto Event_2_1
:Event_2_1
cls
echo Health: %player_health%     Attack: %player_attack%
echo Health Potions: %health_potions%
echo.
echo The giant hornets you.
echo.
echo 1. Stay and fight.
echo 2. Run deeper into the cave.
if %health_potions% GEQ 1 echo 3. Drink health potion.
set /p answer=Type the number of your option and press enter : 
if %answer%==1 (
    cls
    SET /A player_health -= 4
    echo Health: %player_health%     Attack: %player_attack%
    echo Health Potions: %health_potions%
    echo.
    echo As you turn to fight the hornets they collide with you at full force and shove you deeper into the cave.
    echo You fall through a tunnel and the entrance shuts behind you.
    echo.
    pause
    (
	    echo %player_health%
	    echo %player_attack%
        echo %battles_won%
        echo %health_potions%
    ) > savegame.sav
    goto Random_Event_1
)
if %answer%==2 (
    cls
    echo Health: %player_health%     Attack: %player_attack%
    echo Health Potions: %health_potions%
    echo.
    echo You run deeper into the cavern through a small entrance that shuts behind you as soon as you enter the next room.
    echo You cannot escape the cavern the way you entered
    echo.
    pause
    goto Random_Event_1
)
if %answer%==3 (
    if %health_potions% GEQ 1 (
        cls
        SET /A player_health += %potion_heal%
        SET /A health_potions -= 1
        echo Health: %player_health%     Attack: %player_attack%
        echo Health Potions: %health_potions%
        echo.
        echo You chug a potion from your inventory and gain %potion_heal% health.
        echo.
        pause
        (
	        echo %player_health%
	        echo %player_attack%
            echo %battles_won%
            echo %health_potions%
        ) > savegame.sav
        goto Random_Event_1
    )
    if %health_potions% LEQ 0 (
        cls
        echo Health: %player_health%     Attack: %player_attack%
        echo Health Potions: %health_potions%
        echo.
        echo You have no health potions.
        echo.
        pause
        goto Event_2_1 
    )
)
pause
goto Event_2_1

:Random_Event_1
cls
echo Health: %player_health%     Attack: %player_attack%
echo Health Potions: %health_potions%
echo.
echo In the entrance of the room there is a sword laying on the ground.
echo In your head you hear a high pitched voice say "I see we have an intruder to our hive. You will pay with your life but we will at least make it fun."
echo.
echo ^.^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^|^_^.^_^.^_^.^_^.^_^.^_^.^_^.^_^.^_^.^_^.
echo  ^\^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^|^_^#^_^#^_^#^_^#^_^#^_^#^_^#^_^#^_^#^_^|
echo                                                        ^l
echo.
pause
goto Menu

:Final_Battle
cls
echo Final_Battle
pause
goto Victory

:Victory
cls
echo Victory
pause
goto Menu