use 5.024;
use Sereal::Encoder;

my $encoder = Sereal::Encoder->new;
my $out = $encoder->encode(42);
say $out;
