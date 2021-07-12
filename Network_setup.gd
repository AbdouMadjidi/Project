extends Control


var Player = load("res://Player.tscn")
var Player2 = load("res://Player2.tscn")

onready var multiplayer_config_ui = $Multiplayer_configure
onready var server_ip_address = $Multiplayer_configure/server_ip_address
onready var device_ip_address = $CanvasLayer/Device_ip_address


func _ready() -> void:
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	device_ip_address.text = Network.ip_adress

func _player_connected(id) -> void:
	print("Player" + str(id) + "has connected")
	
	instance_player(id)

func _player_disconnected(id) -> void:
	print("Player" + str(id) + "has connected")
	
	if Player.has_node(str(id)):
		Player.get_node(str(id)).queue_free()





func _on_Create_Server_Buttom_pressed():
	multiplayer_config_ui.hide()
	Network.create_server()
	
	instance_player(get_tree().get_network_unique_id())

func _on_Join_server_buttom_pressed():
	if server_ip_address.text != "":
		multiplayer_config_ui.hide()
		Network.ip_adress = server_ip_address.text
		Network.join_server()



func _connected_to_server() -> void:
	yield(get_tree().create_timer(0.1), "timeout")
	instance_player(get_tree().get_network_unique_id())



func _on_Button_pressed():
	get_tree().change_scene("res://Menu.tscn")


func instance_player(id) -> void:
	var player_instance = Global.instance_node_at_location(Player, Players, Vector2(200.0, 550.0)) #or Global.instance_node_at_location(Player, Players, Vector2(200, -50))) 
	var player2_instance = Global.instance_node_at_location(Player2, Players, Vector2(200.0, 50.0))
	player_instance.name = str(id)
	player_instance.set_network_master(id)
	
