const std = @import("std");
const mem = std.mem;

pub fn toRna(allocator: mem.Allocator, dna: []const u8) mem.Allocator.Error![]const u8 {
    var rna: std.ArrayList(u8) = .empty;
    errdefer rna.deinit(allocator);
    for (dna) | d | {
        try rna.append(allocator, switch (d){
            'G' => 'C',
            'C' => 'G',
            'T' => 'A',
            'A' => 'U',
            else => unreachable
        });
    }
    // transfer ownership of the internally managed buffer to the caller,
    // then deinit can be called safely
    return rna.toOwnedSlice(allocator);
}
