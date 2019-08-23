function [] = joc()
tabla = ['- - -';'- - -';'- - -'];
newgame = ['---';'---';'---'];
disp("Bun venit la X si 0.");
disp("Alege cu ce sa joci. Apasa X sau O.");
disp("Poti oricand sa iesi prin apasarea tastei Q.");
disp("Nu uita ca X incepe primul. Deci ce sa fie?");
disp("X sau 0?");
while 1
  player = input ("Vreau sa joc cu ","s");
  player = toupper(player);
  if player != 'X' && player != 'O' && player != '0'
    disp("Nu ai introdus o intrare valida. Cu ce simbol vrei sa joci?");
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
  
  l = input ("Alege linia: ","s");
  if l == 'q'
    l = toupper(l);
  endif
  if l == 'Q'
    disp("Ai parasit jocul. La revedere!");
    break;
  endif
  c = input ("Alege coloana: ","s");
  if c == 'q'
    c = toupper(c);
  endif
  if c == 'Q'
    disp("Ai parasit jocul. La revedere!");
    break;
  endif
  l = str2num(l);
  c = str2num(c);
  if l>3 || c>3 || l<1 || c<1 || isvector(l) == 0 || isvector(c) == 0 || length(l) != 1 || length(c) != 1
     disp("Valori incorecte");
  else
    if game(l,c) == 'X' || game(l,c) == 'O'
      disp("Pozitia nu este disponibila");
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
    disp("Vrei sa joci cu alt simbol?");
    aux = input("Scrie DA sau NU ","s");
    aux = toupper(aux);
    if aux == 'NU'
      disp("Setarile au ramas la fel. Enjoy!");
      k = 1;
      break
    endif
    if aux == 'DA'
      player = input ("Vreau sa joc cu ","s");
      player = toupper(player);
      [player computer] = play(player);
      k = 1;
    else
      disp("Nu am inteles...");
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
disp("Computerul si-a facut mutarea.");
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
    disp("Tu ai castigat aceasta runda. Scorul este:");
    disp(scor);
  endif
  if ok == 2
    p = p+1;
    scor = sprintf("Player(%s): %d - Computer(%s): %d",player,i,computer,p);
    disp("Computerul a castigat aceasta runda. Scorul este:");
    disp(scor);
  endif
  if ok == 3
    scor = sprintf("Player(%s): %d - Computer(%s): %d",player,i,computer,p);
    disp("Aceasta runda a fost la egalitate. Scorul este:");
    disp(scor);
  endif
endfunction

function [player computer] = play(player)
if player == '0'
  player = 'O';
endif
if player == 'X'
  computer = 'O';
  disp("Tu vei juca cu X iar computerul va juca cu 0.");
  disp("Tu incepi primul.");
endif
if player == 'O'
  computer = 'X';
  disp("Tu vei juca cu O iar computerul va juca cu X.");
  disp("Computerul incepe primul");
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