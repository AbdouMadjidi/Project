extends Control


var game_started = false
var score = {
	"Player":0,
	"Enemy":0
	
}

func _ready():
	new_game()


func _goal(body, extra_arg_0):
	
	score[extra_arg_0] += 1
	get_node("Hud/score_"+extra_arg_0).text=str(score[extra_arg_0])
	new_game()


func _physics_process(delta):
	$timer_text.text = str(ceil($timer_text/Timer.time_left))


func new_game():
	game_started = false
	$timer_text/Timer.start()
	$timer_text.visible = true
	$Ball.position = Vector2(200, 300)
	$Ball.reset_ball()


func _on_Timer_timeout():
	game_started = true
	$timer_text.visible = false


func _on_MenuButton_pressed():
	get_tree().change_scene("res://Menu.tscn")
