const std = @import("std");
const Context = @import("svckit/context.zig").Context; // Import the missing Context
const FifoPeerContext = @import("svckit/fullduplex-fifo-context.zig").FifoPeerContext;
const FullDuplexPeerGateway = @import("svckit/fullduplex-peer-gateway.zig").FullDuplexPeerGateway;

pub const FullDuplexPeer = struct {
    id: []const u8,
    read_fifo: []const u8,
    write_fifo: []const u8,
    gateway: *FullDuplexPeerGateway, // Reference to the gateway

    pub fn new(context: FifoPeerContext, gateway: *FullDuplexPeerGateway) FullDuplexPeer {
        return FullDuplexPeer{
            .id = context.peer_id,
            .read_fifo = context.read_fifo,
            .write_fifo = context.write_fifo,
            .gateway = gateway,
        };
    }

    pub fn send(self: *FullDuplexPeer, ctx: *const Context, message: []const u8, length: usize) !void {
        try self.gateway.send(ctx, self, message, length);
    }

    pub fn send_all(self: *FullDuplexPeer, ctx: *const Context, messages: []const []const u8, length: usize) !void {
        try self.gateway.send_all(ctx, self, messages, length);
    }

    pub fn receive(self: *FullDuplexPeer, ctx: *const Context, buffer: []u8, length: usize) !usize {
        return try self.gateway.receive(ctx, self, buffer, length);
    }

    pub fn receive_all(self: *FullDuplexPeer, ctx: *const Context, buffers: []u8, lengths: []usize) !usize {
        return try self.gateway.receive_all(ctx, self, buffers, lengths);
    }
};
