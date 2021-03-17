Card = {}
Card.staticValue = 5


function Card.init(suit,value)

    local self = setmetatable({}, Card)
    self.suit = suit
    self.value = value
    return self
end