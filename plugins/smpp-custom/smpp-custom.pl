sub before_send {
	my ($request, $response) = @_;
	my $sms = ${$request}{qe};
	$sms->{SMPPOPTION} = "0x1400:" . unpack("H*","Value");
	return 0;
}

