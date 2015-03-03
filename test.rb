    

    def promote_pawn(color)
      done = false
      while !done
        print "#{color}'s pawn has been promoted. Which piece do you select? (q, r, b, n) :"
        choice = gets.chomp.downcase # what is wrong with this????
        if choice[0] == 'q'
          result = 'Q'
          done = true
        elsif choice[0] == 'r'
          result = 'R'
          done = true
        elsif choice[0] == 'b'
          result = 'B'
          done = true
        elsif choice[0] == 'n'
          result = 'K'
          done = true
        end
      end
      result
    end


    puts "#{promote_pawn(:white)}"