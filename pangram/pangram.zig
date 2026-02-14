const std = @import("std");


pub fn isPangram(str: []const u8) bool {
    var lowerCaseLetters = std.bit_set.IntegerBitSet(26).initEmpty();
    for (str) | c | {
        switch (c){
            'a'...'z' => c,
            'A'...'Z' => c,
            else => continue
        };
        lowerCaseLetters.set(std.ascii.toLower(c) - 'a');
    }
    return lowerCaseLetters.count() == 26;
}
