#!/usr/bin/perl -w

=comment
Script para retirar as queries mobile a partir do dataset SAPO original

Recolhidas as informações sobre:
    -data
    -ip
    -browser
    -query
    -cidade
    -pais
    
Ricardo Cunha @ 2013
=cut
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "checkDeviceType.pl";
#require "browserRegex.pl";
%currentQuery = ();


use HTML::Entities;
use Encode;

sub checkQueryFormat {
    $query = shift;
    
    $query =~ s/^\s+//; #remove leading WS
    $query =~ s/\s+$//; #remove trailing WS
    
    return $query;
}

sub queryToString {
    my $output = "<query>\n";
    $output .= "<date>" . $currentQuery{"date"} . "</date>\n";
    $output .= "<ip>" . $currentQuery{"ip"} . "</ip>\n";
    $output .= "<browser>" . $currentQuery{"browser"} . "</browser>\n";
    $output .= "<keywords>" . $currentQuery{"query"} . "</keywords>\n";
    $output .= "<city>" . $currentQuery{"city"} . "</city>\n";
    $output .= "<country>" . $currentQuery{"country"} . "</country>\n";
    $output .= "</query>\n\n";
    
    return $output;
}

use feature qw/switch/; 

sub main{
    my $counter = 0;
    my $mobileDevices = 0;
    my $isMobile = 0; #boolean
    open(FILE, ">mobileDataSet.txt");
    while($_ = <STDIN>){
        #data
        given($_){
            
            #start notification
            when($_ =~ m/^<notification/){
                #clear current hash
                undef(%currentQuery);
                $isMobile = 0;
            }
            
            #end notification
            when($_ =~ m/<\/notification>$/){
                #send info to file
                if($isMobile){
                    my $output = queryToString();
                    print FILE $output;
                }
            }
            #date
            when($_ =~ m/^<date>(.*?)<\/date>$/){
                $currentQuery{"date"} = $1;
            }
            
            #ip
            when($_ =~ m/^<ip>(.*?)<\/ip>$/){
                $currentQuery{"ip"} = $1;
            }
            
            #browser
            when($_ =~ m/^<browser/){
                if($_ =~ m/^<browser>(.*?)<\/browser>$/){
                   $currentQuery{"browser"} = $1;
                   $type = getDeviceType($1);
                   #print $type. "\n";
                   if($type != NOTMOBILE){
                        $isMobile = 1;
                        $mobileDevices++;
                   }
                }
                $counter++;
                #print "$counter\n";
                
              #  $currentQuery{"browser"} = "EMPTY";
            }
            
            #query
            when($_ =~ m/^<keywords/){
                if($_ =~ m/^<keywords>(.*?)<\/keywords>$/){
                    if($1 ne ""){
                        $query = decode_entities($1); #from HTML::Entities
                        $query = checkQueryFormat($query);
                        #print "$string\n";
                    } else {
                        $query = "EMPTY";
                    }
                }
            
                elsif($_ =~ m/^<keywords \/>/){ 
                    $query = "EMPTY";
                } else { #prints lines that end with \n
                  #  print "$_\n";
                }
                
                $currentQuery{"query"} = $query;
            }
            
            #city
            when($_ =~ m/^<city/){
                if($_ =~ m/^<city>(.*?)<\/city>$/){
                    $city = ($1 ne "") ? $1 : "EMPTY";
                }
                else{ #prints lines that end with \n
                    $city = "EMPTY";
                }
                
                
                $currentQuery{"city"} = $city;
                
            }
            
            #country
            when($_ =~ m/^<country/){
                if($_ =~ m/^<country>(.*?)<\/country>$/){
                    $country = ($1 ne "") ? $1 : "EMPTY";
                }
                else{ #prints lines that end with \n
                    $country = "EMPTY";
                }
                
                $currentQuery{"country"} = $country;
            }
            
            default {continue;}
        }
 
    }
    print "Number of total queries: $counter\n";
    print "Number of total mobile queries: $mobileDevices\n"; 
    close(FILE);
}

main;


