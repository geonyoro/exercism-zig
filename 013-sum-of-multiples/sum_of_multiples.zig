const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    var seen = try std.bit_set.DynamicBitSet.initEmpty(allocator, limit);
    defer seen.deinit();
    var total: u64 = 0;
    var idx: u32 = 1;
    while (true) {
        var allocated: bool = false;
        for (factors) | f | {
            if (f == 0) continue;
            const m: usize = @as(usize, f) * idx;
            if (m > 0 and m < limit){
                if (!seen.isSet(m)){
                    total += m;
                    seen.set(m);
                }
                allocated = true;
            }
        }
        if (!allocated){
            break;
        }
        idx += 1;
    }

    return total;
}
