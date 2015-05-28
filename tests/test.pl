use strict;
use warnings;
use Test::More;
use Text::CSV;
use Log;

my $fakefile = "yes\nno\nyes\n";
open my $fh, "<", \$fakefile, or die "could not open fake file: $!";
*STDIN = $fh;

Log::new('tests/test.csv');

close $fh;

my $csv = Text::CSV->new ( { binary => 1 } ) or die "died";
open $fh, "<", "out/new.csv", or die "could not open out/new.csv: $!";

my $row = $csv->getline( $fh );
is_deeply ( $row, ["A0","A1","A2","A3"], "A row is yes" );

$row = $csv->getline( $fh );
is_deeply ( $row, ["C0","C1","C2","C3"], "B row was 'no' so 2nd row is C" );

$row = $csv->getline( $fh );
is ($row, undef, "There are only two rows");


$fakefile = "nothing";
open $fh, "<", \$fakefile, or die "could not open fake file: $!";
*STDIN = $fh;

Log::new('tests/not_csv.csv');
is (1, 1, "what do I need to do to make it die?");

done_testing();
