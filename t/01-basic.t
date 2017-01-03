use Sereal;
use Test;

my @files = 'hw.sereal' => 'Hello world',
            '42.sereal' => 42;
for @files -> $case {
    my $bytes = slurp "t/blobs/{$case.key}", :bin;
    my $res = from-sereal($bytes);
    say $res.perl;
    is $res, $case.value, $case.key;
}

done-testing;
