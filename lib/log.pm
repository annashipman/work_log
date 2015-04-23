package Log;

use strict;
use warnings;

use Text::CSV;


sub new {
    my $class    = shift;
    my $csv_file = shift;

    my $self = {};
    bless $self, $class;

    $self->{'csv'} = Text::CSV->new({ binary => 1 });
    open $self->{'csv_handle'}, '<:encoding(utf8)', $csv_file
        or return undef;

    $self->{'column_names'} = $self->read_column_names();
    return unless scalar @{$self->{'column_names'}};
    return unless $self->has_mandatory_columns();

    return $self;
}

sub read_csv {
    my $self = shift;

    while ( my $row = $self->get_row() ) {
        print "hello" . $row;
    }

    return;
}

sub get_row {
    my $self = shift;
    return $self->{'csv'}->getline_hr( $self->{'csv_handle'} );
}

sub read_column_names {
    my $self = shift;

    my $names = $self->{'csv'}->getline( $self->{'csv_handle'} );
    return unless scalar @$names;

    $self->{'csv'}->column_names( @$names );
    return $names;
}

1;

