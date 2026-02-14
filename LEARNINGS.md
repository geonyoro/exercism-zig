# Zig Learnings: Comptime Iteration & Loop Unrolling

## 1. Tuples vs. Arrays
In Zig, the syntax `.{ ... }` creates an **Anonymous Struct** (Tuple).
- **Tuples:** Can contain heterogeneous types (e.g., `.{ 42, "Hello", true }`). Each element is accessed via a compile-time index.
- **Arrays:** `[_]T{ ... }` requires every element to be the exact same type (`T`). These can be iterated with a standard `for` loop at runtime.

## 2. Why `inline for`?
`inline for` is a **Comptime Control Flow** mechanism, not just an optimization hint.
- **Mandatory for Tuples:** Because a tuple's elements can have different types, a runtime loop cannot handle them. `inline for` "pastes" a unique version of the loop body for each element, allowing the compiler to type-check each iteration independently.
- **Type Pruning:** When combined with `if (@TypeOf(item) == T)`, the compiler deletes branches that don't match the current iteration's type, resulting in zero runtime overhead for "generic-like" logic.
- **Comptime Values:** It ensures that loop values (like divisors in `raindrops`) are treated as `comptime_int`. This allows the compiler to replace slow division instructions with specialized, faster machine code (multiplications/shifts).

## 3. Performance & Architecture Trade-offs
A Staff Engineer evaluates `inline for` based on "Sustainable Simplicity":
- **Pros:** Eliminates loop overhead; enables aggressive pruning/optimization.
- **Cons (Instruction Cache Trap):** Unrolling large loops causes **Binary Bloat**, which can crash the CPU's L1 Instruction Cache and degrade performance.

## 4. Error Handling: `catch unreachable`
- **Definition:** Tells the compiler a failure is logically impossible.
- **Staff Engineer's Rule:** Use it only when you have **mathematically proven** the safety (e.g., a `u32` will always fit in a 15-byte buffer).
- **The "3 AM Rule":** In public APIs, prefer propagating errors (`!T`) or using `std.debug.assert` to protect against future developers changing constraints (e.g., switching from `u32` to `u64`).

## 5. Rule of Thumb
- Use **Standard `for`** for general data processing.
- Use **`inline for`** for Metaprogramming (Tuples/Structs) or very small, performance-critical loops where values are known at compile-time.
