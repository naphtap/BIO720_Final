#!/usr/bin/perl
use strict;
use warnings;

#Provides the directory to running fastqc program
my $fastqc = '/usr/local/fastqc/fastqc';

#Next set of lines asks for the directory containing the fastq files and where the fastqc output files will be placed.
print "Provide the directory containing the fastq files you want to process \n";
my $fastq_file_dir = <STDIN>;
chomp $fastq_file_dir;

print "Provide the output directory where the fastqc results will be placed \n";
my $output = <STDIN>;
chomp $output;

#Changes directory to that containing the fastq files and creates an array containing all the fastq files within the directory.
chdir $fastq_file_dir;
my @files = glob "$fastq_file_dir/*.fastq";
print @files;

#Runs the fastqc command on all the fastq files stored within the files array.
for my $sample (@files) {
  my $fastq = "$sample";
  print "$fastq\n";
  my $cmd = qq($fastqc -o $output $fastq);
  system $cmd;
	}
