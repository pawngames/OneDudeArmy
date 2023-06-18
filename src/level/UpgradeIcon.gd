extends Panel

var item_path_fmt:String = "res://assets/kenney/kenney_items/genericItem_color_XXX.png"
var upgrade_name:String = ""

func _ready():
	pass

func set_info(info:Dictionary):
	upgrade_name = info["name"]
	set_image(int(info["img_index"]))
	set_text(str(info["level"]))
	pass

func set_image(_item_number:int):
	var item_path:String = item_path_fmt.replace("XXX", "%03d" % _item_number)
	var tex:StreamTexture = load(item_path)
	$Margin/Icon.texture = tex
	pass

func set_text(text:String):
	$Label.text = text
	pass
