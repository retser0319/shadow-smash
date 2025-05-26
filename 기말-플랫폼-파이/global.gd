extends Node

var SelectP1 = ""
var SelectP2 = ""

var winner = 1

var trs_fighter = preload("res://game dot/shadow/fighter/fighter.tres")
var trs_gunner = preload("res://game dot/shadow/gunner/gunner.tres")
var trs_lancer = preload("res://game dot/shadow/fighter/fighter.tres")

var Area_fighter = preload("res://Scenes/character/fighter.tscn")
var Area_gunner = preload("res://Scenes/character/gunner.tscn")
var Area_lancer = preload("res://Scenes/character/fighter.tscn")

var bullet = preload("res://Scenes/character/bullet.tscn")
var mine = preload("res://Scenes/UI/mine.tscn")
var sp_bullet = preload("res://Scenes/character/sp_bullet.tscn")

func targetCheck(array) :
	for i in range(array.size() - 1, -1, -1) : if not is_instance_valid(array[i]):  array.remove_at(i)

func targetAdd(array, body) :
	targetCheck(array)
	array.append(body)
	
func targetRemove(array, body) :
	targetCheck(array)
	if array.find(body) != -1: array.erase(body)
