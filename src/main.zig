const std = @import("std");
const FifoPeerContext = @import("svckit/fullduplex-fifo-context.zig").FifoPeerContext;
const FullDuplexPeer = @import("svckit/fullduplex-peer.zig").FullDuplexPeer;
const FullDuplexPeerGateway = @import("svckit/fullduplex-peer-gateway.zig").FullDuplexPeerGateway;

pub fn main() void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    // Load FifoContext for peer1 and peer2 from environment variables
    const peer1_context = FifoPeerContext.fromEnv() catch {
        std.debug.print("Failed to load context for peer1\n", .{});
        return;
    };

    const peer2_context = FifoPeerContext.fromEnv() catch {
        std.debug.print("Failed to load context for peer2\n", .{});
        return;
    };

    // Initialize peers using FifoPeerContext
    var peer1 = FullDuplexPeer.new(peer1_context);
    var peer2 = FullDuplexPeer.new(peer2_context);

    // Initialize the gateway
    var gateway = FullDuplexPeerGateway.new();

    // Add peers to the gateway
    gateway.addPeer(peer1);
    gateway.addPeer(peer2);

    // Simulated peer communication
    const message = "Message from peer1";
    const len = @intCast(usize, message.len());

    // Send the message from peer1
    gateway.send(peer1, message, len) catch {
        std.debug.print("Failed to send message from peer1\n", .{});
    };

    // Receive the message at peer2
    const received = gateway.receive(peer2, len) catch {
        std.debug.print("Failed to receive message at peer2\n", .{});
        return;
    };

    std.debug.print("Received message at peer2: {}\n", .{received});
}
