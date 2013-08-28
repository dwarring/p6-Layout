use v6;

class Layout {

    subset Id of Str is export(:id) where {/^\w+$/};
    enum Display is export(:display) <hidden visible>;
    enum Flow is export(:flow) <forward reverse>;

    class Position {
        role Disposition {
            has Bool $.floating;
        }
        class Pos is Num does Disposition {};

        has Pos $.x;
        has Pos $.y;

        constant left   is export(:align) = 0.0;
        constant right  is export(:align) = 1.0;

        constant bottom is export(:valign) = 0.0;
        constant top    is export(:valign) = 1.0;

        constant center is export(:align, :valign) = 0.5;

        subset Frac of Num where {0.0 <= $_ <= 1.0};

        has Frac $.grab;
        has Frac $.vgrab;
        has Frac $.align = left;
        has Frac $.valign = bottom;

        has $.width;
        has $.height;

        has Num $.rotate;

        method left {
            $.x  -  $.align * $.width;
        }

        method right {
            $.x  +  (1 - $.align) * $.width;
        }

        method bottom {
            $.y  -  $.valign * $.height;
        }

        method top {
            $.y  +  (1 - $.valign) * $.height;
        }

        submethod BUILD(:$align, :$valign, :$!width, :$!height, :$!x, :$!y) {

            if $align.defined {
                if $align.isa('Str') {
                    $!align = (given $align {
                        when m:i/^l(eft)?$/        { left }
                        when m:i/^c(ent(er|re))?$/ { center }
                        when m:i/^r(ight)?$/       { right }
                        default { $align.Num }
                    });
                }
                else {
                    $!align = $align.Num;
                }
                CATCH {die "illegal value for align: " ~ $align};
            }

            if $valign.defined {
                if $valign.isa('Str') {
                    $!valign = (given $valign {
                        when m:i/^b(ottom)?$/      { left }
                        when m:i/^c(ent(er|re))?$/ { center }
                        when m:i/^t(op)?$/         { top }
                        default { $valign.Num }
                    });
                }
                else {
                    $!valign = $valign.Num;
                }
                CATCH {die "illegal value for valign: " ~ $valign};
            }
        }
    }

    class Item {

        has Id $.id;
        has Num $.z-index;
        has Flow $.flow = forward;
        has Display $.display = visible;
        has Position $.position;

        has $.content;
        has Id $.label-id;
        has $.label;

    }

}

