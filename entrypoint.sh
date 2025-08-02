#!/bin/sh
echo "Starting application..."
echo "Looking for JAR files in build/libs/:"
ls -la build/libs/

# Find the executable JAR (not the -plain.jar)
JAR_FILE=$(find build/libs -name "*.jar" ! -name "*-plain.jar" | head -1)
echo "Using JAR file: $JAR_FILE"

if [ -z "$JAR_FILE" ]; then
    echo "ERROR: No executable JAR file found!"
    exit 1
fi

echo "Starting JAR file..."
exec java -jar "$JAR_FILE"
