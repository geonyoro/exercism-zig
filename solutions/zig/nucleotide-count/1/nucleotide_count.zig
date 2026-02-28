const std = @import("std");
pub const NucleotideError = error{Invalid};

pub const Counts = struct {
    a: u32 = 0,
    c: u32 = 0,
    g: u32 = 0,
    t: u32 = 0,
};

pub fn countNucleotides(s: []const u8) NucleotideError!Counts {
    var counts: Counts = .{};
    for (s) | sChar | {
        const c = std.ascii.toUpper(sChar);
        switch (c) {
            'A'=> {
                counts.a += 1;
            },
            'C'=> {
                counts.c += 1;
            },
            'G'=> {
                counts.g += 1;
            },
            'T'=> {
                counts.t += 1;
            },
            else => {
                return NucleotideError.Invalid;
            },
        }
    }
    return counts;
}
