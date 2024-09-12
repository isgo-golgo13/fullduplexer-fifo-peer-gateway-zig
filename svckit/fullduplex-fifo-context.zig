const std = @import("std");

pub const FifoPeerContext = struct {
    peer_id: []const u8,
    read_fifo: []const u8,
    write_fifo: []const u8,

    pub fn fromEnv() !FifoPeerContext {
        const env = std.os.getenv;
        const id = try env("PEER_ID");
        const read_path = try env("READ_FIFO");
        const write_path = try env("WRITE_FIFO");

        return FifoPeerContext{
            .peer_id = id orelse "peer_default", // default values if env vars not set
            .read_fifo = read_path orelse "/tmp/default_read_fifo",
            .write_fifo = write_path orelse "/tmp/default_write_fifo",
        };
    }
};
