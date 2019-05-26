module GameRules
  BJ = 21
  BET = 10
  MAX_DEALER_POINT = 17
  MAX_CARDS_HAND = 3
  ACTION_PASS = 0
  ACTION_TAKE_CARD = 1
  ACTION_OPEN = 2
  ACE_CORRECTION = 10
  USER_ACTIONS = %i[pass take_card open_cards].freeze
  FACE_VALUE = 10
  ACE_VALUE = 11
end
