const std = @import("std");
const c = @cImport({
    @cInclude("raylib.h");
});

pub fn main() !void {
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    const title =
        \\
        \\+---------------------+
        \\|       raylib        |
        \\+---------------------+
        \\
    ;
    try stdout.print("{s}", .{title});

    try bw.flush();

    // I noticed without VSYNC flag and a target FPS,
    // the GPU runs full speed ahead i.e. 100% utilization
    //
    // Sample full screen mode:
    // c.SetConfigFlags(c.FLAG_FULLSCREEN_MODE | c.FLAG_VSYNC_HINT);
    c.SetConfigFlags(c.FLAG_VSYNC_HINT);

    c.InitWindow(800, 600, "Zig + Raylib Template");
    defer c.CloseWindow();

    c.SetTargetFPS(24);

    while (!c.WindowShouldClose()) {
        c.BeginDrawing();
        defer c.EndDrawing();

        c.ClearBackground(c.RAYWHITE);

        c.DrawText("All your codebase are belong to us", 190, 200, 20, c.LIGHTGRAY);

        // The following line is not needed, I'm experimenting with
        // lowering the GPU power usage by limiting the draw call
        // on this simple DrawText loop
        //
        // This is NOT a good practice though!
        std.time.sleep(100 * std.time.ns_per_ms);
    }
}
