#!/usr/bin/perl
open (IN, "<$ARGV[0]")||die "$!";
#open (OUT, ">$ARGV[1]")||die "$!";

while ($read = <IN>){
	$f++;
	if (($f % 100000) == 1){
		#print "$f\t$merg\n";	
	}
	chomp $read;
	if ($read =~ /^\@SQ/){
		print "$read\n";
	} else {
		if ($read !~ /XA\:Z\:/ && $read !~ /SA\:Z\:/){
			@step = split (/\t/, $read);
			@m = ($step[5] =~ /(\d+)M/g);
			$all = 0;
			foreach $m(@m){
				$all = $all + $m;
			}
			if ($all >= 20 && $step[4] >= 30 && $read =~ /NM\:i\:(\d+)/){
				$misn = $1;
				if ($misn <= 5 && !exists $hash{$step[9]} && $step[2] !~ /chrM/){
					print "$read\n";
					$hash{$step[9]} = 0;					
				}
			}
		}
	}
}

