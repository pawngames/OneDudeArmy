extends Button

class_name UpgradeButton

signal option_selected(info)

var item_path_fmt:String = "res://assets/kenney/kenney_items/genericItem_color_XXX.png"
var item_number:int = 0
var item_info:Dictionary

func _ready():
	pass

func _process(delta):
	pass

func set_image(_item_number:int):
	item_number = _item_number
	var item_path:String = item_path_fmt.replace("XXX", "%03d" % item_number)
	var tex:StreamTexture = load(item_path)
	$VB/Panel/Sprite.texture = tex
	pass

func set_text(text:String):
	$VB/Margin/VB/Label.text = text
	pass

func set_name(text:String):
	$TitleBG/LabelName.text = text
	pass

func set_effect(text:String):
	$VB/Margin/VB/LabelEffect.text = text
	pass

func set_info(info:Dictionary):
	set_image(int(info["img_index"]))
	set_text(info["desc"])
	set_name(info["name"])
	set_effect(info["tier"][info["level"]])
	item_info = info
	pass

func _on_UpgradeButton_pressed():
	$Click.play()
	emit_signal("option_selected", item_info)
	pass
