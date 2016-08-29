#!/usr/bin/env perl

use strict;
use warnings;
use Log;

my $input_csv = shift || 'tests/test.csv';
my $output_csv = shift || 'new.csv';

Log::new($input_csv, $output_csv);

