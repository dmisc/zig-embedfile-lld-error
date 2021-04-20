const std = @import("std");

const header_magic = 0x42424242; // "BBBB"

pub const Header = packed struct {
    magic: u32,
    a: u8,
    b: u8,
};

fn getHeader(data: []const u8) Header {
    std.debug.assert(data.len >= @sizeOf(Header));

    const header = @ptrCast(*const Header, &data[0]);

    // Doesn't fail without this if
    if (header.magic == header_magic) {
        return header.*;
    }

    @panic("invalid header");
}

const file_bytes = @embedFile("data.txt");
const file_header = getHeader(file_bytes);

pub fn main() void {
    std.debug.print("{}\n", .{file_header});
}
