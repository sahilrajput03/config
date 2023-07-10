#!/usr/bin/perl

use strict;
use warnings;

our $VERSION = '0.01';

my %db;
open my $fh, '-|' , 'xprop' or die $!;

while ( <$fh> ) {
	chomp;
  if ( my ($k, $v) = split qr/\s+=\s+/, $_, 2 ) {
		next unless $k && $v;
    if (
			$k =~ s/WM_NAME/title/
			|| $k =~ s/WM_WINDOW_ROLE/window_role/
			|| $k =~ s/WM_WINDOW_TYPE/window_type/
		) {
			my $override = ($k =~ s/^_NET_//) // 0;
			$k =~ s/\([^)]*\)$//;
			
			if ( $k eq 'window_type' ) {
				$v =~ m/(?:_NET_)?WM_WINDOW_TYPE_(.*)/;
				$v = lc($1);
			}
			$v =~ s/^"|"$//g;
			if ( $override ) {
				$db{$k} = $v;
			}
			elsif ( ! defined $db{$k} ) {
				$db{$k} = $v;
			}
		}
		elsif ( m/WM_CLASS(?:\(STRING\))?\s+=\s+"([^"]*?)", "([^"]*?)"/ ) {
			my ( $instance, $class ) = ($1, $2, $3);
			$db{instance} = $instance;
			$db{class} = $class;
		}
  }
}

while ( my ($k,$v) = each %db ) {
	print "$k = \"$v\"\n";
}

__END__

=head1 NAME

xprop2i3 - Easy display of i3 attributes

=head1 DESCRIPTION

Wraps xprop to output the selector-names used by L<i3> outputting the
targetted window.

=head1 SYNOPSIS

    xprop2i3
    CLICK WINDOW

=head1 AUTHOR

Evan Carroll, C<< <me at evancarroll.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-xprop2i3 at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=xprop2i3>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc xprop2i3

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=xprop2i3>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/xprop2i3>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/xprop2i3>

=item * Search CPAN

L<http://search.cpan.org/dist/xprop2i3/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2019 Evan Carroll.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut
