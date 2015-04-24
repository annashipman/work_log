use strict;
use warnings;
use Test::More;
use Log;

Log::new('tests/test.csv');
my $result_key   = "Anna";
is( $result_key, "Anna", "Test does nothing yet" );

done_testing();
