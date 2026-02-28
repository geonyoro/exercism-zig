const std = @import("std");

/// Writes a reversed copy of `s` to `buffer`.
pub fn reverse(buffer: []u8, s: []const u8) []u8 {
    const size: usize = s.len;
    for (s, 0..) |c, idx| {
        buffer[size-1-idx] = c;
    }
    return buffer[0..size];
}

pub fn main() void {
    var buffer: [20]u8 = undefined;
    std.debug.print("{s}", .{reverse(&buffer, "car")});
}
