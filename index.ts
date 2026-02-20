/// <reference types="@vertx/core" />
// @ts-check

import { Router } from "@vertx/web";

// Create a Vert.x Web Router for structured route handling
const router = Router.router(vertx);

// Health check endpoint
router.get("/health").handler((ctx: any) => {
  ctx.response()
    .putHeader("content-type", "application/json")
    .end(JSON.stringify({ status: "UP" }));
});

// Default root endpoint
router.get("/").handler((ctx: any) => {
  ctx.response()
    .putHeader("content-type", "text/plain")
    .end("Hello from Vert.x ES4X + TypeScript!");
});

// Start the HTTP server with the router
vertx
  .createHttpServer()
  .requestHandler(router)
  .listen(3000)
  .then(
    () => console.log("Server started on port 3000"),
    (err: any) => console.error("Failed to start server: " + err.getMessage())
  );
