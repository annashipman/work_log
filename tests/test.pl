use strict;
use warnings;
use Test::More;
use Text::CSV;
use Log;

Log::new('tests/test.csv');

my $csv = Text::CSV->new ( { binary => 1 } ) or die "died";
open my $fh, "<", "out/new.csv", or die "could not open out/new.csv: $!";

# At this stage, I am expecting the output to be
# some kind of error or something for each line with a date
# and each blank line
# and a correct number of minutes for each time
# and the correct minutes are:

# 70 55 25 15 15 10 5 5 10 20 5 10 15 20 20 35 5 15 10 60 5 15
# 50 55 10 5 10 10 20 35 50 15 20 10 10 15 15 20

my $row = $csv->getline( $fh );
is_deeply ( $row, ["A0","A1","A2","A3"], "A row is yes" );

$row = $csv->getline( $fh );
is_deeply ( $row, ["C0","C1","C2","C3"], "B row was 'no' so 2nd row is C" );

$row = $csv->getline( $fh );
is ($row, undef, "There are only two rows");


done_testing();
