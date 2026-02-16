const std = @import("std");
const BitSet = std.bit_set.IntegerBitSet(26);

pub fn isPangram(str: []const u8) bool {
    var set = BitSet.initEmpty();
    var count: u8 = 0;
    for (str) | c | {
        const lowerC = std.ascii.toLower(c);
        const index = switch (lowerC){
            'a'...'z' => lowerC - 'a',
            else => continue
        };

        if (!set.isSet(index)) {
            // we set it and count it
            count += 1;
            set.set(index);
        }
    }
    return count == 26;
}
