defmodule Poker do
    
    def deal(deck) do
        
        hand1 = Enum.sort([hd deck] ++ [hd tl (tl deck)] ++ tl(tl(tl(tl deck))))
        hand2 = Enum.sort([hd tl deck] ++ [hd tl(tl(tl deck))] ++ tl(tl(tl(tl deck))))
		handT1 = Enum.reverse(tupleConvert(hand1) |> Enum.sort_by(&(String.to_integer(elem(&1,0)))))
		handT2 = Enum.reverse(tupleConvert(hand2) |> Enum.sort_by(&(String.to_integer(elem(&1,0)))))

        cond do

        	royalFlush(hand1) != "Not royalFlush" || royalFlush(hand2) != "Not royalFlush" ->
        		cond do
		        	royalFlush(hand1) != "Not royalFlush" ->
		        		printStraight(royalFlush(hand1))
		        	true ->
		        		printStraight(royalFlush(hand2))
    			end

    		straightFlush(hand1) != "Not Straight" || straightFlush(hand2) != "Not Straight" ->
    			cond do
		    		straightFlush(hand1) == "Not Straight" && straightFlush(hand2) != "Not Straight" ->
		    			printStraight(converter(hand2, straightFlush(hand2)))
		    		straightFlush(hand1) != "Not Straight" && straightFlush(hand2) == "Not Straight" ->
		    			printStraight(converter(hand1, straightFlush(hand1)))
    				true ->
    					win = tieStraight(straightFlush(hand1), straightFlush(hand2))
    					cond do
    						win == "hand1" ->
    							printStraight(converter(hand1, straightFlush(hand1)))
    						true ->
    							printStraight(converter(hand2, straightFlush(hand2)))
		    			end
    			end

			checkFour(handT1) != nil || checkFour(handT2) != nil ->
				cond do
					checkFour(handT1) != nil && checkFour(handT2) == nil ->
						result(checkFour(handT1))
					checkFour(handT1) == nil && checkFour(handT2) != nil ->
						result(checkFour(handT2))
					true ->
						cond do
							tieFour(handT1,handT2) == "hand1" ->
								result(checkFour(handT1))
							true ->
								result(checkFour(handT2))
						end
				end

			fullHouse(handT1) != nil || fullHouse(handT2) != nil ->
				cond do
					fullHouse(handT1) != nil && fullHouse(handT2) == nil ->
						result(fullHouse(handT1))
					fullHouse(handT1) == nil && fullHouse(handT2) != nil ->
						result(fullHouse(handT2))
					true ->
						cond do 
							tieFullHouse(handT1,handT2) == "hand1" ->
								result(fullHouse(handT1))
							true ->
								result(fullHouse(handT2))
						end
				end

			flush(hand1) != "Not Flush" || flush(hand2) != "Not Flush" ->	
    			cond do
	    			flush(hand1) == "Not Flush" && flush(hand2) != "Not Flush" ->
	    				printStraight(flush(hand2))
	    			flush(hand1) != "Not Flush" && flush(hand2) == "Not Flush" ->
	    				printStraight(flush(hand1))
	    			true ->
    				tieFlush(flush(hand1), flush(hand2))
    			end

    		straight(hand1) != "Not Straight" || straight(hand2) != "Not Straight" ->
        		cond do
    				straight(hand1) == "Not Straight" && straight(hand2) != "Not Straight" ->
    					winner = straight(hand2)
    					printStraight(converter(hand2, winner))
    				straight(hand1) != "Not Straight" && straight(hand2) == "Not Straight" ->
    					winner = straight(hand1)
    					printStraight(converter(hand1, winner))
    				true -> 
    					win = tieStraight(straight(hand1), straight(hand2))
    					cond do
    						win == "hand1" ->
    							printStraight(converter(hand1, straight(hand1)))
    						true ->
    							printStraight(converter(hand2, straight(hand2)))
    					end
    			end
			
			checkThree(handT1) != nil || checkThree(handT2) != nil ->
				cond do
					checkThree(handT1) != nil && checkThree(handT2) == nil ->
						result(checkThree(handT1))
					checkThree(handT1) == nil && checkThree(handT2) != nil ->
						result(checkThree(handT2))
					true ->
						cond do
							tieThree(handT1,handT2) == "hand1" ->
								result(checkThree(handT1))
							true ->
								result(checkThree(handT2))
						end
				end
			
			checkPair(handT1) != nil || checkPair(handT2) != nil ->
				cond do
				 	checkPair(handT1) != nil && checkPair(handT2) != nil ->
						if (check2Pair(handT1 -- checkPair(handT1) , checkPair(handT1)) != nil || check2Pair(handT2 -- checkPair(handT2) , checkPair(handT2)) != nil) do
							cond do
								check2Pair(handT1 -- checkPair(handT1) , checkPair(handT1)) != nil && check2Pair(handT2 --checkPair(handT2) , checkPair(handT2)) == nil ->
									result(check2Pair(handT1 -- checkPair(handT1) , checkPair(handT1)))
								check2Pair(handT1 -- checkPair(handT1) , checkPair(handT1)) == nil && check2Pair(handT2 --checkPair(handT2) , checkPair(handT2)) != nil ->
									result(check2Pair(handT2 -- checkPair(handT2) , checkPair(handT2)))
								true ->
									cond do
										tie2Pair(handT1,handT2) == "hand1" ->
											result(check2Pair(handT1 --checkPair(handT1) , checkPair(handT1)))
										true ->
											result(check2Pair(handT2 --checkPair(handT2) , checkPair(handT2)))
									end
							end
						else
							cond do
								checkPair(handT1) != nil && checkPair(handT2) == nil ->
									result(checkPair(handT1))
								checkPair(handT1) == nil && checkPair(handT2) != nil ->
									result(checkPair(handT2))
								true ->
									cond do
										tiePair(handT1,handT2) == "hand1" ->
											result(checkPair(handT1))
										true ->
											result(checkPair(handT2))
									end
							end	
						end
					checkPair(handT1) != nil ->
						if (check2Pair(handT1 -- checkPair(handT1),checkPair(handT1))) != nil do
							result((check2Pair(handT1 -- checkPair(handT1),checkPair(handT1))))
						else
							result(checkPair(handT1))
						end
					checkPair(handT2) != nil ->
						if (check2Pair(handT2 -- checkPair(handT2),checkPair(handT2))) != nil do
							result((check2Pair(handT2 -- checkPair(handT2),checkPair(handT2))))
						else
							result(checkPair(handT2))
						end
					true ->
						cond do
							checkPair(handT1) != nil && checkPair(handT2) == nil ->
								result(checkPair(handT1))
							checkPair(handT1) == nil && checkPair(handT2) != nil ->
								result(checkPair(handT2))
							true ->
								cond do
									tiePair(handT1,handT2) == "hand1" ->
										result(checkPair(handT1))
									true ->
										result(checkPair(handT2))
								end
						end	
					
				end

			true ->
				cond do
					String.to_integer(elem((hd highCard(handT1)),0)) > String.to_integer(elem((hd highCard(handT2)),0))  ->
						result(highCard(handT1))
					String.to_integer(elem((hd highCard(handT1)),0)) < String.to_integer(elem((hd highCard(handT2)),0))  ->
						result(highCard(handT2))
					true ->
						cond do
							highSide(handT1,handT2) == "hand1" ->
								result(highCard(handT1))
							true ->
								result(highCard(handT2))
						end
					
    			end
			end
	end

    def converter(hand, win) do
    	nums = Enum.map(hand, fn x -> (rem x-1,13)+1 end)
    	i1 = Enum.find_index(nums, fn x -> x == Enum.at(win,0) end)
    	nums = List.replace_at(nums,i1, 0)
    	i2 = Enum.find_index(nums, fn x -> x == Enum.at(win,1) end)
    	nums = List.replace_at(nums,i2, 0)
    	i3 = Enum.find_index(nums, fn x -> x == Enum.at(win,2) end)
    	nums = List.replace_at(nums,i3, 0)
    	i4 = Enum.find_index(nums, fn x -> x == Enum.at(win,3) end)
    	nums = List.replace_at(nums,i4, 0)
    	i5 = Enum.find_index(nums, fn x -> x == Enum.at(win,4) end)
    	
    	[Enum.at(hand, i1),Enum.at(hand, i2),Enum.at(hand, i3),Enum.at(hand, i4),Enum.at(hand, i5)]

	end

    def tieStraight(hand1, hand2) do
    	hand1 = Enum.sort(hand1)
    	hand2 = Enum.sort(hand2)

    	cond do
    		Enum.at(hand1, 0) == 1 && Enum.at(hand1, 4) == 13 ->
    			"hand1"
    		Enum.at(hand2, 0) == 1 && Enum.at(hand2, 4) == 13 ->
    			"hand2"
    		Enum.at(hand1, 1) < Enum.at(hand2, 1) ->
    			"hand2"
    		Enum.at(hand1, 1) > Enum.at(hand2, 1) ->
    			"hand1"
    		true ->
    			"hand1"
    	end
	end

	def printStraight(hand) do
		handNums = Enum.map(hand, fn x -> to_string((rem x-1,13)+1) end)
		handsuit = Enum.map(hand, fn x -> (div x-1,13) end)
		suits = ["C", "D", "H", "S"]
		handsuit = Enum.map(handsuit, fn x -> Enum.at(suits, x) end)
		hand = Enum.zip(handNums,handsuit)
		Enum.map(hand, fn x -> to_string(Tuple.to_list(x)) end)
	end


    def tieFlush(hand1, hand2) do
		handNums1 = Enum.map(hand1, fn x -> (rem x-1,13)+1 end)
    	handNums1 = Enum.sort(handNums1)
		handNums2 = Enum.map(hand2, fn x -> (rem x-1,13)+1 end)
    	handNums2 = Enum.sort(handNums2)

    	cond do
    		(Enum.at(handNums1, 0) == 1) && (Enum.at(handNums2, 0) != 1) ->
    			printStraight(hand1)
    		(Enum.at(handNums2, 0) == 1) && (Enum.at(handNums1, 0) != 1) ->
    			printStraight(hand2)
    		true ->
    			cond do
    			 	tieBreakFlush(handNums1, handNums2, 4) == "hand1" ->
    			 		printStraight(hand1)
    			 	true ->
    			 		printStraight(hand2)
    			end 
    	end
	end

    def tieBreakFlush(hand1, hand2, index) do

    	cond do
    		Enum.at(hand1, index) < Enum.at(hand2, index) ->
    			"hand2"
    		Enum.at(hand1, index) > Enum.at(hand2, index) ->
    			"hand1"
    		index == 0 ->
    			"hand1"
    		true ->
    			tieBreakFlush(hand1, hand2, index-1)
  		end

	end

	def highSide(hand1, hand2) do
		hand1 = Enum.reverse(hand1 |> Enum.sort_by(&(String.to_integer(elem(&1,0)))))
		hand2 = Enum.reverse(hand2 |> Enum.sort_by(&(String.to_integer(elem(&1,0)))))
		cond do 
			((hand1) == []) ->
				"hand1"
			String.to_integer(elem((hd hand1),0)) > String.to_integer(elem((hd hand2),0)) ->
				"hand1"
			String.to_integer(elem((hd hand1),0)) < String.to_integer(elem((hd hand2),0)) ->
				"hand2"
			String.to_integer(elem((hd hand1),0)) == String.to_integer(elem((hd hand2),0)) ->
				highSide((tl hand1),(tl hand2))
		end
	end


	def tiePair(hand1, hand2) do
		pair1 = Enum.reverse(checkPair(hand1) |> Enum.sort_by(&(String.to_integer(elem(&1,0)))))
		pair2 = Enum.reverse(checkPair(hand2) |> Enum.sort_by(&(String.to_integer(elem(&1,0)))))
		cond do
			String.to_integer(elem((hd pair1),0)) > String.to_integer(elem((hd pair2),0)) ->
				"hand1"
			String.to_integer(elem((hd pair1),0)) < String.to_integer(elem((hd pair2),0)) ->
				"hand2"
			String.to_integer(elem((hd pair1),0)) == String.to_integer(elem((hd pair2),0)) ->
				highSide((hand1 -- pair1),(hand2 -- pair2)) 
		end
	end


	def tie2Pair(hand1, hand2) do
		pair1 = Enum.reverse(check2Pair(hand1) |> Enum.sort_by(&(String.to_integer(elem(&1,0)))))
		pair2 = Enum.reverse(check2Pair(hand2) |> Enum.sort_by(&(String.to_integer(elem(&1,0)))))
		cond do
			String.to_integer(elem((hd pair1),0)) > String.to_integer(elem((hd pair2),0)) ->
				"hand1"
			String.to_integer(elem((hd pair1),0)) < String.to_integer(elem((hd pair2),0)) ->
				"hand2"
			String.to_integer(elem((hd pair1),0)) == String.to_integer(elem((hd pair2),0)) ->
				cond do
					String.to_integer(elem((Enum.at(pair1,2)),0)) > String.to_integer(elem((Enum.at(pair2,2)),0)) ->
						"hand1"
					String.to_integer(elem((Enum.at(pair1,2)),0)) < String.to_integer(elem((Enum.at(pair2,2)),0)) ->
						"hand2"
					String.to_integer(elem((Enum.at(pair1,2)),0)) == String.to_integer(elem((Enum.at(pair2,2)),0)) ->
						highSide((hand1 -- pair1),(hand2 -- pair2)) 
				end 
		end
	end

	def tieThree(hand1, hand2) do
		cond do
			String.to_integer(elem((hd checkThree(hand1)),0)) > String.to_integer(elem((hd checkThree(hand2)),0)) ->
				"hand1"
			String.to_integer(elem((hd checkThree(hand1)),0)) < String.to_integer(elem((hd checkThree(hand2)),0)) ->
				"hand2"
			true ->
				highSide((hand1 -- checkThree(hand1)),(hand2 -- checkThree(hand2))) 
		end
	end

	def tieFour(hand1, hand2) do
		cond do
			String.to_integer(elem((hd checkFour(hand1)),0)) > String.to_integer(elem((hd checkFour(hand2)),0)) ->
				"hand1"
			String.to_integer(elem((hd checkFour(hand1)),0)) < String.to_integer(elem((hd checkFour(hand2)),0)) ->
				"hand2"
			true ->
				highSide((hand1 -- checkFour(hand1)),(hand2 -- checkFour(hand2))) 
		end
	end

	def tieFullHouse(hand1, hand2) do	
		cond do
			String.to_integer(elem((hd checkThree(hand1)),0)) > String.to_integer(elem((hd checkThree(hand2)),0)) ->
				"hand1"
			String.to_integer(elem((hd checkThree(hand1)),0)) < String.to_integer(elem((hd checkThree(hand2)),0)) ->
				"hand2"
			true ->
				hand1 = hand1 -- checkThree(hand1)
				hand2 = hand2 -- checkThree(hand2)
				cond do
				String.to_integer(elem((hd checkPair(hand1)),0)) > String.to_integer(elem((hd checkPair(hand2)),0)) ->
					"hand1"
				String.to_integer(elem((hd checkPair(hand1)),0)) < String.to_integer(elem((hd checkPair(hand2)),0)) ->
					"hand2"

				true -> 
					highSide((hand1 -- checkPair(hand1)),(hand2 -- checkPair(hand2))) 

				end
		end
	end


	def printflush(hand, suite) do
		suites = ["C", "D", "H", "S"]
		suite = Enum.at(suites, suite)
		Enum.map(hand, fn x -> "#{x}" <> suite end)

	end
    
    def royalFlush(hand) do
        cond do
        	[1,10,11,12,13] -- hand == [] ->
            	[1,10,11,12,13]
            [14,23,24,25,26] -- hand == [] ->
            	[14,23,24,25,26]
            [27,36,37,38,39] -- hand == [] ->
            	[27,36,37,38,39]
            [40,49,50,51,52] -- hand == [] ->
            	[40,49,50,51,52]
            true ->
            	"Not royalFlush"
        end
        
    end

    def straightFlush(hand) do
    	cond do
    		Enum.count(hand, fn x -> (div x-1,13)+1 == 1 end) >=5 ->
    			fl = Enum.filter(hand, fn x  -> (div x-1,13)+1 == 1 end)
    			straight(fl)
    		Enum.count(hand, fn x -> (div x-1,13)+1 == 2 end) >=5 ->
    			fl = Enum.filter(hand, fn x  -> (div x-1,13)+1 == 2 end)
    			straight(fl)
    		Enum.count(hand, fn x -> (div x-1,13)+1 == 3 end) >=5 ->
    			fl = Enum.filter(hand, fn x  -> (div x-1,13)+1 == 3 end)
    			straight(fl)
    		Enum.count(hand, fn x -> (div x-1,13)+1 == 4 end) >=5 ->
				fl = Enum.filter(hand, fn x  -> (div x-1,13)+1 == 4 end)
				straight(fl)
    		true ->
    			"Not Straight"
    	end

	end

    def flush(hand) do
    	cond do
    		Enum.count(hand, fn x -> (div x-1,13)+1 == 1 end) >=5 ->
    			ret = Enum.filter(hand, fn x  -> (div x-1,13)+1 == 1 end)
    			retflush(ret)
    		Enum.count(hand, fn x -> (div x-1,13)+1 == 2 end) >=5 ->
    			ret = Enum.filter(hand, fn x  -> (div x-1,13)+1 == 2 end)
    			retflush(ret)
    		Enum.count(hand, fn x -> (div x-1,13)+1 == 3 end) >=5 ->
    			ret = Enum.filter(hand, fn x  -> (div x-1,13)+1 == 3 end)
    			retflush(ret)
    		Enum.count(hand, fn x -> (div x-1,13)+1 == 4 end) >=5 ->
				ret = Enum.filter(hand, fn x  -> (div x-1,13)+1 == 4 end)
				retflush(ret)
    		true ->
    			"Not Flush"
    	end
	end

	def retflush(ret) do
    	cond do
    		Enum.count(ret) == 6 ->
    			if Enum.at(ret,0) == 1 || Enum.at(ret,0) == 14 || Enum.at(ret,0) == 27 || Enum.at(ret,0) == 40 do
    				List.delete_at(ret,1)
    			else
    				List.delete_at(ret,0)
    			end

    		Enum.count(ret) == 7 ->
    			if Enum.at(ret,0) == 1 || Enum.at(ret,0) == 14 || Enum.at(ret,0) == 27 || Enum.at(ret,0) == 40 do
    				ret = List.delete_at(ret,1)
    				List.delete_at(ret,2)
    			else
    				ret = List.delete_at(ret,0)
    				List.delete_at(ret,1)
    			end
    		true ->
    			ret
    	end   
	end

	def straight(hand) do
		handNums = Enum.map(hand, fn x -> (rem x-1,13)+1 end)
		handNums = Enum.sort(handNums)
		index = 4

		handNums = cond do
				Enum.at(handNums, 0) == 1 ->
					handNums ++ [14]
				true ->
					handNums
		end

		result = straight(handNums,index)
		cond do
			result == "Not Straight" ->
				"Not Straight"
			true ->
				cond do
					Enum.any?(result, fn x -> x == 14 end) ->
						result = result -- [14]
						[1] ++ result
					true ->
						result
				end
		end
	end

	def straight(handNums,index) do
		cond do
			index == -1 ->
				"Not Straight"
			true ->
				x = Enum.at(handNums,index)
				cond do
					([x,x+1,x+2,x+3,x+4] -- handNums) == [] ->
						[x,x+1,x+2,x+3,x+4]
					true ->
						straight(handNums, index-1)
				end
		end

	end

	def fullHouse(hand) do
		if checkThree(hand) != nil do
			if checkPair(hand -- checkThree(Enum.reverse((hand) |> Enum.sort_by(&(elem(&1,0)))))) != nil do
				checkThree(Enum.reverse((hand) |> Enum.sort_by(&(String.to_integer(elem(&1,0)))))) ++ checkPair(Enum.reverse((hand -- checkThree(Enum.reverse((hand) |> Enum.sort_by(&(String.to_integer(elem(&1,0)))))) |> Enum.sort_by(&(String.to_integer(elem(&1,0)))))))
			else
				nil
			end
		else
			nil
		end
	end
	
	def highCard(hand) do
		highCard((tl hand),[hd hand])
	end

	def highCard(hand,highC) do
		cond do
			(hand) == []->
				[hd highC]
			(String.to_integer(hd(Enum.map((hand), fn {a,_b} -> a end)))) > (String.to_integer(hd(Enum.map((highC), fn {a,_b} -> a end)))) ->
				highCard((tl hand),[hd hand])
			(String.to_integer(hd(Enum.map((hand), fn {a,_b} -> a end)))) <= (String.to_integer(hd(Enum.map((highC), fn {a,_b} -> a end)))) ->
				highCard((tl hand),[hd highC])
		end
	end

	def checkPair(hand) do
		if Enum.count(hand, fn {a,_b} ->  {a} == (hd (Enum.map((hand), fn {a,_b} -> {a} end)))end) == 2 do
			(Enum.map((Enum.filter(hand, fn {a,_b} -> {a} == (hd (Enum.map((hand), fn {a,_b} -> {a} end))) end)), fn x -> (x)end))
		else
			if ((tl hand) == []) do
				nil
			else
				checkPair((tl hand))
			end
		end
	end 

	def check2Pair(hand) do
		if Enum.count(hand, fn {a,_b} ->  {a} == (hd (Enum.map((hand), fn {a,_b} -> {a} end)))end) == 2 do
			check2Pair((hand -- Enum.map((Enum.filter(hand, fn {a,_b} -> {a} == (hd (Enum.map((hand), fn {a,_b} -> {a} end))) end)), fn x -> x end)),(Enum.map((Enum.filter(hand, fn {a,_b} -> {a} == (hd (Enum.map((hand), fn {a,_b} -> {a} end))) end)), fn x -> (x)end)))
		else
			if ((tl hand) == []) do
				nil
			else
				check2Pair((tl hand))
			end
		end
	end 

	def check2Pair(hand,fPair) do
		if (hand == []) do
			nil
		else
			if Enum.count(hand, fn {a,_b} ->  {a} == (hd (Enum.map((hand), fn {a,_b} -> {a} end)))end) == 2 do
				(Enum.map((Enum.filter(hand, fn {a,_b} -> {a} == (hd (Enum.map((hand), fn {a,_b} -> {a} end))) end)), fn x -> (x)end)) ++ fPair
			else
				if ((tl hand) == []) do
					nil
				else
					check2Pair((tl hand),fPair)
				end
			end
		end
	end

	def checkThree(hand) do
		if Enum.count(hand, fn {a,_b} ->  {a} == (hd (Enum.map((hand), fn {a,_b} -> {a} end)))end) == 3 do
			Enum.map((Enum.filter(hand, fn {a,_b} -> {a} == (hd (Enum.map((hand), fn {a,_b} -> {a} end))) end)), fn x -> (x)end)
		else
			if ((tl hand) == []) do
				nil
			else
				checkThree((tl hand))
			end
		end
	end 

	def checkFour(hand) do
		if Enum.count(hand, fn {a,_b} ->  {a} == (hd (Enum.map((hand), fn {a,_b} -> {a} end)))end) == 4 do
			Enum.map((Enum.filter(hand, fn {a,_b} -> {a} == (hd (Enum.map((hand), fn {a,_b} -> {a} end))) end)), fn x -> (x)end)
		else
			if ((tl hand) == []) do
				nil
			else
				checkFour((tl hand))
			end
		end
	end 

	def tupleConvert(hand) do
		handNums = Enum.map(hand, fn x -> to_string((rem x-1,13)+1) end)
		handNums = Enum.map(handNums, fn x -> ace(x) end)
        handsuit = Enum.map(hand, fn x -> (div x-1,13) end)
        suits = ["C", "D", "H", "S"]
        handsuit = Enum.map(handsuit, fn x -> Enum.at(suits, x) end)
        _hand = Enum.zip(handNums,handsuit)
	end

	def ace(x) do
		if x == "1" do
			"14"
		else
			if x == "14" do
				"1"
			else
				x
			end
		end
	end

	def result(hand) do
		(Enum.map(hand, fn {a,b} -> to_string(Tuple.to_list({ace(a),b})) end))
	end
end