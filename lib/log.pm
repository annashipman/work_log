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
        my $substr = "-";

        # Naive - if it doesn't have a hyphen, it's not a time
        if (index($time, $substr) != -1) {

          #TO DO:
          # incorrectly formatted time

          # HH.MM-HH.MM in the 24-hour clock

          my $start_hr  = substr $time, 0, 2;
          my $start_min = substr $time, 3, 2;
          my $end_hr    = substr $time, 6, 2;
          my $end_min   = substr $time, 9, 2;

          my $hours_in_minutes = ($end_hr - $start_hr)* 60;

          my $minutes = $end_min - $start_min;

          # min_hours + minutes (which will subtract if answer is negative)
          my $time_elapsed = $hours_in_minutes + $minutes;

          $row->[0] = $time_elapsed;

          push @rows, $row;
        } elsif ( is_workday($time) ) {
          $row = ["Workday"];
          push @rows, $row;
        }
    }
    $csv->eof or $csv->error_diag();
    close $fh;

    $csv->eol ("\r\n");

    open $fh, ">:encoding(utf8)", "out/new.csv" or die "out/new.csv: $!";
    $csv->print ($fh, $_) for @rows;
    close $fh or die "out/new.csv: $!";

}

sub is_workday {
  my $day = shift;

  if ( index($day, "Monday") != -1  ||
       index($day, "Tuesday") != -1  ||
       index($day, "Wednesday") != -1  ||
       index($day, "Thursday") != -1  ||
       index($day, "Friday") != -1 ) {
    return 1;
  } else {
    return 0;
  }

}

1;

