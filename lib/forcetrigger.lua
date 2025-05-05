-- everything demicolon needs (not really as simple anymore)
SMODS.Sound({
	key = "forcetrigger",
	path = "forcetrigger.ogg",
})
SMODS.Sound({
	key = "demitrigger",
	path = "demitrigger.ogg",
})
function Cryptid.demicolonGetTriggerable(card)
	if Cryptid.forcetriggerVanillaCheck(card) then
		return true
	end
	if card and Card.no(card, "demicoloncompat", true) then
		return true
	else
		return false
	end
end

function Cryptid.forcetrigger(card, context)
	local demicontext = {}
	local results = {}
	demicontext.cardarea = context.cardarea or nil
	demicontext.full_hand = context.full_hand or nil
	demicontext.scoring_hand = context.scoring_hand or nil
	demicontext.scoring_name = context.scoring_name or nil
	demicontext.poker_hands = context.poker_hands or nil
	demicontext.forcetrigger = true
	G.E_MANAGER:add_event(Event({
		trigger = "before",
		func = function()
			play_sound("cry_forcetrigger", 1, 1)
			return true
		end,
	}))
	if not Cryptid.forcetriggerVanillaCheck(card) then
		results = eval_card(card, demicontext)
	else
		results = {}
		results.jokers = {}
		-- page 1
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Greedy Joker" then
			results = { jokers = { mult_mod = card.ability.extra.s_mult, card = card } }
		end
		if card.ability.name == "Lusty Joker" then
			results = { jokers = { mult_mod = card.ability.extra.s_mult, card = card } }
		end
		if card.ability.name == "Wrathful Joker" then
			results = { jokers = { mult_mod = card.ability.extra.s_mult, card = card } }
		end
		if card.ability.name == "Gluttonous Joker" then
			results = { jokers = { mult_mod = card.ability.extra.s_mult, card = card } }
		end
		if card.ability.name == "Jolly Joker" then
			results = { jokers = { mult_mod = card.ability.t_mult, card = card } }
		end
		if card.ability.name == "Zany Joker" then
			results = { jokers = { mult_mod = card.ability.t_mult, card = card } }
		end
		if card.ability.name == "Mad Joker" then
			results = { jokers = { mult_mod = card.ability.t_mult, card = card } }
		end
		if card.ability.name == "Crazy Joker" then
			results = { jokers = { mult_mod = card.ability.t_mult, card = card } }
		end
		if card.ability.name == "Droll Joker" then
			results = { jokers = { mult_mod = card.ability.t_mult, card = card } }
		end
		if card.ability.name == "Sly Joker" then
			results = { jokers = { mult_mod = card.ability.t_chips, card = card } }
		end
		if card.ability.name == "Wily Joker" then
			results = { jokers = { mult_mod = card.ability.t_chips, card = card } }
		end
		if card.ability.name == "Clever Joker" then
			results = { jokers = { mult_mod = card.ability.t_chips, card = card } }
		end
		if card.ability.name == "Devious Joker" then
			results = { jokers = { mult_mod = card.ability.t_chips, card = card } }
		end
		if card.ability.name == "Crafty Joker" then
			results = { jokers = { mult_mod = card.ability.t_chips, card = card } }
		end
		-- page 2
		if card.ability.name == "Half Joker" then
			results = { jokers = { mult_mod = card.ability.extra.mult, card = card } }
		end
		if card.ability.name == "Joker Stencil" then
			results = { jokers = { mult_mod = card.ability.x_mult, card = card } }
		end
		-- if card.ability.name == "Four Fingers" then results = { jokers = { }, } end
		-- if card.ability.name == "Mime" then results = { jokers = { }, } end
		-- if card.ability.name == "Credit Card" then results = { jokers = { }, } end
		if card.ability.name == "Ceremonial Dagger" then
			local my_pos = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					my_pos = i
					break
				end
			end
			if
				my_pos
				and G.jokers.cards[my_pos + 1]
				and not card.getting_sliced
				and not G.jokers.cards[my_pos + 1].ability.eternal
				and not G.jokers.cards[my_pos + 1].getting_sliced
			then
				local sliced_card = G.jokers.cards[my_pos + 1]
				sliced_card.getting_sliced = true
				G.GAME.joker_buffer = G.GAME.joker_buffer - 1
				G.E_MANAGER:add_event(Event({
					func = function()
						G.GAME.joker_buffer = 0
						card.ability.mult = card.ability.mult + sliced_card.sell_cost * 2
						card:juice_up(0.8, 0.8)
						sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
						play_sound("slice1", 0.96 + math.random() * 0.08)
						return true
					end,
				}))
			end
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Banner" then
			results = { jokers = { chips = card.ability.extra, card = card } }
		end
		if card.ability.name == "Mystic Summit" then
			results = { jokers = { mult_mod = card.ability.extra.mult, card = card } }
		end
		if card.ability.name == "Marble Joker" then
			G.E_MANAGER:add_event(Event({
				func = function()
					local front = pseudorandom_element(G.P_CARDS, pseudoseed("marb_fr"))
					G.playing_card = (G.playing_card and G.playing_card + 1) or 1
					local card = Card(
						G.play.T.x + G.play.T.w / 2,
						G.play.T.y,
						G.CARD_W,
						G.CARD_H,
						front,
						G.P_CENTERS.m_stone,
						{ playing_card = G.playing_card }
					)
					card:start_materialize({ G.C.SECONDARY_SET.Enhanced })
					G.play:emplace(card)
					table.insert(G.playing_cards, card)
					return true
				end,
			}))
		end
		if card.ability.name == "Loyalty Card" then
			results = { jokers = { mult_mod = card.ability.extra.Xmult, card = card } }
		end
		if card.ability.name == "8 Ball" then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					local card = create_card("Tarot", G.consumeables, nil, nil, nil, nil, nil, "8ba")
					card:add_to_deck()
					G.consumeables:emplace(card)
					G.GAME.consumeable_buffer = 0
					return true
				end,
			}))
		end
		if card.ability.name == "Misprint" then
			results = { jokers = { mult_mod = card.ability.extra.max, card = card } }
		end
		-- if card.ability.name == "Dusk" then results = { jokers = { }, } end
		if card.ability.name == "Raised Fist" then
			results = { jokers = { mult_mod = 22, card = card } }
		end
		-- if card.ability.name == "Chaos the Clown" then results = { jokers = { }, } end
		-- page 3
		if card.ability.name == "Fibonnaci" then
			results = { jokers = { mult_mod = card.ability.extra, card = card } }
		end
		if card.ability.name == "Steel Joker" then
			results = { jokers = { Xmult_mod = (card.ability.extra + 1), card = card } }
		end
		if card.ability.name == "Scary Face" then
			results = { jokers = { chips = card.ability.extra, card = card } }
		end
		if card.ability.name == "Abstract Joker" then
			results = { jokers = { mult_mod = card.ability.extra, card = card } }
		end
		if card.ability.name == "Delayed Gratification" then
			ease_dollars(card.ability.extra)
		end
		-- if card.ability.name == "Hack" then results = { jokers = { }, } end
		-- if card.ability.name == "Pareidolia" then results = { jokers = {  }, } end
		if card.ability.name == "Gros Michel" then
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					card.T.r = -0.2
					card:juice_up(0.3, 0.4)
					card.states.drag.is = true
					card.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.3,
						blockable = false,
						func = function()
							G.jokers:remove_card(card)
							card:remove()
							card = nil
							return true
						end,
					}))
					return true
				end,
			}))
			G.GAME.pool_flags.gros_michel_extinct = true
			results = { jokers = { mult_mod = card.ability.extra.mult, card = card } }
		end
		if card.ability.name == "Even Steven" then
			results = { jokers = { mult_mod = card.ability.extra, card = card } }
		end
		if card.ability.name == "Odd Todd" then
			results = { jokers = { chips = card.ability.extra, card = card } }
		end
		if card.ability.name == "Scholar" then
			results = { jokers = { chips = card.ability.extra.chips, mult_mod = card.ability.extra.mult, card = card } }
		end
		if card.ability.name == "Business Card" then
			ease_dollars(card.ability.extra)
		end
		if card.ability.name == "Supernova" then
			results = { jokers = { mult_mod = G.GAME.hands[context.scoring_name].played, card = card } }
		end
		if card.ability.name == "Ride The Bus" then
			card.ability.mult = card.ability.mult + card.ability.extra
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Space Joker" and context.scoring_name then
			level_up_hand(card, context.scoring_name)
		end
		-- page 4
		if card.ability.name == "Egg" then
			card.ability.extra_value = card.ability.extra_value + card.ability.extra
		end
		if card.ability.name == "Burglar" then
			G.E_MANAGER:add_event(Event({
				func = function()
					ease_discard(-G.GAME.current_round.discards_left, nil, true)
					ease_hands_played(card.ability.extra)
					return true
				end,
			}))
		end
		if card.ability.name == "Blackboard" then
			results = { jokers = { Xmult_mod = card.ability.extra, card = card } }
		end
		if card.ability.name == "Runner" then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
			results = { jokers = { chips = card.ability.extra.chips, card = card } }
		end
		if card.ability.name == "Ice Cream" then
			card.ability.extra.chips = card.ability.extra.chips - card.ability.extra.chip_mod
			results = { jokers = { mult_mod = card.ability.extra.chips, card = card } }
			if card.ability.extra.chips - card.ability.extra.chip_mod <= 0 then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true
							end,
						}))
						return true
					end,
				}))
			end
		end
		if card.ability.name == "DNA" and context.full_hand then
			G.playing_card = (G.playing_card and G.playing_card + 1) or 1
			local _card = copy_card(context.full_hand[1], nil, nil, G.playing_card)
			_card:add_to_deck()
			G.deck.config.card_limit = G.deck.config.card_limit + 1
			table.insert(G.playing_cards, _card)
			G.hand:emplace(_card)
			_card.states.visible = nil

			G.E_MANAGER:add_event(Event({
				func = function()
					_card:start_materialize()
					return true
				end,
			}))
		end
		-- if card.ability.name == "Splash" then results = { jokers = { }, } end
		if card.ability.name == "Blue Joker" then
			results = { jokers = { chips = card.ability.extra, card = card } }
		end
		if card.ability.name == "Sixth Sense" then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.0,
				func = function()
					local card = create_card("Spectral", G.consumeables, nil, nil, nil, nil, nil, "sixth")
					card:add_to_deck()
					G.consumeables:emplace(card)
					G.GAME.consumeable_buffer = 0
					return true
				end,
			}))
		end
		if card.ability.name == "Constellation" then
			card.ability.x_mult = card.ability.x_mult + card.ability.extra
			results = { jokers = { Xmult_mod = card.ability.x_mult, card = card } }
		end
		-- if card.ability.name == "Hiker" then results = { jokers = { }, } end
		if card.ability.name == "Faceless Joker" then
			ease_dollars(card.ability.extra.dollars)
		end
		if card.ability.name == "Green Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Superposition" then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.0,
				func = function()
					local card = create_card(card_type, G.consumeables, nil, nil, nil, nil, nil, "sup")
					card:add_to_deck()
					G.consumeables:emplace(card)
					G.GAME.consumeable_buffer = 0
					return true
				end,
			}))
		end
		if card.ability.name == "To Do List" then
			ease_dollars(card.ability.extra.dollars)
		end
		-- page 5
		if card.ability.name == "Cavendish" then
			results = { jokers = { Xmult_mod = card.ability.extra.Xmult, card = card } }
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					card.T.r = -0.2
					card:juice_up(0.3, 0.4)
					card.states.drag.is = true
					card.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.3,
						blockable = false,
						func = function()
							G.jokers:remove_card(card)
							card:remove()
							card = nil
							return true
						end,
					}))
					return true
				end,
			}))
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		-- page 6
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		-- page 7
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		-- page 8
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		-- page 9
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		-- page 10
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
		if card.ability.name == "Joker" then
			results = { jokers = { mult_mod = card.ability.mult, card = card } }
		end
	end
	demicontext = nil
	print(results)
	return results
end

function Cryptid.forcetriggerVanillaCheck(card)
	local compatvanilla = {
		"Joker",
		"Greedy Joker",
		"Lusty Joker",
		"Wrathful Joker",
		"Gluttonous Joker",
		"Jolly Joker",
		"Zany Joker",
		"Mad Joker",
		"Crazy Joker",
		"Droll Joker",
		"Sly Joker",
		"Wily Joker",
		"Clever Joker",
		"Devious Joker",
		"Crafty Joker",
		"Half Joker",
		"Joker Stencil",
		-- "Four Fingers",
		-- "Mime",
		-- "Credit Card",
		"Ceremonial Dagger",
		"Banner",
		"Mystic Summit",
		"Marble Joker",
		"Loyalty Card",
		"8 Ball",
		"Misprint",
		-- "Dusk",
		"Raised Fist",
		-- "Chaos the Clown",
		"Fibonacci",
		"Steel Joker",
		"Scary Face",
		"Abstract Joker",
		"Delayed Gratification",
		-- "Hack",
		-- "Pareidolia",
		"Gros Michel",
		"Even Steven",
		"Odd Todd",
		"Scholar",
		"Business Card",
		"Supernova",
		"Ride the Bus",
		"Space Joker",
		"Egg",
		"Burglar",
		"Blackboard",
		"Runner",
		"Ice Cream",
		"DNA",
		-- "Splash",
		"Blue Joker",
		"Sixth Sense",
		"Constellation",
		"Hiker",
		"Faceless Joker",
		"Green Joker",
		"Superposition",
		"To Do List",
		"Cavendish",
		"Card Sharp",
		"Red Card",
		"Madness",
		"Square Joker",
		"SÃ©ance",
		"Riff-Raff",
		"Vampire",
		"Shortcut",
		"Hologram",
		"Vagabond",
		"Baron",
		"Cloud 9",
		"Rocket",
		"Obelisk",
		"Midas Mask",
		"Luchador",
		"Photograph",
		"Gift Card",
		"Turtle Bean",
		"Erosion",
		"Reserved Parking",
		"Mail-In Rebate",
		"To the Moon",
		"Hallucination",
		"Fortune Teller",
		"Juggler",
		"Drunkard",
		"Stone Joker",
		"Golden Joker",
		"Lucky Cat",
		"Baseball Card",
		"Bull",
		"Diet Cola",
		"Trading Card",
		"Flash Card",
		"Popcorn",
		"Spare Trousers",
		"Ancient Joker",
		"Ramen",
		"Walkie Talkie",
		"Seltzer",
		"Castle",
		"Smiley Face",
		"Campfire",
		"Golden Ticket",
		"Mr. Bones",
		"Acrobat",
		"Sock and Buskin",
		"Swashbuckler",
		"Troubadour",
		"Certificate",
		"Smeared Joker",
		"Throwback",
		"Hanging Chad",
		"Rough Gem",
		"Bloodstone",
		"Arrowhead",
		"Onyx Agate",
		"Glass Joker",
		"Showman",
		"Flower Pot",
		"Blueprint",
		"Wee Joker",
		"Merry Andy",
		"Oops! All 6s",
		"The Idol",
		"Seeing Double",
		"Matador",
		"Hit the Road",
		"The Duo",
		"The Trio",
		"The Family",
		"The Order",
		"The Tribe",
		"Stuntman",
		"Invisible Joker",
		"Brainstorm",
		"Satellite",
		"Shoot the Moon",
		"Driver's License",
		"Cartomancer",
		"Astronomer",
		"Burnt Joker",
		"Bootstraps",
		"Canio",
		"Triboulet",
		"Yorick",
		"Chicot",
		"Perkeo",
	}
	local vanilcheck = false
	for i = 1, #compatvanilla do
		if card.ability.name == compatvanilla[i] then
			vanilcheck = true
		end
	end
	return vanilcheck
end
