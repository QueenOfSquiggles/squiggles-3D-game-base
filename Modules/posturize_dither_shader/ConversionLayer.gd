extends TextureRect

export (NodePath) var owner_viewport : NodePath 
export (Material) var retro_filter_mat : Material

func _ready() -> void:
	if owner_viewport and get_node(owner_viewport):
		var viewport := get_node(owner_viewport) as Viewport
		if viewport:
			var _clear = viewport.connect("size_changed", self, "on_screen_changed")
		else:
			var _clear = get_tree().connect("screen_resized", self, "on_screen_changed")
	else:
		var _clear = get_tree().connect("screen_resized", self, "on_screen_changed")
	var _clear = Settings.connect("refresh_settings", self, "update_use")
	update_use()

func on_screen_changed() -> void:
	if not material:
		return
	var viewport := get_tree().current_scene.get_viewport()
	if viewport:
		(self.material as ShaderMaterial).set_shader_param("screen_size", viewport.size)

func update_use() -> void:
	if Settings.use_retro_filter:
		self.visible = true
		self.material = retro_filter_mat
	else:
		self.visible = false
		self.material = null
