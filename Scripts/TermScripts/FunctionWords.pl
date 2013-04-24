#!/usr/bin/perl -w
sub isFunctionWord {
    $term = shift;
    return ($term eq "e" || $term eq "em" || $term eq "uma" || $term eq "uma" || $term eq "la" || 
       $term eq "your" || $term eq "if" || $term eq "me" || $term eq "de" || $term eq "no" ||
       $term eq "por" || $term eq "of" || $term eq "about" || $term eq "either" || $term eq "by" ||
       $term eq "da" || $term eq "na" || $term eq "in" || $term eq "era" || $term eq "you" ||
       $term eq "sua" || $term eq "do" || $term eq "nos" || $term eq "ao" || $term eq "nao" ||
       $term eq "be" || $term eq "suas" || $term eq "dos" || $term eq "nas" || $term eq "sobre" ||
       $term eq "ou" || $term eq "our" || $term eq "onde" || $term eq "das" || $term eq "para" ||
       $term eq "the" || $term eq "onde" || $term eq "ser" || $term eq "quem" || $term eq "a" ||
       $term eq "com" || $term eq "se" || $term eq "entre" || $term eq "this" || $term eq "qual" ||
       $term eq "o" || $term eq "que" || $term eq "mais" || $term eq "sem" || $term eq "not" ||
       $term eq "my" || $term eq "as" || $term eq "como" || $term eq "sao" || $term eq "for" ||
       $term eq "are" || $term eq "meu" || $term eq "os" || $term eq "um" || $term eq "on" ||
       $term eq "to" || $term eq "here" || $term eq "aos");
}

1;


