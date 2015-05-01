use strict;
use warnings;
use Test::More;
use Log;

my $fakefile = "yes\nno\nyes\n";

open my $fh, "<", \$fakefile, or die "could not open fake file: $!";

*STDIN = $fh;

Log::new('tests/test.csv');
my $result_key   = "Anna";
is( $result_key, "Anna", "Test does nothing yet" );

#Log::new('tests/not_csv.csv');
#is (1, 1, "what do I need to do to make it die?");

done_testing();
