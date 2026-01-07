
#!/usr/bin/env bash

set -euo pipefail

echo

DB_PATH="ressources/databases/AutoRent.db"
if [[ -f "$DB_PATH" ]]; then
    rm "$DB_PATH"
    echo "Deleted database"
else
    echo "No database found"
fi

echo

# Directories and dependencies
SRC_DIR="src/main/java"
OUT_DIR="bin"
SQLITE_JAR="lib/sqlite-jdbc-3.50.3.0.jar"
JSON_JAR="lib/json-20250517.jar"

echo "Compiling files from: $SRC_DIR"

# Make sure output dir exists
mkdir -p "$OUT_DIR"

# Compile all Java files
CLASSPATH="$SQLITE_JAR:$JSON_JAR"

# Find all .java files
JAVA_FILES=$(find "$SRC_DIR" -name "*.java")

javac -cp "$CLASSPATH" -d "$OUT_DIR" $JAVA_FILES

echo "Compilation successful!"
echo

# Run program
CLASSPATH="$OUT_DIR:$SQLITE_JAR:$JSON_JAR"

export AUTORENT_DB_PATH=./ressources/databases/AutoRent.db
export AUTORENT_SAMPLE_PATH=./ressources/samples/
java -cp "$CLASSPATH" Main
