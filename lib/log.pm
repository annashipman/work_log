package Log;

use strict;
use warnings;

use Text::CSV;


sub new {
    my $csv_name = shift;
    my @rows;
    my $csv = Text::CSV->new ( { binary => 1 } )
        or die "Cannot use CSV: ".Text::CSV->error_diag ();

    open my $fh, "<:encoding(utf8)", $csv_name
        or die "Cannot use " . $csv_name . ": $!";

        while ( my $row = $csv->getline( $fh ) ) {
            my $time = $row->[0];
            print "is time correct?";
            chomp(my $answer = <>);
            print $answer;
            push @rows, $row;
        }
    $csv->eof or $csv->error_diag();
    close $fh;

    $csv->eol ("\r\n");

    open $fh, ">:encoding(utf8)", "new.csv" or die "new.csv: $!";
    $csv->print ($fh, $_) for @rows;
    close $fh or die "new.csv: $!";

}

1;

