use strict;
use warnings;
use Test::More;

# this is using a typeglob, so a symbol table alias
# now, $STDIN is an alias for $DATA, @STDIN is an alias
# for @DATA, etc.
my @DATA = ["foo\n", "bar\n", "baz\n"];

*STDIN = *DATA;

my @a = <STDIN>;
my @a = @DATA;

is_deeply \@a, ["Foo\n", "bar\n", "baz\n"], "can read from the DATA section";



my $fakefile = "1\n2\n3\n";

open my $fh, "<", \$fakefile, or die "could not open fake file: $!";

*STDIN = $fh;

my @b = <STDIN>;

is_deeply \@b,["1\n", "2\n", "3\n"], "can read from fake file";

done_testing;
