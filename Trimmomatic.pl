#!/usr/bin/perl -w
use strict;
use warnings;

#Provides directory to run Trimmomatic 0.33
my $trimmomatic = '/usr/local/trimmomatic/trimmomatic-0.33.jar';

#Next set of lines asks the user to provide the parameters for running Trimmomatic
print "Please provide the directory containing the merged fastq files from your sequencing run: \n";
my $fastq_merged_dir = <STDIN>;
chomp $fastq_merged_dir;

print "Provide the quality value for removing leading low quality bases: \n";
my $leading = <STDIN>;
chomp $leading;

print "Provide the quality value for removing trailing low quality bases: \n";
my $trailing = <STDIN>;
chomp $trailing;

print "Now provide the sliding window where Trimmomatic will scan for low-quality nucleotides: \n";
my $sliding_window = <STDIN>;
chomp $sliding_window;

#Sorts all fastq files into an array called files
my @files = glob "$fastq_merged_dir/*.fastq";

#Runs trimmomatic with all fastq files stored in the array.
for my $sample (@files) {
        my $fastq = "$sample";
        print "$fastq\n";
        my $cmd = `java -jar "$trimmomatic" SE -phred33 "$fastq" LEADING:"$leading" TRAILING:"$trailing" SLIDINGWINDOW:"$sliding_window":15`;
        system $cmd;
        }
