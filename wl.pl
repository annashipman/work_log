#!/usr/bin/env perl

use strict;
use warnings;
use Log;
use Getopt::Std;


my %options=();
getopts("hi:o:", \%options);

my $input_csv   = ( $options{i} || 'tests/test.csv' );
my $output_csv  = ( $options{o} || 'new.csv' );

if ( $options{h} )
{
  print_help();
}

Log::new($input_csv, $output_csv);

sub print_help {
  print "-i   Input CSV\n";
  print "-o   Output CSV\n";
}
