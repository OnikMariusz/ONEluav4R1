require("BlackJack/src/card")

function cardgen()
    local c = math.random(1,4)
    local s = suits[c]
    local c = math.random(1,13)
    local v = values[c]
    card = Card.init(s,v)
    return card
end

function face(c)
    if c == "Jack"
    or c == "King"
    or c == "Queen" then
    val=10
    elseif c == "Ace" then
    val=1
    else
    val=tonumber(c)
    end
    return val
end
   


math.randomseed(os.time())
WIDE = 480
HIGH = 272
suits = { "hearts","spades","clubs","diamonds" }
values = { "Ace","2","3","4","5","6","7","8","9","10","Jack",
"Queen","King" }
hand = {} -- player hand
total = 0 -- player score
comp = {} -- computer hand
ai = 0 -- computer score

--est = cardgen()

testing = ini.read("test.ini","player1","defeated", "dupa")	

while true do
    buttons.read()

    if buttons.released.cross then 
        var = cardgen()
        hand[#hand+1]=var
        val = face(var.value)
        total = var.staticValue

    end

    screen.print(5,20,"player1 name  "..testing,0.6)
    --screen.print(5,30,"card.value "..card.value,0.6)


    screen.flip() 
end