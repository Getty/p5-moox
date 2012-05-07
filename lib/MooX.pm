package MooX;
# ABSTRACT: Using Moo and MooX:: packages the most lazy way

use strict;
use warnings;
use Import::Into;
use Module::Runtime qw( use_module );
use Carp;
use Data::OptList;

sub import {
	my ( $class, @modules ) = @_;
	my $target = caller;
	unshift @modules, '+Moo';
	MooX::import_base($class,$target,@modules);
}

sub import_base {
	my ( $class, $target, @modules ) = @_;
	my @optlist = @{Data::OptList::mkopt([@modules],{
		must_be => [qw( ARRAY HASH )],
	})};
	for (@optlist) {
		my $package = $_->[0];
		my $opts = $_->[1];
		for ($package) { s/^\+// or $_ = "MooX::$_" };
		croak "No package name given" if ref $package;
		my @args = ref $opts eq 'ARRAY'
			? @{$opts}
			: ref $opts eq 'HASH'
				? %{$opts}
				: ();
		use_module($package)->import::into($target,@args);
	}
}

1;

=encoding utf8

=head1 SYNOPSIS

  package MyClass;

  use MooX qw(
    Options
  );

  # use Moo;
  # use MooX::Options;

  package MyClassComplex;

  use MooX
    SomeThing => [qw( import params )],
    'OtherThing', MoreThing => { key => 'value' },
    '+NonMooXStuff';

  # use Moo;
  # use MooX::SomeThing qw( import params );
  # use MooX::OtherThing;
  # use MooX::MoreThing key => 'value';
  # use NonMooXStuff;

  package MyMoo;

  use MooX ();

  sub import { MooX->import::into(scalar caller, qw( A B +Carp )) }

  # then you can do: use MyMoo; which does the same as:
  # use Moo;
  # use MooX::A;
  # use MooX::B;
  # use Carp;

=head1 DESCRIPTION

Using L<Moo> and MooX:: packages the most lazy way

=head1 SEE ALSO

=head2 L<Import::Into>

=head1 SUPPORT

Repository

  http://github.com/Getty/p5-moox
  Pull request and additional contributors are welcome
 
Issue Tracker

  http://github.com/Getty/p5-moox/issues


