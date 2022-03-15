extends KinematicBody

export (bool) var use_gravity := true
export (float) var walk_speed := 10.0
export (float) var sprint_speed := 25.0
export (float) var acceleration := 10.0
export (float) var deacceleration := 5.0
export (bool) var can_move_in_air := true
export (bool) var stop_on_slopes := false

# jump values
export (float) var jump_height := 2.5
export (float) var time_to_peak := 0.3

export (bool) var use_camera_fov_effects := true
export (float) var camera_fov_normal := 70.0
export (float) var camera_fov_sprinting := 90.0
export (float) var camera_fov_lerp_speed := 1.5

export (String) var input_forwards := "move_forwards"
export (String) var input_back := "move_backwards"
export (String) var input_left := "move_left"
export (String) var input_right := "move_right"
export (String) var input_jump := "jump"
export (String) var input_sprint := "sprint"
export (String) var toggle_mouse_capture := "ui_cancel"
export (String) var input_interact := "interact"
export (float) var mouse_sensitivity := 0.003

onready var pivot :Spatial = $Pivot
onready var camera :Camera= $Pivot/Camera
onready var selection_check :RayCast= $Pivot/Camera/SelectionCast
onready var ground_cast : RayCast = $GroundCast

# "Building a better jump" math stolen shamelessly
onready var _gravity := -(2.0 * jump_height) / pow(time_to_peak, 2)
onready var _jump_velocity := -_gravity * time_to_peak

var velocity := Vector3()

var is_sprinting := false

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera.fov = camera_fov_normal
	print("Should stop on slopes? ", stop_on_slopes)

func _process(delta: float) -> void:
	if use_camera_fov_effects:
		_handle_camera_fov(delta)

func _handle_camera_fov(delta : float) -> void:
	var target_fov = camera_fov_sprinting if is_sprinting else camera_fov_normal
	camera.fov = lerp(camera.fov, target_fov, camera_fov_lerp_speed * delta)

func _physics_process(delta: float) -> void:
	var movement := _get_movement()
	velocity = velocity.linear_interpolate(movement, acceleration * delta)
	velocity = _apply_gravity(velocity, delta)
	velocity = _apply_jump(velocity, delta)
	var snap := Vector3.DOWN if velocity.y > 0 else Vector3.UP
	if is_on_floor() and velocity.y < 0:
		velocity.y = 0
	var _clear = move_and_slide(velocity, Vector3.UP, true)
	#velocity = move_and_slide_with_snap(velocity, snap, Vector3.UP, stop_on_slopes)

func _get_movement() -> Vector3:
	if not can_move_in_air and not is_on_floor():
		return Vector3()
	var input := Vector2()
	input = Input.get_vector(input_left, input_right, input_back, input_forwards) # gets the normalized vector across the four inputs

	var movement :Vector3= (-camera.global_transform.basis.z * input.y) + (camera.global_transform.basis.x * input.x)
	movement.y = 0
	movement = movement.normalized()
	if Input.is_action_pressed(input_sprint):
		movement *= sprint_speed
		is_sprinting = true
	else:
		movement *= walk_speed
		is_sprinting = false
	return movement

func _apply_gravity(vel : Vector3, delta : float) -> Vector3:
	if use_gravity:
		vel.y += _gravity * delta
	return vel

func _apply_jump(vel : Vector3, _delta : float) -> Vector3:
	if use_gravity and Input.is_action_pressed(input_jump) and is_on_floor():
		vel.y = _jump_velocity
	return vel

const view_angle_limit := deg2rad(70)
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		var mouse_event := event as InputEventMouseMotion
		pivot.rotate_x(-mouse_event.relative.y * mouse_sensitivity)
		rotate_y(-mouse_event.relative.x * mouse_sensitivity)
		pivot.rotation.x = clamp(pivot.rotation.x, -view_angle_limit, view_angle_limit)

	elif event.is_action_pressed(toggle_mouse_capture):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed(input_interact):
		if selection_check.is_colliding():
			var collider := selection_check.get_collider()
			if collider.has_method("interact"):
				collider.interact(self)
