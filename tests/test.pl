use strict;
use warnings;
use Test::More;
use Text::CSV;
use Log;

Log::new('tests/test.csv');

my $csv = Text::CSV->new ( { binary => 1 } ) or die "died";
open my $fh, "<", "out/new.csv", or die "could not open out/new.csv: $!";

# The correct minutes are:
# 70 55 25 15 15 10 5 5 10 20 5 10 15 20 20 35 5 15 10 60 5 15
# 50 55 10 5 10 10 20 35 50 15 20 10 10 15 15 20

my $row = $csv->getline( $fh );
is_deeply ( $row, ["70","Sprint planning",""] );

$row = $csv->getline( $fh );
is_deeply ( $row, ["55","Email",""] );

$row = $csv->getline( $fh );
is_deeply ( $row, ["25","Blog post",""] );

$row = $csv->getline( $fh );
is_deeply ( $row, ["15","Email",""] );

$row = $csv->getline( $fh );
is_deeply ( $row, ["15","Reading up about shared parental leave",""] );


done_testing();
