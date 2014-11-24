class BingoCheckerFinal
	
	def initialize (board)
		@board = board
		@key = Array.new(board.length, 'x')
	end

	def check_board
		 in_row? || in_column? || in_descending_diagonal? || in_ascending_diagonal? ? (puts "BINGO!") : (puts "SORRY!")
	end
	
	private

	attr_reader :board, :key

	def in_row?
		board.any? {|row| row == key}
	end

	def in_column?
		board.transpose.any? {|column| column == key}
	end

	def in_descending_diagonal?
		board.each_with_index.map {|row, index| row[index]} == key
	end
			
	def in_ascending_diagonal?
		board.each_with_index.map {|row, index| row[-1 - index]} == key
	end
	
end

#***************************************** NOTE *****************************************
#  The above is our refactored solution, the tutorial below will take us to this build! #
#                                      Follow along!                                    #
#****************************************************************************************

=begin 
Given a bingo board , I want check for a BINGO and print "BINGO!" on success else "SORRY!"
 
1. Create the class

 class BingoChecker
 	def initialize(board)
 		@board = board
 	end
 end

2. There are four lines of x's that can return us a BINGO!: column, row, and each diagonal; 
	a. For each of these directions, lets make an individual method that returns true or false if it found a bingo
	b. If any of these cases are true we have get a "BINGO!" else "SORRY!". 
3. Let's create our end-game method, following our above logic

 def check_board
 		if in_row? || in_column? || in_descending_diagonal? || in_ascending_diagonal?
 			puts "BINGO!"
 		else
 			puts "SORRY!"
 		end
 end

4. Cool, this code isnt going to work yet, so lets get each method working one at a time.
5. Let's start with the easiest, in_row?. Within the nested array, @board, each element is an array; therefore if any of these are row of x's, BINGO!
6. Let's also make a @key in our initialize to define our winnig BINGO ['x','x','x','x','x'] so we can compare returns easily throughout the program

 def initialize (board)
 		@board = board
 		@key = ['x','x','x','x','x']
 end

7. Now lets iterate through @board and see if any of the rows match our new @key

 def in_row?
 	@board.each do |row|
 		if row == @key
 			return true
 		end
		end
 	false
 end

8. Make some simple checks and we now move to in_column?

 row_test_1 = BingoChecker.new( [[47, 44, 71, 8, 88],['x', 'x', 'x', 'x', 'x'],[83, 85, 97, 89, 57],[25, 31, 96, 68, 51],[75, 70, 54, 80, 83]])
 row_test_2 = BingoChecker.new( [[47, 44, 71, 8, 88],['x', 'x', 'x', 'x', '31'],[83, 85, 97, 89, 57],[25, 31, 96, 68, 51],[75, 70, 54, 80, 83]])

 puts "test1 should return true: ", row_test_1.in_row? == true
 puts "test2 should return false: ", row_test_2.in_row? == true

9. Wouldn't it be cool if we could just flip the array so columns became rows?  I mean we have a rows logic...
10. TRANSPOSE, http://www.ruby-doc.org/core-2.1.5/Array.html#method-i-transpose; lets use our same logic from rows and done.

 def in_column?
 		@board.transpose.each do |column|
 			if column == @key
 				return true
 			end
 		end
 		false		
 end

 col_test_1 = BingoChecker.new([[47, 44, 71, 'x', 88],[22, 69, 75, 'x', 73],[83, 85, 97, 'x', 57],[25, 31, 96, 'x', 51],[75, 70, 54, 'x', 83]])
 col_test_2 = BingoChecker.new([[47, 44, 71, 12, 88],[22, 69, 75, 'x', 73],[83, 85, 97, 'x', 57],[25, 31, 96, 'x', 51],[75, 70, 54, 'x', 83]])

 puts "test1 should return true: ", col_test_1.in_column? == true
 puts "test2 should return false: ", col_test_2.in_column? == true

11. in_descending_diagonal?, is the diagonal starting in the top left corner going down to the bottom right. IE @board[0][0], @board[1][1], @board[2][2]...
12. If I iterate over each row, I want to grab the element whose index matches the current rows index. IE row[0], row[1], row[2]...  (row in each instance is the new set of values derived from @board.each do |row|)
	a  Then I want to compare these accumulated values to @key and see if I have a match
13. We need something that can manage the row and it's index; also returning me an array at the end would be cool too, so I wouldnt have create one and push my findings in it
14. Just in luck, Map returns me an array and each_with_index lets me manage my row AND index!

 def in_descending_diagonal?
 	if @board.each_with_index.map {|row, index| row[index]} == @key
  		true
	 	else
	 		false
	 	end
 end

 dec_diag_test_1 = BingoChecker.new([['x', 44, 71, 8, 88],[22, 'x', 75, 65, 73],[83, 85, 'x', 89, 57],[25, 31, 96, 'x', 51],[75, 70, 54, 80, 'x']])
 dec_diag_test_2 = BingoChecker.new([[1, 44, 71, 8, 88],[22, 'x', 75, 65, 73],[83, 85, 'x', 89, 57],[25, 31, 96, 'x', 51],[75, 70, 54, 80, 'x']])

 puts "test1 should return true: ", dec_diag_test_1.in_descending_diagonal? == true
 puts "test2 should return false: ", dec_diag_test_2.in_descending_diagonal? == true

15. in_ascending_diagonal? does is similar except this time when I'm looking at a row, I want to start from the LAST element in that row and move to the first. IE @board[0][4], @board[1][3], @board[2][2]...
16. Since each_with_index lets me play with 0,1,2,3,4  and I basically need row[4], row[3], row[2]... I can start my value at 4 and SUBTRACT the index

 def in_ascending_diagonal?
 	if @board.each_with_index.map {|row, index| row[4-index]} == @key
  		true
	 	else
	 		false
	 	end
 end

 inc_diag_test_1 = BingoChecker.new([[13, 14, 86, 1, 'x'],[33, 88, 25, 'x', 3],[21, 17, 'x', 41, 32],[1, 'x', 26, 73, 36],['x', 60, 6, 10, 42]])
 inc_diag_test_2 = BingoChecker.new([[13, 14, 86, 1, 'x'],[33, 88, 25, 'x', 3],[21, 17, 'x', 41, 32],[1, 'x', 26, 73, 36],[1, 60, 6, 10, 42]])

17. Full circle now. We have 4 methods which we know work and one method that calls each to see if any are true. Let's run some sample boards.

 SORRY
 ----------
 board5 = BingoChecker.new([[13, 14, 86, 1, 'x'],[33, 88, 25, 'x', 3],[21, 17, 'x', 41, 32],[1, 'x', 26, 73, 36],[1, 60, 6, 10, 42]])
 board6 = BingoChecker.new([[1, 44, 71, 8, 88],[22, 'x', 75, 65, 73],[83, 85, 'x', 89, 57],[25, 31, 96, 'x', 51],[75, 70, 54, 80, 'x']])
 board7 = BingoChecker.new([[47, 44, 71, 12, 88],[22, 69, 75, 'x', 73],[83, 85, 97, 'x', 57],[25, 31, 96, 'x', 51],[75, 70, 54, 'x', 83]])
 board8 = BingoChecker.new( [[47, 44, 71, 8, 88],['x', 'x', 'x', 'x', '31'],[83, 85, 97, 89, 57],[25, 31, 96, 68, 51],[75, 70, 54, 80, 83]])
 puts "Should see 4 SORRY!"
  board5.check_board
  board6.check_board
  board7.check_board
  board8.check_board

  BINGO!
  ----------
 board1 = BingoChecker.new([[13, 14, 86, 1, 'x'],[33, 88, 25, 'x', 3],[21, 17, 'x', 41, 32],[1, 'x', 26, 73, 36],['x', 60, 6, 10, 42]]) 
 board2 = BingoChecker.new([['x', 44, 71, 8, 88],[22, 'x', 75, 65, 73],[83, 85, 'x', 89, 57],[25, 31, 96, 'x', 51],[75, 70, 54, 80, 'x']])
 board3 = BingoChecker.new( [[47, 44, 71, 8, 88],['x', 'x', 'x', 'x', 'x'],[83, 85, 97, 89, 57],[25, 31, 96, 68, 51],[75, 70, 54, 80, 83]])
 board4 = BingoChecker.new([[47, 44, 71, 'x', 88],[22, 69, 75, 'x', 73],[83, 85, 97, 'x', 57],[25, 31, 96, 'x', 51],[75, 70, 54, 'x', 83]])
 puts "Should see 4 BINGO!"
  board1.check_board
  board2.check_board
  board3.check_board
  board4.check_board

=end

#18. Our final product
class BingoChecker
	
	def initialize(board)
 		@board = board
 		@key = ['x','x','x','x','x']
	end

 	def check_board
 		if in_column? || in_row? || in_descending_diagonal? || in_ascending_diagonal?
 			puts "BINGO!"
 		else
 			puts "SORRY!"
 		end
 	end

	def in_row?
	 	@board.each do |row|
	 		if row == @key
	 			return true
	 		end
		end
	 	false
	end

 	def in_column?
 		@board.transpose.each do |column|
 			if column == @key
 				return true
 			end
 		end
 		false		
 	end

	def in_descending_diagonal?
		if @board.each_with_index.map {|row, index| row[index]} == @key
			true
 		else
 			false
 		end
	end

	def in_ascending_diagonal?
		if @board.each_with_index.map {|row, index| row[4-index]} == @key
			true
 		else
 			false
 		end
	end
end

#19. Refactoring - Our major goal is to eliminate repition with either improved logic/methods

#20. We are calling @board and @key throughout our class, though accessing these variables would be better left for an attr_reader so we can communicate our intent.
#ANSWER:  Add ->  attr_reader :board, :key  before our initialize and replace all instance variables with their new method.

#21. Right now we have to tell the board what our key is, we can instead generate it from its creation so if we end up with a 6x6 board we don't have to change our code.
#ANSWER: Replace -> Array.new(board.length, 'x') for ['x','x','x','x','x']

#22. TERENARY! checkboard is a pretty long arguement and is accepteble leaving as is, though familiarizing with this syntax is a great idea
#ANSWER: Change check_board to -> in_row? || in_column? || in_descending_diagonal? || in_ascending_diagonal? ? (puts "BINGO!") : (puts "SORRY!")

#23. in_row? is checking the array to see if it has a value within it and returning a true/false.  Going to the ruby array docs and hunting around should lead you to .include? which takes an arguement and checks if it's in the array to return true/false.  Perfect!
#ANSWER: Change in_row? to -> board.any? {|row| row == key}

#24. same thing for in_column?
#ANSWER: Change in_column? to -> board.transpose.any? {|column| column == key}

#25. A cool thing about comparison's is that they inherintly return true or false; therefore saying "If this thing returns me true, return me true" is a little reduntant.
#ANSWER: Change both in_descending_diagonal? and in_ascending_diagonal? to a simple conditional
# in_descending_diagonal -> board.each_with_index.map {|row, index| row[index]} == key
# in_ascending_diagonal -> board.each_with_index.map {|row, index| row[4-index]} == key

#26. Right now our in_ascending_diagonal method is dependent on the board being 5 across so we can eliminate this dependency and retain the logic by usng -1, which represents the last element in the array and subtracting it furter takes you to the 2nd last element and so forth.
#ANSWER: Change row[4-index] to -> row[-1 - index]

#27. Final touch, let's put our 4 methods and readers within the private scope so our class only exposes the check_board method to the outside world
#ANSWER: Type private after our check_board method and place the four in_xxx? methods and attr_readers below it.

#28. Final Product

class BingoCheckerRefactored
	
	def initialize (board)
		@board = board
		@key = Array.new(board.length, 'x')
	end

	def check_board
		 in_row? || in_column? || in_descending_diagonal? || in_ascending_diagonal? ? (puts "BINGO!") : (puts "SORRY!")
	end
	
	private

	attr_reader :board, :key

	def in_row?
		board.any? {|row| row == key}
	end

	def in_column?
		board.transpose.any? {|column| column == key}
	end

	def in_descending_diagonal?
		board.each_with_index.map {|row, index| row[index]} == key
	end
			
	def in_ascending_diagonal?
		board.each_with_index.map {|row, index| row[-1 - index]} == key
	end
	
end

#29. AND BINGO WAS HIS NAME-O!

 