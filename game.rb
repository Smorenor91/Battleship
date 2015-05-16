#!/usr/bin/ruby
require 'matrix'

class Matrix
  def to_readable
    i = 0
    self.each do |number|
      print number.to_s + " "
      i+= 1
      if i == self.column_size
        print "\n"
        i = 0
      end
    end
  end
  def []= (row, column, value)
  	@rows[row][column] = value
  end
end

class Board
  def initialize()
    @board = Matrix.build(11,11) {|row, col| "[ ]"}
    for i in 1..10
      @board[0,i] = "[#{i}]"
      @board[i,0] = "[#{i}]"
    end

  end

  def printAll()
    for i in 0..11
      for j in 0..11
        print @board[i,j]
      end
      puts ""
    end
  end

  def putsShips(x, y, n, o, l)
    l = l.to_i
    x = x.to_i
    y = y.to_i
    if(@board[x.to_i,y.to_i] == "[ ]")
      if(o == "V")
        if(x+l >= 11)
          puts "Error, espacio inadecuado"
          return true
        end
        for i in 0..l
          if(@board[i+x,y] != "[ ]")
            puts "Espacio ya ocupado"
            return true
          end
        end
       
      else(o =="H")
        if(y+l >= 11)
          puts "Error, espacio inadecuado"
          return true
        end
        for i in 0..1
          if(@board[x,y+1] != "[ ]")
            puts "Espacio ya ocupado"
            return true
          end
        end
      end
    else
      puts "Espacio ya ocupado"
      return true
    end
    puts "SI JALO"
    if(o == "V")
      for i in 0..l
        @board[x+i,y] = "[#{n}]"
      end
    else(o =="H")
      for i in 0..l
        @board[x, y+i] = "[#{n}]"
      end
    end


    return false
  end
end

$myBoard = Board.new()
$enemyBoard = Board.new()

$myBoard.printAll
varLetra=0
varNumero=0
orientacion= ""
shipList = []
shipList[0]= "Lancha"
shipList[1]= "Avance"
shipList[2]= "Batalla"
shipList[3]= "Destructor"
shipList[4]= "Transportador"

letterList = []
letterList[0]= "L"
letterList[1]= "A"
letterList[2]= "B"
letterList[3]= "D"
letterList[4]= "T"

for i in 0..4
  acepta = true
  while acepta do
    rest= 5-i
    puts "Tienes  #{rest}  unidades que escojer:"
    puts "Donde quieres poner el #{shipList[i]}"
    puts "Eje X"
    varLetra = gets
    varLetra.to_i
    puts "Eje Y"
    varNumero = gets
    varNumero.to_i
    puts "Orientacion (V/H)"
    orientacion= gets.chomp
    l = i + 1 
    acepta =$myBoard.putsShips(varLetra, varNumero, letterList[i], orientacion, l)
  end  
  $myBoard.printAll
end
