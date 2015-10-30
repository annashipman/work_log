use strict;
use warnings;
use Test::More;
use Text::CSV;
use Log;

Log::new('tests/test.csv');

my $csv = Text::CSV->new ( { binary => 1 } ) or die "died";
open my $fh, "<", "out/new.csv", or die "could not open out/new.csv: $!";

my $row = $csv->getline( $fh );
is_deeply ( $row, ["A0","A1","A2","A3"], "A row is yes" );

$row = $csv->getline( $fh );
is_deeply ( $row, ["C0","C1","C2","C3"], "B row was 'no' so 2nd row is C" );

$row = $csv->getline( $fh );
is ($row, undef, "There are only two rows");


done_testing();
