#!/usr/bin/perl -w
=comment
Este script destina-se à verificação da credibilidade dos dados após a extração das pesquisas mobile.
Quando um problema é encontrado, este é adicionado a este ficheiro e chamado na altura da extração

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




