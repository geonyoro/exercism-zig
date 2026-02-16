pub const TriangleError = error{Invalid};
pub const Triangle = struct {
    a: f64,
    b: f64,
    c: f64,

    pub fn init(a: f64, b: f64, c: f64) TriangleError!Triangle {
        if ((a + b < c) or (b + c < a) or (a + c < b)){
            return TriangleError.Invalid;
        }

        if (a <= 0 or b <= 0 or c <= 0 ){
            return TriangleError.Invalid;
        }

        return @as(Triangle, .{.a=a, .b=b, .c=c});
    }

    pub fn isEquilateral(self: Triangle) bool {
        return self.a == self.b and self.b == self.c;
    }

    pub fn isIsosceles(self: Triangle) bool {
        const combs = .{
            .{self.a, self.b},
            .{self.b, self.c},
            .{self.c, self.a},

        };
        inline for (combs) | cmb | {
            if (cmb[0] == cmb[1]){
                return true;
            }
        }
        return false;
    }

    pub fn isScalene(self: Triangle) bool {
        const combs = .{
            .{self.a, .{self.b, self.c}},
            .{self.b, .{self.a, self.c}},
            .{self.c, .{self.a, self.b}},

        };
        inline for (combs) | cmb | {
            const base: f64 = cmb[0];
            inline for (cmb[1]) | against | {
                if (base == against){
                    return false;
                }
            }
        }
        return true;
    }
};
