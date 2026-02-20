#!/usr/bin/env bash
# patch-es4x.sh
#
# Patches the ES4X PM JAR to fix the GraalVM version detection bug.
# See: https://github.com/reactiverse/es4x/issues/609
#
# ES4X's GraalVMVersion.java regex extracts the version from
# java.vendor.version ("GraalVM CE 17.0.9+9.1" → 17.0.9), but
# VERSIONS.properties expects the GraalJS version (e.g., 23.0.2 or 23.0.7).
# This mismatch causes "Runtime GraalVM version mismatch" during es4x install.
#
# This script patches VERSIONS.properties inside the ES4X PM JAR to use
# the JDK version that the regex actually extracts.

set -e

# Auto-detect the ES4X PM JAR
PM_JAR=$(find node_modules/@es4x/create -maxdepth 1 -name 'es4x-pm-*.jar' 2>/dev/null | head -1)

if [ -z "$PM_JAR" ] || [ ! -f "$PM_JAR" ]; then
  echo "ES4X PM JAR not found — skipping patch."
  exit 0
fi

# Extract the JDK version that ES4X's regex will detect
DETECTED_VERSION=$(java -XshowSettings:all -version 2>&1 | grep "java.vendor.version" | grep -oP '\d+\.\d+\.\d+' | head -1)

if [ -z "$DETECTED_VERSION" ]; then
  echo "Could not detect GraalVM version — skipping patch."
  exit 0
fi

# Extract the current es4x version from the JAR
WORK_DIR=$(mktemp -d)
trap "rm -rf $WORK_DIR" EXIT

(cd "$WORK_DIR" && jar xf "$(cd - > /dev/null && pwd)/$PM_JAR" META-INF/es4x-commands/VERSIONS.properties)
ES4X_VERSION=$(grep '^es4x=' "$WORK_DIR/META-INF/es4x-commands/VERSIONS.properties" | cut -d= -f2)
CURRENT_GRAALVM=$(grep '^graalvm=' "$WORK_DIR/META-INF/es4x-commands/VERSIONS.properties" | cut -d= -f2)

if [ "$CURRENT_GRAALVM" = "$DETECTED_VERSION" ]; then
  echo "ES4X PM JAR already patched (graalvm=$DETECTED_VERSION) — skipping."
  exit 0
fi

# Patch VERSIONS.properties and update the JAR
printf "graalvm=%s\nes4x=%s\n" "$DETECTED_VERSION" "$ES4X_VERSION" > "$WORK_DIR/META-INF/es4x-commands/VERSIONS.properties"
(cd "$WORK_DIR" && jar uf "$(cd - > /dev/null && pwd)/$PM_JAR" META-INF/es4x-commands/VERSIONS.properties)

echo "Patched $PM_JAR — GraalVM version check: $CURRENT_GRAALVM → $DETECTED_VERSION"
