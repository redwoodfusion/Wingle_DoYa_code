require './poker_methods.rb'

deck = []
cards = []
numbers = []
counter = []
straight_check = cards
suit = [] #S,D,H,C
key = "r"

card_initialize(deck)
deck.shuffle!
for i in 0..4 do 
	t = deck.shift
 	cards << t
end

cards.sort{|s,n|n[1]<=>s[1]}
cards.flatten!

p cards

counter = counter_make(cards)
pair_count = counter.count(2)
tri_count = counter.count(3)
four_count = counter.count(4)

p "Please choice needless cards."
p "If select cards, or don't need change any cards,input 'ok'."

choice = []
change = ""

loop{
print "change card is"
p choice
change = gets.chop

if change == ""
	p "type 'number' or 'ok'"
end

for i in 1..5 do
	if change.to_i == i
		if choice.include?(i)
			choice.delete(i)
		else
			choice << i
		end
	end
end

if change == "ok"
	break
end
}

cards = change_card(cards,choice,deck)

counter = counter_make(cards)
pair_count = counter.count(2)
tri_count = counter.count(3)
four_count = counter.count(4)
p "Result:"
hit = 0

if royal_straight_check(cards)== 1 && flash_check(cards).include?(5)
	p "Royal Straight Flash!!!"
	hit = 1
elsif straight_check(cards)== 1 && flash_check(cards).include?(5)
	p "Straight Flash!!"
	hit = 1
elsif straight_check(cards)==1
	p "Straight"
	hit = 1
end

if (pair_count == 1 && tri_count == 1) || (pair_count==2 && joker_check(cards)==0) #11222 or 1122B
	p "Full House"
	hit = 1
elsif (pair_count == 1 && tri_count ==0 && joker_check(cards)==1)||(pair_count==0 && tri_count==0 && four_count==0 && joker_check(cards) == 0)#11234 or 1234B
	p "One pair"
	hit = 1
elsif (pair_count==2 && joker_check(cards)==1) #11223 not 1122B
	p "Two pair"
	hit = 1
elsif (tri_count == 1 && joker_check(cards)==1)||(pair_count==1 && joker_check(cards)==0) #11123 or 1123B
	p "Three cards"
	hit = 1
elsif (four_count == 1 && joker_check(cards)==1) ||(tri_count==1 && joker_check(cards)==0) #11112 or 1112B not 1111B
	p "Four cards"
	hit = 1
elsif (four_count == 1 && joker_check(cards)==0)#1111B
	p "Five cards"
	hit = 1
end

if suit.include?(5)
	p "Flash"
	hit = 1
end

if hit == 0
		p "You loss.."
end
