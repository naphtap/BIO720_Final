#!/usr/bin/perl
use strict;
use warnings;

#This sets of lines asks the user to provide the parameters for running BLASTN
my $blast = "/usr/local/blast/2.2.29/bin/blastn";
print "Provide the name of the database you will use for your BLAST run as a directory \n";

my $database = <STDIN>;
chomp $database;

print "Provide the directory containing the query files for your BLAST run \n";
my $query = <STDIN>;
chomp $query;

print "Provide the evalue for your BLAST run \n";
my $evalue = <STDIN>;
chomp $evalue;

#print "Provide the output format as an integer \n";
#my $format = <STDIN>;
#chomp $format;

#Changes directory to that containing the query sequences in fasta format and outputs the amount of fasta files to be processed
my @queryfiles = glob "$query/*.fasta";

my $numelements = @queryfiles;
print "Now processing $numelements fasta files for the BLAST run \n";

#Changes directory to match the user's input and runs BLAST with the fasta files.
chdir $query;

for my $sample (@queryfiles) {
	my $fasta = "$sample";
	print $fasta;
	my $cmd = qq("$blast" -query "$fasta" -db "$database" -out "$fasta".blastn -evalue "$evalue" -num_threads 6 &);
	system $cmd;
}	
