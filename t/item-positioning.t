use Layout :item :align :valign;
use Test;

my $item = Layout::Item.new(:width(20), :height(25));

is( $item.left(10).round, 10, 'left');
is( $item.bottom(15).round, 15, 'bottom');

is( $item.align, Layout::left, 'align');
is( $item.valign, Layout::bottom, 'valign');

is( $item.right.round, 30, 'right');
is( $item.top.round, 40, 'top');

is( $item.top(45).round, 45, 'top +5');
is( $item.right(35).round, 35, 'right +5');

done();
