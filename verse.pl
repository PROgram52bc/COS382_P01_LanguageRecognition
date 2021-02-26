#!/usr/bin/perl
use strict;
use warnings;

my $nargs = $#ARGV + 1;
if ($nargs != 1) {
	print "Usage: perl $0 filename";
	exit;
}

my $filename = $ARGV[0];
open(FH, '<', $filename) or die $!;

while (<FH>) {
	if (is_valid_bible_verse($_)) {
		print "VALID: ";
	} else {
		print "INVALID: ";
	}
	print $_;
}

sub is_valid_bible_verse {
	my $D = qr/[0-9]+/;
	my $V = qr/${D}(-${D})?(,${D}(-${D})?)*/;
	my $B = qr/([0-9] )?[A-Za-z]+/;
	my $X = qr/${D}(:${V})?/;
	my $R = qr/(${X}(;${X})*)?/;
	my $T = qr/(\([A-Za-z]*\))*/;
	return $_[0] =~ /^${B}\s*${R}\s*${T}$/;
	# return $_[0] =~ /^${B}\s*${R}\s*${T}$/;
}
