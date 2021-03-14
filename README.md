# UT2003-CaptureTheBeer

An excelent beer game. It's based on CTF, but instead of flags you have to capture a beer crate. But time is important, while you are carrying the crate you will consume the beer until you're out. Ofcourse the beer will have it's effect on you.

Finalist in the Make Something Unreal Contest.

In Capture The Beer (CTB) your main objective is to steal as much beer from the enemies as possibles. Every team has a full beer crate at their base, it's your goal to steal the beer crate of the opposing team and bring it back to your base. Ofcourse it's tempting to drink beer while you are carrying the crate, so you have to bring it back as fast as you can before you empty the crate.
Just like in in real life, drinking beer will have it's effect on you, so don't drink to much or participating in the game will become difficult.

## Rules

Scoring in CTB is much like CTF, however there are a few important diffirences. In CTB the team score is depended on the number of beer bottles left in the crate. When you pick up the enemy crate you will start consuming it's beer, every once in a while you will open another beer. When the crate runs out of beer it will be returned to it's base. When you bring back the enemy crate to your base the number of bottles left will be added to the team score.
There is a limited number of beer bottles you can consume. When you reach the maximum you can no longer carry the crate and you will have to drop it. When you are not carrying a crate you will slowly clear up. So after a while you will be able to carry a crate again.

## Installation
Make sure the following files are in the right place:

| Directory | File |
|---|---|
|StaticMeshes/ |	CTBmesh.usx|
|System/ 	|CaptureTheBeer.u|
||CaptureTheBeer.int|
|Textures/ |	CTBtex.utx|

Next add the CaptureTheBeer.u file to the server packages list in your server configuration (UT2003.ini):

```
[Engine.GameEngine]
ServerPackages=CaptureTheBeer
```
