const std = @import("std");

pub fn isLeapYear(year: u32) bool {
    var val = @rem(year, 4); // get the remainer
    if (val > 0){
        return false;
    }
    // so far, evenly divisible by 4
    
    val = @rem(year, 100);
    if (val == 0){
        // evenly divisible by 100, not a leap unless
        val = @rem(year, 400);
        return val == 0;
    }
    return true;
}

pub fn main() void {
    _ = isLeapYear(1997);
    _ = isLeapYear(1900);
    _ = isLeapYear(2000);
}
