#! /usr/bin/env perl

# First naive attempt at this problem. Runs in around 35m on my machine (an Intel NUC).

use Modern::Perl '2015';
use List::Util qw/min max sum/;
###
use utf8;
binmode(STDOUT, ':encoding(UTF-8)');
binmode(STDIN, ':encoding(UTF-8)');
my $Data;
while (<>) {
    chomp;
    my ( $city, $temp ) = split(/;/, $_ );
    if ($Data->{$city}) {
	$Data->{$city}{min} = $temp if $temp < $Data->{$city}{min};  # min
	$Data->{$city}{sum} = $Data->{$city}{sum}+=$temp;
	$Data->{$city}{max} = $temp if $temp > $Data->{$city}{max};  # max
	$Data->{$city}{count}++;
		   
	    
    } else {

	#                   min,  avg,   max, count
	$Data->{$city} = {min=>$temp, max=>$temp ,sum=>$temp, count=>1};
    } 
}

my @results;
for my $city (sort {$a cmp $b} keys %$Data){
    my $avg = $Data->{$city}{sum}/$Data->{$city}{count};
    push @results, "$city=".join('/', map {sprintf("%.1f", $_)} ($Data->{$city}{min}, $avg, $Data->{$city}{max}));
   
}
say '{'.join(', ',@results).'}';
