extends "res://Manager/FarmDB.gd"

## animal_idからpackを取得
## pack_depotのtype_idとanimal_dataのtype_idは必ずしも一致するとは限らないため探索が必要
## animal_data.type_id == pack_depot.animal_id
func get_card_pack_data_by_animal_id(animal_id) -> AnimalPackData:
	for pack in pack_depot.values():
		var is_target = is_same_animal_pack(pack, animal_id)
		if is_target:
			return pack
		
	return null

func is_same_animal_pack(animal_pack: AnimalPackData, animal_id: int):
	return animal_pack.animal_id == animal_id
