#!/usr/bin/perl -w
=comment
Este script destina-se � verifica��o da credibilidade dos dados ap�s a extra��o das pesquisas mobile.
Quando um problema � encontrado, este � adicionado a este ficheiro e chamado na altura da extra��o

Os seguintes problemas encontrados encontram-se implementados neste ficheiro:
    - 
    
Ricardo Cunha @ 2013
=cut

sub main {
    $boolean = 0;
    while($_ = <STDIN>){
        if($_ =~ m/^<date>20100131224701<\/date>/i){
            $boolean = 1;
        }
        if($_ =~ m/^<keywords/i && ($boolean == 1)){
            print "$_\n";
            return;
        }

    }
}


main;




