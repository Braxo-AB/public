# Fields described here:
# https://www.infobip.com/docs/essentials/api-essentials/smpp-specification

sub before_dlr {
        my ($request, $response) = @_;
        my $dlrinfo = ${$request}{dlrinfo};

        return 0 if $dlrinfo->{sourceaddr} ne 'HLR';

        my $mccmnc = $dlrinfo->{'0x1416'};
        my %info = (
                mcc => substr($mccmnc, 0, 3),
                mnc => substr($mccmnc, 3),
        );

        $response->{dlrinfo} = \%info;

        return 0;
}

