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
            get_activity_type($row);
            print $time;
            print "is time correct?\n";
            chomp(my $answer = <STDIN>);
            if ($answer eq "yes") {
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

sub get_activity_type(){
  my $row = shift;
  my $activity = $row->[1];
  if ($activity) {
    print "What kind of activity is " . $activity . "?\n";
    chomp(my $answer = <STDIN>);
    if ($answer) {
      print $answer;
    }
  }
}

1;

