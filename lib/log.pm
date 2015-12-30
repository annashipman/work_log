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

        # work out how many minutes in the time I've been given
        # no handling of errors, blank lines, day headimgs yet

        # So, assume all times are correctly formatted
        # HH.MM-HH.MM in the 24-hour clock

        my $start_hr  = substr $time, 0, 1;
        my $start_min = substr $time, 3, 4;
        my $end_hr    = substr $time, 6, 7;
        my $end_min   = substr $time, 9, 10;

        # we are assuming the string to number conversion is no problem
        my $hours_in_minutes = ($end_hr - $start_hr)* 60;

        my $minutes = $end_min - $start_min;

        # min_hours + minutes (which will subtract if answer is negative)
        my $time_elapsed = $hours_in_minutes + $minutes;

        $row->[0] = $time_elapsed;

        push @rows, $row;
    }
    $csv->eof or $csv->error_diag();
    close $fh;

    $csv->eol ("\r\n");

    open $fh, ">:encoding(utf8)", "out/new.csv" or die "out/new.csv: $!";
    $csv->print ($fh, $_) for @rows;
    close $fh or die "out/new.csv: $!";

}

1;

