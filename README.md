# vertx-es4x-ts-mongodb

**Vert.x ES4X + TypeScript + Reactive MongoDB** starter project.

A skeleton project for building reactive server-side applications using [ES4X](https://reactiverse.io/es4x) (EcmaScript for Eclipse Vert.x) with TypeScript and MongoDB on [GraalVM](https://www.graalvm.org).

## Stack

| Component | Version |
|---|---|
| ES4X (`@es4x/create`) | 0.22.0 |
| Vert.x (`@vertx/core`) | 4.5.14 |
| Vert.x Web (`@vertx/web`) | 4.5.14 |
| Vert.x Mongo Client (`@vertx/mongo-client`) | 4.5.14 |
| TypeScript | ^5.8.0 |
| Runtime | GraalVM CE for JDK 17.0.9 (GraalJS 23.0.2) |

## Prerequisites

- **[Node.js](https://nodejs.org)** (for npm package management)
- **[GraalVM CE for JDK 17.0.9](https://github.com/graalvm/graalvm-ce-builds/releases/tag/jdk-17.0.9)** — must be on your `PATH` as `java`
  - After installing, run: `gu install js` (installs GraalJS 23.0.2 language component)

## Quick Start

```sh
# Install npm + Java/Maven dependencies
npm install

# Start the server (compiles TypeScript first via prestart hook)
npm start

# Run tests
npm test

# Development mode with hot-reload
npm run dev
```

The server listens on **http://localhost:3000** by default.

## Project Structure

```
├── index.ts            # Application entry point (TypeScript)
├── index.test.ts       # Test suite (Vert.x Unit)
├── package.json        # npm + ES4X project configuration
├── tsconfig.json       # TypeScript compiler options
├── scripts/
│   └── patch-es4x.sh   # Patches ES4X PM JAR version check (see Troubleshooting)
└── dist/               # Compiled JS output (generated)
```

> **Note**: The `postinstall` script runs `scripts/patch-es4x.sh` before `es4x install` to work around a [version detection bug](https://github.com/reactiverse/es4x/issues/609) in ES4X on GraalVM CE JDK 17.0.9.

## Documentation

See **[Vertx-ES4X-Developer-Guide.md](./Vertx-ES4X-Developer-Guide.md)** for the comprehensive developer workflow guide.

## Packaging (Docker)

```sh
# Generate a Dockerfile
es4x dockerfile

# Build the image
docker build -t vertx-es4x-ts-mongodb:latest .

# Run the container
docker run --rm --net=host vertx-es4x-ts-mongodb:latest
```

## Links

- [ES4X Documentation](https://reactiverse.io/es4x)
- [ES4X GitHub](https://github.com/reactiverse/es4x)
- [Eclipse Vert.x](https://vertx.io)
- [GraalVM](https://www.graalvm.org)
