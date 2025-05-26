extends CanvasLayer


var P1bar
var P2bar
var P1
var P2

var P1_life
var P2_life

var last_damage = 0

func _ready():
	P1bar = [$P1/bar100,$P1/bar10,$P1/bar1]
	P2bar = [$P2/bar100,$P2/bar10,$P2/bar1]
	
	P1_life = $P1/P1Life
	P2_life = $P2/P2Life
	
	P1 = get_tree().get_nodes_in_group("Player")[0]
	P2 = get_tree().get_nodes_in_group("Player")[1]
	
	P1bar[0].texture = load("res://game dot/Number/Number_0.png")
	P1bar[1].texture = load("res://game dot/Number/Number_0.png")
	P1bar[2].texture = load("res://game dot/Number/Number_0.png")
	P1_life.texture = load("res://game dot/Number/Number_3.png")
	
	P2bar[0].texture = load("res://game dot/Number/Number_0.png")
	P2bar[1].texture = load("res://game dot/Number/Number_0.png")
	P2bar[2].texture = load("res://game dot/Number/Number_0.png")
	P2_life.texture = load("res://game dot/Number/Number_3.png")
		
	

func _process(delta: float):
	update_hp()
	update_life()

func update_hp():
	
	var hun =  int(P1.C.RG) / 100
	var hun2 = int(P2.C.RG) / 100
	
	var ten = int(P1.C.RG) /10 % 10
	var ten2 = int(P2.C.RG) /10 % 10
	
	var one = int(P1.C.RG) % 10
	var one2 = int(P2.C.RG) % 10
	
		
	
	P1bar[0].texture = load("res://game dot/Number/Number_%d.png" % hun)
	P1bar[1].texture = load("res://game dot/Number/Number_%d.png" % ten)
	P1bar[2].texture = load("res://game dot/Number/Number_%d.png" % one)
	
	P2bar[0].texture = load("res://game dot/Number/Number_%d.png" % hun2)
	P2bar[1].texture = load("res://game dot/Number/Number_%d.png" % ten2)
	P2bar[2].texture = load("res://game dot/Number/Number_%d.png" % one2)
	
func update_life():
	var P1_life_point = P1.C.Life
	P1_life.texture = load("res://game dot/Number/Number_%d.png" % P1_life_point)
	var P2_life_point = P2.C.Life
	P2_life.texture = load("res://game dot/Number/Number_%d.png" % P2_life_point)
	
	
		
