# Tiny Pasture 双子三つ子MOD

English Readme

## Tiny Pasture

[Tiny Pasture](https://store.steampowered.com/app/3167550/_/)はSteamで配信されているゲームです。

## MODの導入

[Steamワークショップ](https://steamcommunity.com/sharedfiles/filedetails/?id=3485188531)から導入します。

## MODの機能

神秘の草カーテンで繁殖した際に確率で双子や三つ子を生む機能を追加します。

1匹目の性能はバニラのゲームと同様に親+親で決定されます。
2, 3匹目は生まれる場合はランダムな性能になります。

牧場に空き枠を作って子供を待ってください。

## MODの設定

デフォルトでは以下の確率で子供が生まれます。

| 項目 | 確率 |
| ---- | ---: |
| 1匹  |  85% |
| 2匹  |  10% |
| 3匹  |   5% |

設定を変更することで確率を変えられます。
MODを導入した状態で1度ゲームを起動すると以下にデフォルトの設定ファイルが生成されます。

```text
C:\Users\%username%\AppData\Roaming\TinyPasture\mod_configs\rin_jugatla-multi_baby\default.json
```

`default.json`をコピーして`custom.json`に名前を変更します。
設定はjson形式で書かれています。

- デフォルト

```json
{
    "create_baby_probability": {
        "double": 10,
        "single": 85,
        "triple": 5
    }
}
```

- 変更例

以下のように変更するときのjsonを示します。

| 項目 | 確率 |
| ---- | ---: |
| 1匹  |  50% |
| 2匹  |  40% |
| 3匹  |  10% |

```json
{
    "create_baby_probability": {
        "double": 40,
        "single": 50,
        "triple": 10
    }
}
```

## Moddingの手引き

[Godot Modding 入門](https://zenn.dev/rinjugatla/articles/92907e2c033c2f)
