use strict;use warnings;
my $data={};                               # hash for collecting data
while(<>){
	my ($city,$temp)=split(';');             # get city and temperature 
	$temp=~s/\.//;                           # remove decimal point
	use integer;                             # speeds up by 10%
	if ($data->{$city}){
		my $cd=$data->{$city};                 # create a local copy to speed up access for calculations
		 if ($temp>$cd->{max}){                # max
			 $cd->{max}=$temp;
		 }
		 elsif ($temp<$cd->{min}){             # min
			 $cd->{min}=$temp;
		}
		$cd->{mean}=($cd->{number}*$cd->{mean}+$temp)/($cd->{number}+1);  # mean
		$cd->{number}++;                       # count
	}
	else {
		$data->{$city}={max=>$temp,min=>$temp,mean=>$temp,number=>1} # initialise city
	}
}

print"{";
for (sort keys %$data){                   # print results
	my $cd=$data->{$_};
	print $_,";",$cd->{min}/10,"/",($cd->{mean}+5)/10,"/",$cd->{max}/10,", ";
}
print"}\n\n";
