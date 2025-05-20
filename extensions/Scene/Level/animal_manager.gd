extends "res://Scene/Level/animal_manager.gd"

# 双子以上の赤ちゃんのデータ
var babies = []

## baby_creatorのカーテンが開くタイミングで発火
func _on_add_animal_in_pos(animal: AnimalSave, pos_x: float):
	super(animal, pos_x)
	
	_spawn_multi_baby()

## 繁殖決定発火
## 親から子を生成
func _on_animal_creat_baby(animal_left, animal_right, inherit_color, inherit_name):
	# 既存処理で親を消すので、手前で処理する必要あり
	_create_multi_baby(animal_left, animal_right, inherit_color, inherit_name)
	super(animal_left, animal_right, inherit_color, inherit_name)

## 赤ちゃんの生まれる数
enum CreateBabyType {
	single = 1,
	double = 2,
	triple = 3
}

## 赤ちゃんの生まれる確率
## 50%:1匹, 30%:2匹, 20%:3匹
const CreateBabyProbability = {
	#single = 50,
	#double = 30,
	#triple = 20
	single = 0,
	double = 0,
	triple = 100
}

## 複数の赤ちゃんを生む処理
func _create_multi_baby(animal_left, animal_right, inherit_color, inherit_name) -> void:
	var baby_multi_type = _create_baby_multi_type()
	if baby_multi_type == CreateBabyType.single:
		return
	
	# 1匹は既存処理で生まれる
	# 親は既存関数でこの後使用するのでここでは消さない
	const skip_one_baby = 1
	for i in range(skip_one_baby, baby_multi_type):
		# TODO: 複数生まれる場合は子供の性能を少し下げる
		var baby_save = Handler.creat_baby_animal(animal_left, animal_right, inherit_color, inherit_name)
		babies.append(baby_save)

## 赤ちゃんの生まれる数を決定する
func _create_baby_multi_type() -> int:
	var random = randf_range(0, 100)
	if random < CreateBabyProbability.single:
		return CreateBabyType.single
	elif random < CreateBabyProbability.single + CreateBabyProbability.double:
		return CreateBabyType.double
	else:
		return CreateBabyType.triple

## 赤ちゃんをマップに生成
## セーブデータに追加すると自動的にマップに生成される
func _spawn_multi_baby() -> void:
	if babies.is_empty():
		return
	
	var farm = GSave.get_current_farm()
	for baby: AnimalSave in babies:
		if farm.check_is_animal_addable():
			GState.add_animal.emit(baby)
		baby.is_baby = false
		baby = null
		
	babies.clear()
