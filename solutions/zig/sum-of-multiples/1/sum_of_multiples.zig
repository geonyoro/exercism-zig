const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    var multiples: std.ArrayList(u32) = .empty;
    defer multiples.deinit(allocator);
    var idx: u32 = 0;
    while (true) {
        idx += 1;
        var allocated: bool = false;
        for (factors) | f | {
            const m = f * idx;
            if (m > 0 and m < limit){
                try multiples.append(allocator, m);
                allocated = true;
            }
        }
        if (!allocated){
            break;
        }
    }

    return cleanAndSum(multiples.items);
}

pub fn cleanAndSum(multiples: []const u32) !u64 {
    // clean up step later
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var seen:std.ArrayList(u32) = .empty;
    defer seen.deinit(allocator);

    var total: u64 = 0;
    for (multiples) | i | {
        var found = false;
        for (seen.items) | s | {
            if (s == i) {
                found = true;
            }
        }
        if (!found) {
            total += i;
            try seen.append(allocator, i);
        }
    }
    return total;
}
