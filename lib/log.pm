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

§       # So, assume all times are correctly formatted
        # 24hr, split with a hyphen
        # Hmm... would like to split at hyphen but without the internet
        # cannot guess how. So instead, assume they are all of the format
        # HH.MM-HH.MM in the 24-hour clock

        my $start_hr  = substr $time, 0, 1;
        my $start_min = substr $time, 3, 4;
        my $end_hr    = substr $time, 6, 7;
        my $end_min   = substr $time, 9, 10;

        # wow, that's hacky
        # now what? I feel like I'm reinventing the wheel here
        # surely there are time functions in perl
        # but I can't guess what they're called to search the docs

        # fake the calculation for now
        my $time_elapsed = 70;


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

