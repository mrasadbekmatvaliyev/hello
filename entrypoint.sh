#!/bin/sh
echo "Starting application..."
echo "Looking for JAR files in build/libs/:"
ls -la build/libs/
echo "Starting JAR file..."
exec java -jar build/libs/*.jar
