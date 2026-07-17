const std = @import("std");
const Cpu = @import("cpu.zig").Cpu;
const Bus = @import("bus.zig").Bus;

pub fn main() !void {
    var cpu = Cpu{
        .pc = 0x0100,
    };

    var bus = Bus{};
    bus.write8(0x0100, 0x00);

    const cycles = try cpu.step(&bus);

    std.debug.print(
        "PC={X:0>4} cycles={d}\n",
        .{ cpu.pc, cycles },
    );
}