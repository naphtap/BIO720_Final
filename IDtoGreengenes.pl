#!/usr/bin/perl
use strict;
use warnings;

#Bio::LITE::Taxonomy::NCBI is a Perl module that provides the user easy access to the NCBI taxonomy. 
use Bio::LITE::Taxonomy::NCBI;

#Provides the files to the NCBI names and nodes for classifying organisms by taxonomy rank.
my $taxNCBI = Bio::LITE::Taxonomy::NCBI->new(
                                              names=> "/home/yasser/taxdump/names.dmp",
                                              nodes=> "/home/yasser/taxdump/nodes.dmp"
                                            );

#Tab-delimited file containing NCBI Class Taxon IDs and its OTU counts is processed line by line. First, the Taxon IDs
#and OTU counts were split into separate variables. The taxonomy name of the ID was obtained and then placed into an array.
#Once the taxonomies were collected, the names were formatted as Greengenes taxonomy strings.
while(<>) {
  my ($id, $counts) = (split /\t/);
  my @tax = $taxNCBI->get_taxonomy($id);
  for my $index (reverse 0..$#tax) {
    if ( $tax[$index] =~ /cellular organisms|group|subdivisions/ ) {
    splice(@tax, $index, 1, ());
    }
  }
  my $taxonstring = qq(k__$tax[0]; p__$tax[1]; c__$tax[2]);
  print qq($taxonstring\t$counts);
}
