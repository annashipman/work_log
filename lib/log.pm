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

    my $minutes_total = 0;

    while ( my $row = $csv->getline( $fh ) ) {
        my $col_1 = $row->[0];

        if ( is_time($col_1) ) {
          my $time_elapsed = get_time_elapsed( $col_1 );
          $row->[0] = $time_elapsed;
          $minutes_total = $minutes_total + $time_elapsed;
        } elsif ( is_holiday($col_1) ) {
          my $hours = "Total: " . previous_days_total_hours($minutes_total);
          push @rows, [$hours];
          $row = ["Holiday"];
          $minutes_total = 0;
        } elsif ( is_workday($col_1) ) {
          my $hours = "Total: " . previous_days_total_hours($minutes_total);
          push @rows, [$hours];
          $row = ["Workday"];
          $minutes_total = 0;
        }
        if ( $col_1 ) {
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

sub previous_days_total_hours {
  my $total = shift;
  return $total / 60;
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

sub is_time {
  my $col_1 = shift;
  my $substr = "-";
  return ( index($col_1, $substr) != -1 );
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

