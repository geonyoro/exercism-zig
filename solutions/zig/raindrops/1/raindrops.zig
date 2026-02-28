const std = @import("std");
const Pling = "Pling";
const Plang = "Plang";
const Plong = "Plong";

pub fn convert(buffer: []u8, n: u32) []const u8 {
    const writer = std.io.fie
    var bufferLoc: usize = 0;
    if (@rem(n, 3) == 0){
        @memcpy(buffer[bufferLoc..][0..Pling.len], Pling);
        bufferLoc += Pling.len;
    }
    if (@rem(n, 5) == 0){
        @memcpy(buffer[bufferLoc..][0..Plang.len], Plang);
        bufferLoc += Plang.len;
    }
    if (@rem(n, 7) == 0){
        @memcpy(buffer[bufferLoc..][0..Plong.len], Plong);
        bufferLoc += Plong.len;
    }
    // put the actual num in there
    if (bufferLoc == 0) {
        // number to string
        const actual = std.fmt.bufPrint(buffer, "{d}", .{n}) catch unreachable;
        bufferLoc += actual.len;
    }
    return buffer[0..bufferLoc];
}
