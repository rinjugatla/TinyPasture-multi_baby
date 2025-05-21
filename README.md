# Tiny Pasture twins and triplets mod

[日本語説明書](https://github.com/rinjugatla/TinyPasture-multi_baby/blob/main/README-ja.md)

## Tiny Pasture

[Tiny Pasture](https://store.steampowered.com/app/3167550/_/) is a game available on Steam.

## Install the mod

You can install it from [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3485188531).

## Features of the mod

Adds the ability to produce twins or triplets with a probability when breeding in the Mystic Grass Curtain.

The performance of the first litter will be determined by parent + parent as in the vanilla game.
The second and third animals, if born, will have random performance.

Please create an empty slot in the farm and wait for the children.

## MOD settings

By default, children are born with the following probabilities.

| Item      | Probability |
| --------- | ----------: |
| 1 animal  |         85% |
| 2 animals |         10% |
| 3 animals |          5% |

You can change the probability by changing the settings.
If you start the game once with the mod installed, the default settings file will be generated as follows.

```text
C:\Users\%username%\AppData\Roaming\TinyPasture\mod_configs\rin_jugatla-multi_baby
```

Copy `default.json` and rename it to `custom.json`.
The configuration is written in json format.

- Default.

```json
{ 
 "create_baby_probability": { 
 "double": 10, 
 "single": 85, 
 "triple": 5 
 } 
} 
```

- Example of Change

Here is the json for the following changes.

| item      | probability |
| --------- | ----------: |
| 1 animal  |         50% |
| 2 animals |         40% |
| 3 animals |         10% |

```json
{ 
 "create_baby_probability": { 
 "double": 40, 
 "single": 50, 
 "triple": 10 
 } 
} 
```

## Guide to Modding

[Introduction to Godot Modding](https://zenn.dev/rinjugatla/articles/92907e2c033c2f)
