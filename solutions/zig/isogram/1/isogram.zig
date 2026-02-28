const std = @import("std");

pub fn isIsogram(str: []const u8) bool {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var seen:std.ArrayList(u8) = .empty;
    defer seen.deinit(allocator);

    for (str) | char | {
        var c = char;

        if (c >= 65 and c <= 90){
            // upper case, convert to lowercase
            c = c + 32;
        }

        for (seen.items) | seenc | {
            if (seenc == c){
                return false;
            }
        }
        if (c != ' ' and c != '-'){
            seen.append(allocator, c) catch {
                @panic("Out of memory.");
            };
        }
    }
    return true;
}

pub fn main() void {
    _ = isIsogram("hello");
}
