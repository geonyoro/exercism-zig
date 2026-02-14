const std = @import("std");
const Pling = "Pling";
const Plang = "Plang";
const Plong = "Plong";

pub fn convert(buffer: []u8, n: u32) []const u8 {
    const sounds = .{
        .{3, "Pling"},
        .{5, "Plang"},
        .{7, "Plong"},
    };
    var i: usize = 0;
    inline for (sounds) | s | {
        if (@rem(n, s[0]) == 0){
            const sound = s[1];
            @memcpy(buffer[i..][0..sound.len], sound);
            i += sound.len;
        }
    }
    
    if (i == 0) {
        // put the actual num in there
        const actual = std.fmt.bufPrint(buffer, "{d}", .{n}) catch unreachable;
        i += actual.len;
    }
    return buffer[0..i];
}
