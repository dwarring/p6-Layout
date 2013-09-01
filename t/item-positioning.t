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

is($item.align('left'), Layout::left, 'align "left"');
is($item.align('center'), Layout::center, 'align "center"');
is($item.align('right'), Layout::right, 'align "right"');
is($item.align( 0.5 ), Layout::center, 'align 0.5');
dies_ok {$item.align('foo')} , "align invalid";

is($item.valign('bottom'), Layout::bottom, 'valign "bottom"');
is($item.valign('center'), Layout::center, 'valign "center"');
is($item.valign('top'), Layout::top, 'valign "top"');
is($item.valign( 0.5 ), Layout::center, 'valign 0.5');
dies_ok {$item.valign('bar')}, "valign invalid";

done();
