def card_initialize(args)
	for i in 1..13 do
		args << ["H",i]
		args << ["S",i]
		args << ["D",i]
		args << ["C",i]
	end
		args << ["B",0]
end

def joker_check(args)
	if args.include?("B") #ジョーカーがあればreturn 0
		return 0
	else
		return 1 #ジョーカーがなければreturn 1
	end
end

def counter_make(args)
	counter = []
	for i in 0..13 do
		counter << args.count(i)
	end
	return counter
end

def flash_check(args)
	suit = []
	suit << args.select{|x| x=="S"}.length
	suit << args.select{|x| x=="D"}.length
	suit << args.select{|x| x=="H"}.length
	suit << args.select{|x| x=="C"}.length
	if joker_check(args) == 0
		for i in 0..3 do
			suit[i] += 1
		end 
	end
	return suit
end

def straight_count(args)
straight_template =[ [1,2,3,4,5],[2,3,4,5,6],[3,4,5,6,7],[4,5,6,7,8],
										 [5,6,7,8,9],[6,7,8,9,10],[7,8,9,10,11],
										 [8,9,10,11,12],[9,10,11,12,13],[1,10,11,12,13]]
	temp = []
	count = []
	nums = []
	nums << args[1]
	nums << args[3]
	nums << args[5]
	nums << args[7]
	nums << args[9]
	for i in 0..9 do
		temp = nums & straight_template[i]
		count << temp.length
	end
	return count
end

def straight_check(args)
	temp = straight_count(args)
	for i in 0..temp.length do
		if temp[i] == 5
			return 1 # ストレートならreturn 1
		elsif temp[i] == 4 && args.include?("B")
			return 1
		end
	end
		return 0 # ストレートじゃないならreturn 0
end

def royal_straight_check(args)
	temp = straight_count(args)
	for i in 0..temp.length do
		if temp[9] == 5
			return 1
		elsif temp[9] == 4 && args.include?("B")
			return 1
		end
	end
	return 0
end

def change_card(args,change_args,deck)
	change_args.sort
	new_args = []
	n = change_args.length
		
		#手札からいらないカードを削除する
		for i in 1..n do
			x = change_args.shift.to_i
			args[(x*2)-1] = "X"
			args[(x*2)-2] = -1 
		end
		
		args.delete("X")
		args.delete(-1)
		
		#デッキから必要な枚数引く		
		for i in 1..n do
		args << deck[i]
		end
			
		#元の平らな状態に戻す
		args.flatten!
		p args
	return args
end
