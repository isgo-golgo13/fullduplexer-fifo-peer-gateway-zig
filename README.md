# FullDuplexer Zig FIFO Sync Peer Gateway
Zig FullDuplex POSIX FIFO Peers and Central FIFO Peer Gateway using POSIX Zig LibC



## Zig vs Rust Versions

This Git repo is the logical equivalent of the Rust version here `git@github.com:isgo-golgo13/fullduplexer-fifo-peer-gateway.git`.

**NOTE**
1. Zig DOES NOT have direct equivalent to Rust traits system. Zig alternatively offers this logical equivalent
using Zig structs and function pointers.

2. Zig offers its own `async/await` constructs and it lower-level than the Rust async crates with `Tokio` and
allows explicit couroutine control.

3. Zig provides direct access to POSIX system calls so it can access APIs for FIFO files using std.fs.File and Zig’s native file I/O APIs.


## The Project Directory Structure

```shell
fullduplexer-fifo-peer-gateway-zig
├── Dockerfile.peer
├── Dockerfile.peer.gateway
├── Makefile
├── README.md
├── build.zig
├── build.zig.zon
├── docker-compose.yaml
├── src
│   └── main.zig
└── svckit
    ├── context.zig
    ├── fullduplex-fifo-context.zig
    ├── fullduplex-peer-gateway.zig
    ├── fullduplex-peer.zig
    └── fullduplexer.zig
```
