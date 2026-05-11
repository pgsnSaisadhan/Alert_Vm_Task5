#!/bin/bash

echo "Starting stress tests..."

# =========================
# 1. CPU Warning (>75%)
# =========================
echo "Testing CPU Warning..."
stress --cpu 4 --timeout 300

# =========================
# 2. CPU Critical (>95%)
# =========================
echo "Testing CPU Critical..."
stress --cpu 8 --timeout 300

# =========================
# 3. Memory Warning
# =========================
echo "Testing Memory Warning..."
stress --vm 2 --vm-bytes 2G --timeout 300

# =========================
# 4. Memory Critical
# =========================
echo "Testing Memory Critical..."
stress --vm 4 --vm-bytes 2G --timeout 300

# =========================
# 5. Disk Test (optional)
# =========================
echo "Testing Disk..."
stress --hdd 2 --timeout 300

echo "All tests completed"