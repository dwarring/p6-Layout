use v6;

class Layout {

    subset Id of Str is export(:id) where {/^\w+$/};
    enum Display is export(:display) <hidden visible>;
    enum Flow is export(:flow) <forward reverse>;
    enum Position is export(:position) <relative absolute>;

    constant left   is export(:align) = 0.0;
    constant right  is export(:align) = 1.0;

    constant bottom is export(:valign) = 0.0;
    constant top    is export(:valign) = 1.0;

    constant center is export(:align, :valign) = 0.5;

    class Placement {

        has Position $.position = absolute;
        has $!x;
        has $!y;

        subset Frac of Real where {0.0 <= $_ <= 1.0};

        has Frac $.grab;
        has Frac $.vgrab;
        has Frac $.x-origin = left;
        has Frac $.y-origin = bottom;

        has $.width;
        has $.height;

        method right($x0?) {
            $!x = ($.x-origin - 1) * $.width + $x0
                if $x0.defined;
            $!x  +  (1 - $.x-origin) * $.width;
        }

        method left($x1?) {
            $!x = $x1 + $.x-origin * $.width
                if $x1.defined;
            $!x  -  $.x-origin * $.width;
        }

        method bottom($y0?) {
           $!y = $y0 + $.y-origin * $.height
               if $y0.defined;
           $!y  -  $.y-origin * $.height;
        }

        method top($y1?) {
            $!y = ($.y-origin - 1) * $.height  +  $y1
                if $y1.defined;
            $!y  +  (1 - $.y-origin) * $.height;
        }

        method align($align?) {
            if $align.defined {
                $!x-origin = (given $align {
                    when $align.isa('Str')     { $align.Num }
                    when m:i/^l(eft)?$/        { left }
                    when m:i/^c(ent(er|re))?$/ { center }
                    when m:i/^r(ight)?$/       { right }
                    default { $align.Num }
                });
                CATCH {die "illegal value for align: " ~ $align};
            }
            $!x-origin;
        }

        method valign($valign?) {
            if $valign.defined {
                $!y-origin = (given $valign {
                    when $valign.isa('Str')    { $valign.Num }
                    when m:i/^b(ottom)?$/      { left }
                    when m:i/^c(ent(er|re))?$/ { center }
                    when m:i/^t(op)?$/         { top }
                    default { $valign.Num }
                });
                CATCH {die "illegal value for valign: " ~ $valign};
            }
            $!y-origin;
        }

        submethod BUILD(:$align, :$valign, :$!width, :$!height) {

            self.align($align) if $align.defined;
            self.valign($valign) if $valign.defined;

        }
    }

    class Item is Placement is export(:item) {

        has Id $.id;
        has Num $.z-index;
        has Flow $.flow = forward;
        has Display $.display = visible;

        has $.content;
        has Id $.label-id;
        has $.label;

    }

}

