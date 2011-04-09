use strict;
use warnings;
use Test::More;

use List::Rubyish::Circular;

subtest 'cycle' => sub {
    my $list = List::Rubyish::Circular->new(1, 2, 3, 4, 5);

    is_deeply [2, 3, 4, 5, 1], $list->cycle->to_a;
    is_deeply [3, 4, 5, 1, 2], $list->cycle(2)->to_a;
};

subtest 'rcycle' => sub {
    my $list = List::Rubyish::Circular->new(1, 2, 3, 4, 5);

    is_deeply [5, 1, 2, 3, 4], $list->rcycle->to_a;
    is_deeply [4, 5, 1, 2, 3], $list->rcycle(2)->to_a;
};

subtest 'destractive opperation' => sub {
    my $list = List::Rubyish::Circular->new(1, 2, 3);
       $list->push(4, 5);

    is_deeply [2, 3, 4, 5, 1], $list->cycle->to_a;
    is_deeply [3, 4, 5, 1, 2], $list->cycle(2)->to_a;

    $list->unshift(-1, 0);

    is_deeply [ 0, 1, 2, 3, 4, 5, -1 ], $list->cycle->to_a;
    is_deeply [ 1, 2, 3, 4, 5, -1, 0 ], $list->cycle(2)->to_a;
};

done_testing;
