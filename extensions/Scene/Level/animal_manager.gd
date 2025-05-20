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
	_create_multi_baby(animal_left)
	super(animal_left, animal_right, inherit_color, inherit_name)

## 赤ちゃんの生まれる数
enum CreateBabyType {
	single = 1,
	double = 2,
	triple = 3
}

## 赤ちゃんの生まれる確率
const CreateBabyProbability = {
	single = 85,
	double = 10,
	triple = 5
}

## 複数の赤ちゃんを生む処理
func _create_multi_baby(animal_left: AnimalSave) -> void:
	var baby_multi_type = _create_baby_multi_type()
	if baby_multi_type == CreateBabyType.single:
		return
	
	# 1匹は既存処理で生まれる
	# 親は既存関数でこの後使用するのでここでは消さない
	var pack = FarmDB.get_card_pack_data(animal_left.type_id)
	const skip_one_baby = 1
	for i in range(skip_one_baby, baby_multi_type):
		var baby_save = _create_new_random_baby(pack)
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

## ランダムな赤ちゃんを生成
## res://Scene/UI/PopupUI/UIShop/ui_shop_opened_pack.gd _creat_random_animal_by_pack()から
func _create_new_random_baby(pack: AnimalPackData) -> AnimalSave:
	var rare = pack.get_random_rare()
	var animal_data: = FarmDB.get_animal_data(pack.animal_id)
	var color = animal_data.color_pool.pick_random()
	var move_speed = randi_range(animal_data.min_move_speed, animal_data.max_move_speed)

	var baby_save: = AnimalSave.new()
	baby_save.type_id = pack.animal_id
	baby_save.color_type = color
	baby_save.rare_rank = rare
	baby_save.move_speed = move_speed
	baby_save.getting_time = Time.get_datetime_dict_from_system()
	baby_save.coin_speed = animal_data.get_rare_coin_speed(rare)
	return baby_save

## 赤ちゃんをマップに生成
## セーブデータに追加すると自動的にマップに生成される
func _spawn_multi_baby() -> void:
	if babies.is_empty():
		return
	
	var farm = GSave.get_current_farm()
	for baby: AnimalSave in babies:
		# 枠を確保しないで生成するので、繁殖中に枠が埋まっていないかチェック
		if farm.check_is_animal_addable():
			GState.add_animal.emit(baby)
		baby.is_baby = false
		baby = null
		
	babies.clear()
