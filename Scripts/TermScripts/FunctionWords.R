
isFunctionWord <- function(term){
  if(term == "e" || term == "em" || term == "uma" || term == "la" || 
       term == "your" || term == "if" || term == "me" || term == "de" || term == "no" ||
       term == "por" || term == "of" || term == "about" || term == "either" || term == "by" ||
       term == "da" || term == "na" || term == "in" || term == "era" || term == "you" ||
       term == "sua" || term == "do" || term == "nos" || term == "ao" || term == "nao" ||
       term == "be" || term == "suas" || term == "dos" || term == "nas" || term == "sobre" ||
       term == "ou" || term == "our" || term == "onde" || term == "das" || term == "para" ||
       term == "the" || term == "ser" || term == "quem" || term == "a" ||
       term == "com" || term == "se" || term == "entre" || term == "this" || term == "qual" ||
       term == "o" || term == "que" || term == "mais" || term == "sem" || term == "not" ||
       term == "my" || term == "as" || term == "como" || term == "sao" || term == "for" ||
       term == "are" || term == "meu" || term == "os" || term == "um" || term == "on" ||
       term == "to" || term == "here" || term == "aos"){
    return(1)
  } else{
    return(0)
  }
  
}