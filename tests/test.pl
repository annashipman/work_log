use Test::Spec;
use Text::CSV;
use Log;

my $output_csv = 'out/new.csv';

Log::new('tests/test.csv', $output_csv);

my $csv = Text::CSV->new ( { binary => 1 } ) or die "died";
open my $fh, "<", $output_csv, or die "could not open $output_csv: $!";
my $row;

describe "reading the input" => sub {

  it "creates output CSV with total time and activity" => sub {
    $row = $csv->getline( $fh );
    is_deeply ( $row, ["Workday"] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["70","Sprint planning",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["55","Email",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["25","Blog post",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["15","Email",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["15","Reading up about shared parental leave",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["10","Email",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["5","Blog post",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["5","'Helping with comms' Betony asked me not Carl",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["10","Talking to Carl: general strategy stuff",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["20","Email",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["5","Blog post - Frances coming back to me ages later after having already talked to Betony",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["10","Email",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["15","Job spec",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["20","My own appraisal stuff",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["20","UBS talk",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["35","Follow up with Liam on reverse mentoring",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["5","Talk to Ahana",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["15","Email",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["10","Lists",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["60","Reading",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["5","Pivotal story",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["15","Email",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["Workday"] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["50","Blog post",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["55","Email",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["10","Job spec",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["5","Email",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["10","Looking into ticketing systems",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["10","Email",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["20","Enabling strategy show and tell",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["35","Email",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["50","Retrospective",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["75","John Manzoni Q & A",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["20","Chat with Dan about tech & job spec",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["10","Email",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["10","Talking to Torben about rates",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["15","Email",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["15","Blog post",""] );

    $row = $csv->getline( $fh );
    is_deeply ( $row, ["20","Email",""] );
  };

  it "identifies 'Holiday' as holiday" => sub {
    $row = $csv->getline( $fh );
    is_deeply ( $row, ["Holiday"] );
    $row = $csv->getline( $fh );
    is_deeply ( $row, ["55","Email",""] );
  };

  it "indentifies 'Saturday' as holiday" => sub {
    $row = $csv->getline( $fh );
    is_deeply ( $row, ["Holiday"] );
    $row = $csv->getline( $fh );
    is_deeply ( $row, ["50","Email",""] );
  };

  #if these are two tests, both fail. Why?
  it "identifies 'Day Off' as holiday" => sub {
    $row = $csv->getline( $fh );
    is_deeply ( $row, ["Holiday"] );
    $row = $csv->getline( $fh );
    is_deeply ( $row, ["45","Email",""] );
  };
};

runtests unless caller;
