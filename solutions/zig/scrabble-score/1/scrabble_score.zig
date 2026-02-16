const std = @import("std");
pub fn score(s: []const u8) u32 {
    var total: u32 = 0;
    for (s) | c | {
        switch (std.ascii.toUpper(c)) {
            'A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T' => { total += 1;},
            'D', 'G'                        => { total += 2;},
            'B', 'C', 'M', 'P'                   => { total += 3;},
            'F', 'H', 'V', 'W', 'Y'                => { total += 4;},
            'K'                            => { total += 5;},
            'J', 'X'                         => { total += 8;},
            'Q', 'Z'                         => { total += 10;},
            else => continue,
        }
    }
    return total;
}
