const std = @import("std");

pub const Context = struct {};

pub const FullDuplexer = struct {
    send: fn (*FullDuplexer, *Context, *std.io.Reader, u64) !usize,
    send_all: fn (*FullDuplexer, *Context, []const std.io.Reader, u64) !usize,
    receive: fn (*FullDuplexer, *Context, *std.io.Writer, u64) !usize,
    receive_all: fn (*FullDuplexer, *Context, []const std.io.Writer, u64) !usize,
};
