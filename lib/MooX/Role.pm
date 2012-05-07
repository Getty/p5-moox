package MooX::Role;
# ABSTRACT: Using Moo::Role and MooX:: packages the most lazy way

use strict;
use warnings;
use MooX ();

sub import {
	my ( $class, @modules ) = @_;
	my $target = caller;
	unshift @modules, '+Moo::Role';
  MooX::import_base($class,$target,@modules);
}

1;

=encoding utf8

=head1 SYNOPSIS

  package MyRole;

  use MooX::Role qw(
    Options
  );

  # use Moo::Role;
  # use MooX::Options;

=head1 DESCRIPTION

Exactly the same behaviour as L<MooX>, but instead importing L<Moo>, it imports L<Moo::Role>.

=head1 SEE ALSO

=head2 L<Role::Tiny>

=head1 SUPPORT

Repository

  http://github.com/Getty/p5-moox
  Pull request and additional contributors are welcome
 
Issue Tracker

  http://github.com/Getty/p5-moox/issues


