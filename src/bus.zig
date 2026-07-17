pub const Bus = struct {
    memory: [0x10000]u8 = [_]u8{0} ** 0x10000,

    pub fn read8(self: *const Bus, address: u16) u8 {
        return self.memory[@as(usize, address)];
    }

    pub fn write8(
        self: *Bus,
        address: u16,
        value: u8,
    ) void {
        self.memory[@as(usize, address)] = value;
    }
};

test "write8 and read8" {
    const std = @import("std");

    var bus = Bus{};

    bus.write8(0xC000, 0x42);

    try std.testing.expectEqual(
        @as(u8, 0x42),
        bus.read8(0xC000),
    );
}