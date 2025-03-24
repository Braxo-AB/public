
use POSIX qw(strftime);

my $filename;
my @words;
my $read_date = 0;

my $debug = 1;
my $logfile = "/tmp/wordfilter.log";

sub dolog {
    my ($str) = @_;
    return unless $debug;
    my $ts = strftime("%Y-%m-%d %H:%M:%S", localtime);
    open(OUT, ">>$logfile");
    print OUT "$ts $str";
    close(OUT);
}

sub refresh_words {
    ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
    my $dayno = 0 + ($year + 1900) * 10000 + $mon * 100 + $mday;
    return unless ($dayno > $read_date);
    @words = ();
    if (open(my $fh, '<', $filename)) {
        while (my $row = <$fh>) {
            chomp($row);
            next if length($row) < 1;
            push @words, lc($row);
        }
        dolog("load from " . $filename . ", found " . @words . " words\n");
        close($fh);
    }
    $read_date = $dayno;
}

sub create_config {
    my ($name, $configdata) = @_;
    $filename = $configdata;
}

sub check {
    my ($msg) = @_;

    refresh_words;
    foreach my $word (@words) {
        next unless ($msg =~ /\b${word}\b/);
        dolog("reject message " . $q->{'ID'} . " containing `" . $word . "' in message: `" . $msg . "'\n");
        return 8;
    }
    return 0;
}

sub before_receive {
    my ($request, $response) = @_;
    my $q = ${$request}{'qe'};
    my $msg = lc($q->{'MESSAGE'});
    return check($msg);
}

