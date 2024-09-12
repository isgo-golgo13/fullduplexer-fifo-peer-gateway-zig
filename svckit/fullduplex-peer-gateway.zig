const std = @import("std");
const FullDuplexPeer = @import("svckit/fullduplex-peer.zig").FullDuplexPeer;
const Context = @import("svckit/context.zig").Context; // Import the missing Context

pub const FullDuplexPeerGateway = struct {
    active_peers: std.ArrayList(FullDuplexPeer),
    inactive_peers: std.ArrayList(FullDuplexPeer),

    pub fn new() FullDuplexPeerGateway {
        return FullDuplexPeerGateway{
            .active_peers = std.ArrayList(FullDuplexPeer).init(std.heap.page_allocator),
            .inactive_peers = std.ArrayList(FullDuplexPeer).init(std.heap.page_allocator),
        };
    }

    pub fn add_peer(self: *FullDuplexPeerGateway, peer: FullDuplexPeer) void {
        self.active_peers.append(peer) catch unreachable;
    }

    pub fn remove_peer(self: *FullDuplexPeerGateway, peer_id: []const u8) void {
        for (self.active_peers.items) |peer, idx| {
            if (std.mem.eql(u8, peer.id, peer_id)) {
                self.inactive_peers.append(peer) catch unreachable;
                self.active_peers.remove(idx) catch unreachable;
                return;
            }
        }
    }

    pub fn send(self: *FullDuplexPeerGateway, ctx: *Context, peer: *FullDuplexPeer, message: []const u8, length: usize) !void {
        try peer.send_posix(message[0..length]);
    }

    pub fn send_all(self: *FullDuplexPeerGateway, ctx: *Context, peer: *FullDuplexPeer, messages: []const []const u8, length: usize) !void {
        for (messages) |message| {
            try peer.send_posix(message[0..length]);
        }
    }

    pub fn receive(self: *FullDuplexPeerGateway, ctx: *Context, peer: *FullDuplexPeer, buffer: []u8, length: usize) !usize {
        return try peer.receive_posix(buffer[0..length]);
    }

    pub fn receive_all(self: *FullDuplexPeerGateway, ctx: *Context, peer: *FullDuplexPeer, buffers: []u8, lengths: []usize) !usize {
        var total_bytes: usize = 0;
        for (lengths) |len| {
            total_bytes += try peer.receive_posix(buffers[0..len]);
        }
        return total_bytes;
    }
};
