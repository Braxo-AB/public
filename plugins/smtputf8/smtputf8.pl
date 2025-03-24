sub route {
	my ($request, $response) = @_;
	my $sms = ${$request}{qe};
	my $dest = $sms->{DESTADDR};
	my @parts = split('@', $dest);
	return 0 if (scalar @parts < 2);
	foreach $ch (split //, $parts[0]) {
		if (ord($ch) > 127) {
			$response->{route} = 'smtp-out-utf8';
			return 0;
		}
	}
	return 0;
}

