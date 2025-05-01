-- everything demicolon needs (yes it's that simple)
SMODS.Sound({
	key = "forcetrigger",
	path = "forcetrigger.ogg",
})
SMODS.Sound({
	key = "demitrigger",
	path = "demitrigger.ogg",
})
function Cryptid.demicolonGetTriggerable(card)
	if card and Card.no(card, "demicoloncompat", true) then
		return true
	else
		return false
	end
end

function Cryptid.forcetrigger(card, context)
	local demicontext = {}
	demicontext.cardarea = context.cardarea
	demicontext.full_hand = context.full_hand
	demicontext.scoring_hand = context.scoring_hand
	demicontext.scoring_name = context.scoring_name
	demicontext.poker_hands = context.poker_hands
	demicontext.forcetrigger = true
	G.E_MANAGER:add_event(Event({
		trigger = "before",
		func = function()
			play_sound("cry_forcetrigger", 1, 1)
			return true
		end,
	}))
	local results = eval_card(card, demicontext)
	demicontext = nil
	return results
end
