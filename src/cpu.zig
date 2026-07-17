const std = @import("std");
const Bus = @import("bus.zig").Bus;

pub const CpuError = error{
    UnimplementedOpcode,
};

pub const Cpu = struct {
    a: u8 = 0,
    f: u8 = 0,
    b: u8 = 0,
    c: u8 = 0,
    d: u8 = 0,
    e: u8 = 0,
    h: u8 = 0,
    l: u8 = 0,

    sp: u16 = 0,
    pc: u16 = 0,

    pub fn step(self: *Cpu, bus: *Bus) CpuError!u8 {
        const opcode = bus.read8(self.pc);
        self.pc +%= 1;

        return switch (opcode) {
            // NOP
            0x00 => 4,

            else => CpuError.UnimplementedOpcode,
        };
    }
};

test "NOP increments the program counter" {
    var bus = Bus{};
    var cpu = Cpu{
        .pc = 0x0100,
    };

    bus.write8(0x0100, 0x00);

    const cycles = try cpu.step(&bus);

    try std.testing.expectEqual(@as(u16, 0x0101), cpu.pc);
    try std.testing.expectEqual(@as(u8, 4), cycles);
}