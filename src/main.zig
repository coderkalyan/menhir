const std = @import("std");

export fn main() noreturn {
    const uart: *volatile u8 = @ptrFromInt(0x1000_0000);
    for ("Hello, world!\n") |c| uart.* = c;

    while (true) {}
}
