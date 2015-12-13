#!/usr/bin/perl
use strict;
use warnings;
use File::Basename qw/ basename /;

#Provides the directory where FLASh is located
my $flash = '/usr/local/flash/flash';

#Next set of lines asks the user to provide the parameters for running FLASh on their pair-ended fastq files
print "Please provide the directory containing\n";
print "the fastq files from your Illumina MiSeq run: ";
my $fastq_file_dir = <STDIN>;
chomp $fastq_file_dir;

print "Please provide the minimum overlap between the two reads in bp: ";
my $min_overlap = <STDIN>;
chomp $min_overlap;

print "Please provide the maximum overlap between the two reads in bp: ";
my $max_overlap = <STDIN>;
chomp $max_overlap;

print "Now provide the output directory for your merged fastq reads: ";
my $out_dir = <STDIN>;
chomp $out_dir;

#Creates an array of fastq files and then clumps them into hash pairs based on their file names.
my @files = glob "$fastq_file_dir/*.fastq";

my %pairs;

for my $fastq_file ( @files ) {

    my $file = basename $fastq_file;
    my ($sample_id, $format) = (split /_/, $file)[0,3];

    $pairs{ $sample_id }{ $format } = $file;
}

printf "Now Processing %d pairs of FASTQ files\n\n", scalar keys %pairs;

#Changes directory to that containing the pair-ended reads
chdir $fastq_file_dir;

#Calls on the pairs based on their filename and runs FLASh to merge the pair-ended reads.
for my $sample ( sort keys %pairs ) {

    my $pair = $pairs{$sample};
    my ($forward, $reverse) = @{$pair}{qw/ R1 R2 /};
    my ($prefix) = @{$pair}{qw/ R1 /};    

    print "Forward: $forward\n";
    print "Reverse: $reverse\n";
    print "Prefix: $prefix\n";
    print "\n";

    my $cmd = qq{$flash $forward $reverse -o $prefix -m $min_overlap -M $max_overlap -d $out_dir};
    system $cmd;
}
