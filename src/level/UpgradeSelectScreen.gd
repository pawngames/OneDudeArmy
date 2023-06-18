extends HBoxContainer

signal upgrade(upgrade_info)

enum UPGRADE_TYPES {
	SLASHER,
	DEF_BUFF,
	SPD_BUFF,
	LOOT_BUFF,
	ATK_BUFF,
	SHOOTER,
	SHIELD,
	MAGNET,
	TESLA,
	TRAP,
}

const UPGRADE_LIST = {
	"Upgrades": [
		{
			"type": UPGRADE_TYPES.SLASHER,
			"level": 0,
			"img_index" : "164",
			"desc":"Corte Horizontal",
			"name":"Facão",
			"script":"facao.gd",
			"tier":[
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
			]
		},
		{
			"type": UPGRADE_TYPES.SHIELD,
			"level": 0,
			"img_index" : "119",
			"desc":"Proteção que causa dano",
			"name":"Escudo",
			"script":"escudo.gd",
			"tier":[
				"+1 projétil",
				"atk+10%",
				"+1 projétil",
				"atk+10%",
				"+1 projétil",
				"atk+10%",
				"+1 projétil",
				"atk+10%",
				"+1 projétil",
				"atk+10%",
				"+1 projétil",
				"atk+10%",
				"+1 projétil",
				"atk+10%",
				"+1 projétil",
			]
		},
		{
			"type": UPGRADE_TYPES.SHOOTER,
			"level": 0,
			"img_index" : "134",
			"desc":"Atira facas no inimigo mais próximo",
			"name":"Faca",
			"script":"faca.gd",
			"tier":[
				"+1 projétil",
				"atk+2%, spd+2%, cooldown-2%",
				"+1 projétil",
				"atk+2%, spd+2%, cooldown-2%",
				"+1 projétil",
				"atk+2%, spd+2%, cooldown-2%",
				"+1 projétil",
				"atk+2%, spd+2%, cooldown-2%",
				"+1 projétil",
				"atk+2%, spd+2%, cooldown-2%",
				"+1 projétil",
				"atk+2%, spd+2%, cooldown-2%",
				"+1 projétil",
				"atk+2%, spd+2%, cooldown-2%",
				"+1 projétil",
			]
		},
		{
			"type": UPGRADE_TYPES.DEF_BUFF,
			"level": 0,
			"img_index" : "167",
			"desc":"Aumenta defesa",
			"name":"Defesa",
			"script":"defesa.gd",
			"tier":[
				"def+10%",
				"def+10%",
				"def+10%",
				"def+10%",
				"def+10%",
				"def+10%",
				"def+10%",
				"def+10%",
				"def+10%",
				"def+10%",
				"def+10%",
				"def+10%",
				"def+10%",
				"def+10%",
				"def+10%",
			]
		},
		{
			"type": UPGRADE_TYPES.ATK_BUFF,
			"level": 0,
			"img_index" : "168",
			"desc":"Aumenta ataque base",
			"name":"Força",
			"script":"forca.gd",
			"tier":[
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
			]
		},
		{
			"type": UPGRADE_TYPES.SPD_BUFF,
			"level": 0,
			"img_index" : "3",
			"desc":"Aumenta velocidade",
			"name":"Café",
			"script":"xicara.gd",
			"tier":[
				"spd+10%",
				"spd+10%",
				"spd+10%",
				"spd+10%",
				"spd+10%",
				"spd+10%",
				"spd+10%",
				"spd+10%",
				"spd+10%",
				"spd+10%",
				"spd+10%",
				"spd+10%",
				"spd+10%",
				"spd+10%",
				"spd+10%",
			]
		},
		{
			"type": UPGRADE_TYPES.LOOT_BUFF,
			"level": 0,
			"img_index" : "166",
			"desc":"Aumenta valor de moedas",
			"name":"Sorte",
			"script":"sorte.gd",
			"tier":[
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
				"atk+10%",
			]
		},
		{
			"type": UPGRADE_TYPES.MAGNET,
			"level": 0,
			"img_index" : "169",
			"desc":"imã de moedas",
			"name":"imã",
			"script":"ima.gd",
			"tier":[
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
			]
		},
		{
			"type": UPGRADE_TYPES.TESLA,
			"level": 0,
			"img_index" : "165",
			"desc":"Atira raios nos inimigos próximos",
			"name":"Tesla",
			"script":"tesla.gd",
			"tier":[
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
			]
		},
		{
			"type": UPGRADE_TYPES.TRAP,
			"level": 0,
			"img_index" : "170",
			"desc":"Deixa armadilhas para trás",
			"name":"Trap",
			"script":"armadilha.gd",
			"tier":[
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
				"raio+20",
			]
		},
	]
}

var fist_run:bool = true
onready var upgrades:Array = UPGRADE_LIST["Upgrades"]

func _ready():
	for value in UPGRADE_TYPES.keys():
		print(value)
	pass

func _process(delta):
	pass

func show():
	randomize()
	if !visible:
		get_tree().paused = true
		upgrades =  UPGRADE_LIST["Upgrades"].duplicate(true)
		for upgrade in upgrades:
			print("Upgrade: " + upgrade["name"] + " | " + str(upgrade["level"]))
		for upgrade in upgrades:
			if upgrade["level"] > 14:
				upgrades.erase(upgrade)
				print("Remover: " + upgrade["name"])
		for upgrade in upgrades:
			if upgrade["level"] > 14:
				upgrades.erase(upgrade)
				print("Remover: " + upgrade["name"])
		for upgrade in upgrades:
			if upgrade["level"] > 14:
				upgrades.erase(upgrade)
				print("Remover: " + upgrade["name"])
		if !fist_run:
			randomize()
			upgrades.shuffle()
		fist_run = false
		visible = true
		if upgrades.size() >= 3:
			set_btn($UpgradeButton, upgrades.pop_front())
			set_btn($UpgradeButton2, upgrades.pop_front())
			set_btn($UpgradeButton3, upgrades.pop_front())
		elif upgrades.size() >= 2:
			set_btn($UpgradeButton, upgrades.pop_front())
			set_btn($UpgradeButton2, upgrades.pop_front())
			$UpgradeButton3.visible = false
		elif upgrades.size() >= 1:
			set_btn($UpgradeButton, upgrades.pop_front())
			$UpgradeButton2.visible = false
			$UpgradeButton3.visible = false
		else:
			$UpgradeButton.visible = false
			$UpgradeButton2.visible = false
			$UpgradeButton3.visible = false
			emit_signal("upgrade", null)
			get_tree().paused = false
	pass

func set_btn(button:UpgradeButton, info:Dictionary):
	button.set_info(info)
	pass

func _on_UpgradeButton_option_selected(info):
	print("Option selected: " + info["name"])
	for upgrade in UPGRADE_LIST["Upgrades"]:
		if upgrade["type"] == info["type"]:
			upgrade["level"] += 1
			info["level"] = upgrade["level"]
			emit_signal(
				"upgrade", 
				info)
			break
	pass
