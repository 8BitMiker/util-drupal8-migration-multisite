#!/usr/bin/perl
use strict;
use warnings;
$|++;

my $error = <<"....";
Need 5 arguments for drush-restore:
....................................
	-s  <target site>
	-a  <archive folder>
	-f  <destination folder>
	-db <database name>
	-dp <database pass>
	-du <database user>
....
 
@ARGV == 12
	? drush_restore(@ARGV)
	: die $error ;
	
sub drush_restore
{

	my $drush = {};
	
	%{$drush} = map 
	{ 
		m~(?i)^-[A-Z]{1,2}$~
		? m~(?i)^-(?:a|f|s|d(?:b|p|u))$~
			? do { s~^-~~; $_ }
			: die $error
		: $_;
	} @_;
 
	
	system qq~drush archive-restore $drush->{a} $drush->{s} --destination=$drush->{f} --db-url=mysql://$drush->{du}:$drush->{dp}\@localhost/$drush->{db}~;
 
	die "Drush returned error code: $?\n" if $?;
}
