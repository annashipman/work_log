package Log;

use strict;
use warnings;

use Text::CSV;


sub new {
    my $input_csv = shift;
    my $output_csv = shift;
    my @rows;
    my $csv = Text::CSV->new ( { binary => 1 } )
        or die "Cannot use CSV: ".Text::CSV->error_diag ();

    open my $fh, "<:encoding(utf8)", $input_csv
        or die "Cannot use " . $input_csv . ": $!";

    while ( my $row = $csv->getline( $fh ) ) {
        my $time = $row->[0];
        my $substr = "-";

        if (index($time, $substr) != -1) {

          my $time_elapsed = get_time_elapsed( $time );
          $row->[0] = $time_elapsed;

          push @rows, $row;
        } elsif ( is_holiday($time) ) {
          $row = ["Holiday"];
          push @rows, $row;
        } elsif ( is_workday($time) ) {
          $row = ["Workday"];
          push @rows, $row;
        }
    }
    $csv->eof or $csv->error_diag();
    close $fh;

    $csv->eol ("\r\n");

    open $fh, ">:encoding(utf8)", $output_csv or die $output_csv . ": $!";
    $csv->print ($fh, $_) for @rows;
    close $fh or die $output_csv . ": $!";

}

sub get_time_elapsed {
  my $time = shift;

  my $start_hr  = substr $time, 0, 2;
  my $start_min = substr $time, 3, 2;
  my $end_hr    = substr $time, 6, 2;
  my $end_min   = substr $time, 9, 2;

  my $hours_in_minutes = ($end_hr - $start_hr)* 60;

  my $minutes = $end_min - $start_min;

  # min_hours + minutes (which will subtract if answer is negative)
  my $time_elapsed = $hours_in_minutes + $minutes;

  return $time_elapsed;
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

sub is_holiday {
  my $day = shift;

  if ( index($day, "Saturday") != -1  ||
       index($day, "Sunday") != -1  ||
       index($day, "Off") != -1  ||
       index($day, "Holiday") != -1 ) {
    return 1;
  } else {
    return 0;
  }
}

1;

