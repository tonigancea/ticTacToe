function [] = startGame()
tabla = ['- - -';'- - -';'- - -'];
newgame = ['---';'---';'---'];
disp("Welcome to Tic Tac Toe!");
disp("Who do you wanna be? Choose X or O.");
disp("You can exit anytime by pressing Q.");
disp("Remember that X starts first all the time. So, who do you wanna be?");
disp("X or 0?");
while 1
  player = input ("I want to play with ","s");
  player = toupper(player);
  if player != 'X' && player != 'O' && player != '0'
    disp("This input is not valid. Who do you wanna be, X or O?");
  else
    break
  endif
endwhile
[player computer] = play(player);
disp(tabla);
game = newgame;
nr = 0;
l = c = 0;
i = p = 0;
ok = 0;
z = 0;

while 1
  if computer == 'X' && z == 0
    game = computer_turn(game,player,computer);
    [tabla,game] = show(game);
    disp(tabla);
    z = 1;
  else
  endif
  
  l = input ("Pick the line: ","s");
  if l == 'q'
    l = toupper(l);
  endif
  if l == 'Q'
    disp("You left the game. Sayonara!");
    break;
  endif
  c = input ("Pick the column: ","s");
  if c == 'q'
    c = toupper(c);
  endif
  if c == 'Q'
    disp("You left the game. Sayonara!");
    break;
  endif
  l = str2num(l);
  c = str2num(c);
  if l>3 || c>3 || l<1 || c<1 || isvector(l) == 0 || isvector(c) == 0 || length(l) != 1 || length(c) != 1
     disp("Invalid input.");
  else
    if game(l,c) == 'X' || game(l,c) == 'O'
      disp("Sorry! That position is not available.");
      disp(tabla);
    else
      game(l,c) = player;
      [tabla,game] = show(game);
      disp(tabla);
      [i p ok] = check_if_win(game,player,computer,i,p,ok);
      if ok == 1 || ok == 2 || ok == 3
        [game,newgame,ok,tabla,z,player,computer] = new_session(game,newgame,ok,tabla,z,player,computer);
      endif
      if game == newgame
      else
        game = computer_turn(game,player,computer);
        [tabla,game] = show(game);
        disp(tabla);
        [i p ok] = check_if_win(game,player,computer,i,p,ok);
        if ok == 1 || ok == 2 || ok == 3
          [game,newgame,ok,tabla,z,player,computer] = new_session(game,newgame,ok,tabla,z,player,computer);
        endif
      endif
    endif
   endif
    
endwhile
endfunction

function [game,newgame,ok,tabla,z,player,computer] = new_session(game,newgame,ok,tabla,z,player,computer)
  game = newgame;
  ok = 0;
  z = 0;
  k = 0;
  [tabla,game] = show(game);
  while k == 0
    disp("Do who wanna play with another symbol?");
    aux = input("Type YEAH or NOPE ","s");
    aux = toupper(aux);
    if aux == 'NOPE'
      disp("The settings are the same. Enjoy!");
      k = 1;
      break
    endif
    if aux == 'YEAH'
      player = input ("I wanna play with ","s");
      player = toupper(player);
      [player computer] = play(player);
      k = 1;
    else
      disp("I don't get it ...");
      k = 0;
    endif
   endwhile
   disp(tabla);
endfunction

function [game k] = defence(game,k,player,computer)
  %cand oponentul e la un pas de a completa un castig, aceasta functie in blocheaza
  %castiguri blocate pe coloana
  if game(1,1) == player && game(2,1) == player && game(3,1) == '-'
    game(3,1) = computer;
    k = 1;
    return
  endif
  if game(1,1) == player && game(3,1) == player && game(2,1) == '-'
    game(2,1) = computer;
    k = 1;
    return
  endif
  if game(2,1) == player && game(3,1) == player && game(1,1) == '-'
    game(1,1) = computer;
    k = 1;
    return
  endif
  
  if game(1,2) == player && game(2,2) == player && game(3,2) == '-'
    game(3,2) = computer;
    k = 1;
    return
  endif
  if game(1,2) == player && game(3,2) == player && game(2,2) == '-'
    game(2,2) = computer;
    k = 1;
    return
  endif
  if game(2,2) == player && game(3,2) == player && game(1,2) == '-'
    game(1,2) = computer;
    k = 1;
    return
  endif
  
  if game(1,3) == player && game(2,3) == player && game(3,3) == '-'
    game(3,3) = computer;
    k = 1;
    return
  endif
  if game(1,3) == player && game(3,3) == player && game(2,3) == '-'
    game(2,3) = computer;
    k = 1;
    return
  endif
  if game(2,3) == player && game(3,3) == player && game(1,3) == '-'
    game(1,3) = computer;
    k = 1;
    return
  endif
  
  %castiguri blocate pe linie
  if game(1,1) == player && game(1,2) == player && game(1,3) == '-'
    game(1,3) = computer;
    k = 1;
    return
  endif
  if game(1,1) == player && game(1,3) == player && game(1,2) == '-'
    game(1,2) = computer;
    k = 1;
    return
  endif
  if game(1,2) == player && game(1,3) == player && game(1,1) == '-'
    game(1,1) = computer;
    k = 1;
    return
  endif
  
  if game(2,1) == player && game(2,2) == player && game(2,3) == '-'
    game(2,3) = computer;
    k = 1;
    return
  endif
  if game(2,1) == player && game(2,3) == player && game(2,2) == '-'
    game(2,2) = computer;
    k = 1;
    return
  endif
  if game(2,2) == player && game(2,3) == player && game(2,1) == '-'
    game(2,1) = computer;
    k = 1;
    return
  endif
  
  if game(3,1) == player && game(3,2) == player && game(3,3) == '-'
    game(3,3) = computer;
    k = 1;
    return
  endif
  if game(3,1) == player && game(3,3) == player && game(3,2) == '-'
    game(3,2) = computer;
    k = 1;
    return
  endif
  if game(3,2) == player && game(3,3) == player && game(3,1) == '-'
    game(3,1) = computer;
    k = 1;
    return
  endif
  
  %castiguri blocate pe diagonala
  if game(1,1) == player && game(2,2) == player && game(3,3) == '-'
    game(3,3) = computer;
    k = 1;
    return
  endif
  if game(1,1) == player && game(3,3) == player && game(2,2) == '-'
    game(2,2) = computer;
    k = 1;
    return
  endif
  if game(2,2) == player && game(3,3) == player && game(1,1) == '-'
    game(3,3) = computer;
    k = 1;
    return
  endif
  
  if game(1,3) == player && game(2,2) == player && game(3,1) == '-'
    game(3,1) = computer;
    k = 1;
    return
  endif
  if game(1,3) == player && game(3,1) == player && game(2,2) == '-'
    game(2,2) = computer;
    k = 1;
    return
  endif
  if game(2,2) == player && game(3,1) == player && game(1,3) == '-'
    game(1,3) = computer;
    k = 1;
    return
  endif
endfunction

function [game k] = blind_luck(game,k,computer)
  %daca se intampla ca sa fim la un pas de castig, aceasta functie se asigura de el
  %cautari pe coloana
  if game(1,1) == computer && game(2,1) == computer && game(3,1) == '-'
    game(3,1) = computer;
    k = 1;
    return
  endif
  if game(1,1) == computer && game(3,1) == computer && game(2,1) == '-'
    game(2,1) = computer;
    k = 1;
    return
  endif
  if game(2,1) == computer && game(3,1) == computer && game(1,1) == '-'
    game(1,1) = computer;
    k = 1;
    return
  endif
  
  if game(1,2) == computer && game(2,2) == computer && game(3,2) == '-'
    game(3,2) = computer;
    k = 1;
    return
  endif
  if game(1,2) == computer && game(3,2) == computer && game(2,2) == '-'
    game(2,2) = computer;
    k = 1;
    return
  endif
  if game(2,2) == computer && game(3,2) == computer && game(1,2) == '-'
    game(1,2) = computer;
    k = 1;
    return
  endif
  
  if game(1,3) == computer && game(2,3) == computer && game(3,3) == '-'
    game(3,3) = computer;
    k = 1;
    return
  endif
  if game(1,3) == computer && game(3,3) == computer && game(2,3) == '-'
    game(2,3) = computer;
    k = 1;
    return
  endif
  if game(2,3) == computer && game(3,3) == computer && game(1,3) == '-'
    game(1,3) = computer;
    k = 1;
    return
  endif
  
  %cautari pe linie
  if game(1,1) == computer && game(1,2) == computer && game(1,3) == '-'
    game(1,3) = computer;
    k = 1;
    return
  endif
  if game(1,1) == computer && game(1,3) == computer && game(1,2) == '-'
    game(1,2) = computer;
    k = 1;
    return
  endif
  if game(1,2) == computer && game(1,3) == computer && game(1,1) == '-'
    game(1,1) = computer;
    k = 1;
    return
  endif
  
  if game(2,1) == computer && game(2,2) == computer && game(2,3) == '-'
    game(2,3) = computer;
    k = 1;
    return
  endif
  if game(2,1) == computer && game(2,3) == computer && game(2,2) == '-'
    game(2,2) = computer;
    k = 1;
    return
  endif
  if game(2,2) == computer && game(2,3) == computer && game(2,1) == '-'
    game(2,1) = computer;
    k = 1;
    return
  endif
  
  if game(3,1) == computer && game(3,2) == computer && game(3,3) == '-'
    game(3,3) = computer;
    k = 1;
    return
  endif
  if game(3,1) == computer && game(3,3) == computer && game(3,2) == '-'
    game(3,2) = computer;
    k = 1;
    return
  endif
  if game(3,2) == computer && game(3,3) == computer && game(3,1) == '-'
    game(3,1) = computer;
    k = 1;
    return
  endif
  
  %cautari pe diagonala
  if game(1,1) == computer && game(2,2) == computer && game(3,3) == '-'
    game(3,3) = computer;
    k = 1;
    return
  endif
  if game(1,1) == computer && game(3,3) == computer && game(2,2) == '-'
    game(2,2) = computer;
    k = 1;
    return
  endif
  if game(2,2) == computer && game(3,3) == computer && game(1,1) == '-'
    game(3,3) = computer;
    k = 1;
    return
  endif
  
  if game(1,3) == computer && game(2,2) == computer && game(3,1) == '-'
    game(3,1) = computer;
    k = 1;
    return
  endif
  if game(1,3) == computer && game(3,1) == computer && game(2,2) == '-'
    game(2,2) = computer;
    k = 1;
    return
  endif
  if game(2,2) == computer && game(3,1) == computer && game(1,3) == '-'
    game(1,3) = computer;
    k = 1;
    return
  endif
endfunction

function [game] = computer_turn(game,player,computer);
k = 0;
disp("The Computer did his move.");
[game k] = blind_luck(game,k,computer);
if k == 1;
return
endif
[game k] = defence(game,k,player,computer);
if k == 1;
return
endif

if player == 'X'

if game(1,2) == player && game(3,3) == player && game(3,2) == computer && game(1,3) == '-' 
  game(1,3) = computer;
  return
endif
if game(1,1) == player && game(2,3) == player && game(2,1) == computer && game(1,3) == '-' 
  game(1,3) = computer;
  return
endif
if game(2,2) == player && game(3,3) == player && game(1,1) == computer && game(1,3) == '-' 
  game(1,3) = computer;
  return
endif
if game(1,1) == player && game(3,2) == player && game(2,2) == computer && game(2,1) == '-' 
  game(2,1) = computer;
  return
endif
if game(1,1) == player && game(2,3) == player && game(2,2) == computer && game(3,2) == '-' 
  game(3,2) = computer;
  return
endif
if game(1,3) == player && game(2,1) == player && game(2,2) == computer && game(1,2) == '-' 
  game(1,2) = computer;
  return
endif
if game(1,3) == player && game(3,1) == player && game(2,2) == computer && game(2,1) == '-' 
  game(2,1) = computer;
  return
endif
if game(3,2) == player && game(1,2) == '-' 
  game(1,2) = computer;
  return
endif
if game(2,3) == player && game(2,1) == '-' 
  game(2,1) = computer;
  return
endif
if game(1,2) == player && game(3,2) == '-' 
  game(3,2) = computer;
  return
endif
if game(2,1) == player && game(2,3) == '-' 
  game(2,3) = computer;
  return
endif
if game(3,3) == player && game(2,2) == '-' 
  game(2,2) = computer;
  return
endif
if game(3,1) == player && game(2,2) == '-' 
  game(2,2) = computer;
  return
endif
if game(1,3) == player && game(2,2) == '-' 
  game(2,2) = computer;
  return
endif
if game(1,1) == player && game(2,2) == '-' 
  game(2,2) = computer;
  return
endif

endif
if player == 'O'

if game(1,3) == computer && game(1,2) == player && game(2,3) == computer && game(3,3) == player && game(2,2) == '-'
  game(2,2) = computer;
  return
endif
if game(1,3) == computer && game(1,2) == player && game(2,3) == '-'
  game(2,3) = computer;
  return
endif
if game(1,3) == computer && game(1,1) == player && game(2,3) == '-'
  game(2,3) = computer;
  return
endif
if game(1,3) == computer && game(1,2) == '-' && game(2,2) == player
  game(1,2) = computer;
  return
endif
if game(1,3) == computer && game(1,2) == computer && game(1,1) == player && game(2,3) == player && game(2,2) == '-'
  game(2,2) = computer;
  return
endif
if game(1,3) == computer && game(1,2) == '-' && game(2,3) == player
  game(1,2) = computer;
  return
endif
if game(1,3) == computer && game(2,1) == player && game(3,3) == '-'
  game(3,3) = computer;
  return
endif
if game(1,1) == '-' && game(1,3) == computer && game(3,2) == player
  game(1,1) = computer;
  return
endif
if game(1,3) == computer && game(1,2) == '-' && game(3,3) == player
  game(1,2) = computer;
  return
endif
if game(1,3) == computer && game(2,3) == '-' && game(3,3) == '-' && game(3,1) == player
  game(3,3) = computer;
  return
endif
if game(2,2) != '-' && game(3,1) == player && game(1,3) == player
  game(2,3) = computer;
  return
endif
if game(2,2) == '-' && game(3,1) == player
  game(2,2) = computer;
  return
endif
if game(1,3) == '-'
  game(1,3) = computer;
  return
endif

endif

for t=1:3
  for j=1:3
    if game(t,j) == '-'
      game(t,j) = computer;
      return
    endif
  endfor
endfor
endfunction

function [i p ok] = check_if_win(game,player,computer,i,p,ok)
  %player wins
  if player == game(1,1) && player == game(1,2) && player == game(1,3)
    ok = 1;
  endif
  if player == game(2,1) && player == game(2,2) && player == game(2,3)
    ok = 1;
  endif
  if player == game(3,1) && player == game(3,2) && player == game(3,3)
    ok = 1;
  endif
  if player == game(1,1) && player == game(2,1) && player == game(3,1)
    ok = 1;
  endif
  if player == game(1,2) && player == game(2,2) && player == game(3,2)
    ok = 1;
  endif
  if player == game(1,3) && player == game(2,3) && player == game(3,3)
    ok = 1;
  endif
  if player == game(1,1) && player == game(2,2) && player == game(3,3)
    ok = 1;
  endif
  if player == game(1,3) && player == game(2,2) && player == game(3,1)
    ok = 1;
  endif
  %computer wins
  if computer == game(1,1) && computer == game(1,2) && computer == game(1,3)
    ok = 2;
  endif
  if computer == game(2,1) && computer == game(2,2) && computer == game(2,3)
    ok = 2;
  endif
  if computer == game(3,1) && computer == game(3,2) && computer == game(3,3)
    ok = 2;
  endif
  if computer == game(1,1) && computer == game(2,1) && computer == game(3,1)
    ok = 2;
  endif
  if computer == game(1,2) && computer == game(2,2) && computer == game(3,2)
    ok = 2;
  endif
  if computer == game(1,3) && computer == game(2,3) && computer == game(3,3)
    ok = 2;
  endif
  if computer == game(1,1) && computer == game(2,2) && computer == game(3,3)
    ok = 2;
  endif
  if computer == game(1,3) && computer == game(2,2) && computer == game(3,1)
    ok = 2;
  endif
  if ok != 1 && ok != 2
    aux = 0;
    for t=1:3
      for j=1:3
        if game(t,j) == '-'
          aux = 1;
        endif
      endfor
    endfor
    if aux == 0
      ok = 3;
    endif
  endif
  if ok == 1
    i = i+1;
    scor = sprintf("Player(%s): %d - Computer(%s): %d",player,i,computer,p);
    disp("You won this time. Scoreboard status:");
    disp(scor);
  endif
  if ok == 2
    p = p+1;
    scor = sprintf("Player(%s): %d - Computer(%s): %d",player,i,computer,p);
    disp("The Computer won this time. Scoreboard status:");
    disp(scor);
  endif
  if ok == 3
    scor = sprintf("Player(%s): %d - Computer(%s): %d",player,i,computer,p);
    disp("It was a tie. Scoreboard status:");
    disp(scor);
  endif
endfunction

function [player computer] = play(player)
if player == '0'
  player = 'O';
endif
if player == 'X'
  computer = 'O';
  disp("You will be X and the Computer will be O.");
  disp("You start.");
endif
if player == 'O'
  computer = 'X';
  disp("You will be O and the Computer will be X.");
  disp("The Computer starts.");
endif
endfunction

function [tabla,game] = show(game)
tabla(1,1) = game(1,1);
tabla(2,1) = game(2,1);
tabla(3,1) = game(3,1);
tabla(1,3) = game(1,2);
tabla(2,3) = game(2,2);
tabla(3,3) = game(3,2);
tabla(1,5) = game(1,3);
tabla(2,5) = game(2,3);
tabla(3,5) = game(3,3);
endfunction