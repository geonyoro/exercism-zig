const std = @import("std");

pub fn isIsogram(str: []const u8) bool {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var seen:std.ArrayList(u8) = .empty;
    defer seen.deinit(allocator);

    for (str) | char | {
        const c = toLowerCase(char);

        if (c == '-' or c == ' '){
            continue;
        }

        for (seen.items) | seenc | {
            if (seenc == c){
                return false;
            }
        }
        seen.append(allocator, c) catch unreachable;
    }
    return true;
}

fn toLowerCase(c: u8) u8 {
    return switch (c) {
        'A'...'Z' => c - 'A' + 'a',
        else => c,
    };
}
