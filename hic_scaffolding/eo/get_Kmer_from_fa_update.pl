#!/usr/bin/perl

die("Usage: perl $0 <fasta file> <Kmer_length>\n") if @ARGV != 2;

open IN, "<$ARGV[0]";
open OUT, ">$ARGV[0]_$ARGV[1].kmer";

%sequence;
while(<IN>){
	chomp;
	if(/^>/){
		s/^>//;
		$seq_name = $_;
	}
	else {
		$sequence{$seq_name}.=$_;
	}
}
close IN;

foreach $i (keys %sequence) {
	$num = length($sequence{$i})-$ARGV[1];
	foreach $j (0..$num){
		print OUT ">".$i."_".$j."\n";
		print OUT substr($sequence{$i},$j,$ARGV[1])."\n";
	}
}

close OUT;
