#!/usr/bin/perl
use strict;
use warnings;

my $nargs = $#ARGV + 1;
if ($nargs != 1) {
	print "Usage: perl $0 filename\n";
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
	my $D = qr/[0-9]+/; 						# one or more digits. E.g. 123
	my $V = qr/${D}(-${D})?(,${D}(-${D})?)*/;	# verse or verse ranges E.g. 1-3,14-16
	my $B = qr/([0-9] )?[A-Za-z]+/;				# book name. E.g. 2 John
	my $X = qr/${D}(:${V})?/;					# chapter + verse E.g. 12:1-3,14-16
	my $R = qr/(${X}(;${X})*)?/;				# groups of CV. E.g. 12:1-3,14-16;1:3-5
	my $T = qr/(\([A-Za-z]*\))?/;				# version. E.g. (blahblahBlah)
	return $_[0] =~ /^${B}\s*${R}\s*${T}$/;
}
