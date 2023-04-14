/// <reference types="@vertx/core" />
// @ts-check

import {HttpServer} from "@vertx/core";

let x: PromiseLike<HttpServer>

x = vertx
  .createHttpServer()
  .requestHandler(function (req: any) {
    req.response()
      .putHeader("content-type", "text/plain")
      .end("Hello!");
  }).listen(3000);

console.log('Server started on port 3000');
