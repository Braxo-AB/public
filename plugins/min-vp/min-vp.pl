# If the VP is set, make sure it's at least 900 (15 minutes).

sub before_send {
	my ($request, $response) = @_;
	my $q = ${$request}{'qe'};
	if ((defined($q->{'VP'})) && ($q->{'VP'} < 900)) {
		$q->{'VP'} = 900;
	}
	return 0;
}

