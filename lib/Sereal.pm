use v6;
use experimental :pack;
use Compress::Snappy;

sub decode-varint(Buf $bytes, Int $idx) {
    
}

sub decode-tag(Buf $bytes, Int $idx) {
    given $bytes[$idx] {
        when $_ +& 96 == 96 {
            my $len = $_ +& 31;
            return $bytes.subbuf($idx + 1, $len).unpack('A*');
        }
        when 32 {
            return decode-varint($bytes, $idx + 1);
        }
        default {
            fail "Tag $_ unsupported";
        }
    }
}

sub from-sereal(Buf $bytes) is export {
    my $magic = $bytes.subbuf(0, 4);
    unless $magic.unpack('H4') eq '3df3726c' {
        fail "Invalid magic string";
    }
    given $bytes[4] {
        when 3 {

        }
        default {
            fail "Only protocol version 3 is supported";
        }
    }
    given $bytes[5] {
        when 0 {
        }
        default {
            fail "OPT-SUFFIX unsupported";
        }
    }
    my $idx = 6;
    my $data = decode-tag $bytes, $idx;
    return $data;
}
