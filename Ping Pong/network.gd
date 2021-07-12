extends Node


const DEFAULT_PORT = 28960
const MAX_CLIENT = 2

var server = null
var client = null
var ip_adress = ""


func _ready() -> void:
	if OS.get_name() == "Windows":
		ip_adress = IP.get_local_addresses()[3]
	elif OS.get_name() == "Android":
		ip_adress = IP.get_local_addresses()[0]
	else:
		ip_adress = IP.get_local_addresses()[3]
	
	for ip in IP.get_local_addresses():
		if ip.begins_with("192.168.") and not ip.ends_with(".1"):
			ip_adress = ip
	
	
	get_tree().connect("connected_to_server", self,"_connected_to_server")
	get_tree().connect("server_disconnected", self, "server_disconnected")
	
func create_server() -> void:
		server = NetworkedMultiplayerENet.new()
		server.create_server(DEFAULT_PORT, MAX_CLIENT)
		get_tree().set_network_peer(server)


func join_server() ->void:
	client = NetworkedMultiplayerENet.new()
	client.create_client(ip_adress, DEFAULT_PORT)
	get_tree().set_network_peer(client)
		
		
		
