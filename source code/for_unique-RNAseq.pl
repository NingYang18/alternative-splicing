#!/usr/bin/perl
open (IN1, "<$ARGV[0]")||die "$!";
#open (OUT, ">$ARGV[1]")||die "$!";


while ($read = <IN1>){
	chomp $read;
	if ($read =~ /^\@SQ/){
		print "$read\n";
	} else {
		if ($read =~ /NH\:i\:(\d+)/){
			if ($1 == 1){
				if ($read =~ /nM\:i\:(\d+)/){
					if ($1 <= 3){
						@step = split (/\t/, $read);
						@m = ($step[5] =~ /(\d+)M/g);
						$all = 0;
						foreach $m(@m){
							$all = $all + $m;
						}
						if ($all >=30 && $step[2] !~ /spike\_in/){
							print "$read\n";
						} else {
							#print "$read\n";
						}
					}
				}
			}
		}
	}
}

