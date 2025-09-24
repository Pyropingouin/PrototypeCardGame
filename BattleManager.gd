extends Node

var battle_timer
var empty_monster_card_slots = []



func _ready() -> void:
	battle_timer = $"../BattleTimer"
	battle_timer.one_shot = true
	battle_timer.wait_time = 1.0
	
	empty_monster_card_slots.append($"../CardSlots/EnemyCardSlot1")
	empty_monster_card_slots.append($"../CardSlots/EnemyCardSlot2")
	empty_monster_card_slots.append($"../CardSlots/EnemyCardSlot3")
	empty_monster_card_slots.append($"../CardSlots/EnemyCardSlot4")
	empty_monster_card_slots.append($"../CardSlots/EnemyCardSlot5")
	

func _on_end_turn_button_pressed() -> void:
	opponent_turn()
	
	
	
	
func opponent_turn():	
	$"../EndTurnButton".disabled = true
	$"../EndTurnButton".visible = false



	# Wait 1 second
	battle_timer.start()
	await battle_timer.timeout
	
	
	# If can draw a card, draw then wait 1 second
	if $"../OpponentDeck".opponent_deck.size() != 0:
		$"../OpponentDeck".draw_card()
			# Wait 1 second
		battle_timer.start()
		await battle_timer
		

	# Check if free monster card slots, if no, end turn
	if empty_monster_card_slots.size() == 0:
		end_opponent_turn()
		return
	
	
	# Get random empty slot to play the card in
	var opponent_hand = $"../OpponentHand".opponnent_hand
	if opponent_hand == 0:
		end_opponent_turn()
		return
		
	var random_empty_monster_card_slots = empty_monster_card_slots[randi_range(0,empty_monster_card_slots.size())]
	empty_monster_card_slots.erase(random_empty_monster_card_slots)
	
	# End Turn
	end_opponent_turn()
	
	
func end_opponent_turn():	
	# Reset Player draw deck
	$"../EndTurnButton".disabled = false
	$"../EndTurnButton".visible = true
	
