package List::Rubyish::Circular;
use 5.008001;
use strict;
use warnings;
use parent qw(List::Rubyish);

our $VERSION = '0.01';

sub cycle {
    my ($self, $count) = @_;
    $count ||= 1;

    my @list;
    for my $index ($count .. (($self->size - 1) + $count)) {
        push @list, $self->[$index % $self->size];
    }

    $self->new(@list);
}

sub rcycle {
    my ($self, $count) = @_;
    $count ||= 1;
    $self->cycle(- $count);
}

1;

__END__

=encoding utf8

=head1 NAME

List::Rubyish::Circular - A circular list implementation based on
List::Rubyish

=head1 SYNOPSIS

  use Test::More;
  use List::Rubyish::Circular;

  my $list = List::Rubyish::Circular->new(qw(jkondo reikon cinnamon));

  is_deeply [qw(reikon cinnamon jkondo)], $list->cycle->to_a;
  is_deeply [qw(cinnamon jkondo reikon)], $list->cycle(2)->to_a;

  is_deeply [qw(reikon cinnamon jkondo)], $list->rcycle->to_a;
  is_deeply [qw(cinnamon jkondo reikon)], $list->rcycle(2)->to_a;

  # $list is still a circular list after destracive operation
  $list->push(qw(tokky));

  is_deeply [qw(jkondo reikon cinnamon tokky)], $list->to_a;
  is_deeply [qw(reikon cinnamon tokky jkondo)], $list->cycle->to_a;
  is_deeply [qw(cinnamon tokky jkondo reikon)], $list->rcycle(2)->to_a;

=head1 DESCRIPTION

List::Rubyish::Circular is a cirlular list implementation besed on
L<List::Rubyish>, so that You can utilize some convenient methods from
List::Rubyish against a circular list.

=head1 METHODS

=head2 cycle ( I<$count> )

=over 4

Shifts list to the left and returns new list according to
C<$count>. If $count not passed in, its value is 1.

  my $list = List::Rubyish::Circular->new(qw(jkondo reikon cinnamon));

  is_deeply [qw(reikon cinnamon jkondo)], $list->cycle->to_a;
  is_deeply [qw(cinnamon jkondo reikon)], $list->cycle(2)->to_a;

=back

=head2 rcycle ( I<$count> )

=over 4

The opposite of C<cycle>.

=back

=head1 SEE ALSO

=over 4

=item L<List::Rubyish>

=back

=head1 AUTHOR

Kentaro Kuribayashi E<lt>kentarok@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

Copyright (C) Kentaro Kuribayashi

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
