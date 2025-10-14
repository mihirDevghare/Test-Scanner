#!/usr/bin/env bash
set -euo pipefail

REPO_NAME="privacy-test-repo"
TEST_DIR="$(pwd)/${REPO_NAME}"

if [ -d "$TEST_DIR" ]; then
  echo "Directory $TEST_DIR already exists. Remove or pick another location."
  exit 1
fi

mkdir -p "$TEST_DIR"
cd "$TEST_DIR"
git init

# Commit 1: Add a config file with synthetic PII and a fake AWS key
cat > app_config.py <<'PY'
# app_config.py - synthetic test file
# DO NOT USE THESE AS REAL CREDENTIALS

# Synthetic PII
user_full_name = "John Q. Doe"
user_email = "john.doe@example.test"
user_phone = "+1-555-0100"

# Synthetic AWS-like key (placeholder format; not real)
aws_access_key_id = "AKIAEXAMPLE000000000000"  # fake placeholder
aws_secret_access_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"  # fake placeholder

# Generic high-entropy token to trigger Generic Token rule
api_token = "TJSb7m3y8pQ1Zc6G4v9n2sE0uXrWqLkYzAaBcDeFgHiJkLmOpQr"
PY

git add app_config.py
git commit -m "Added app_config.py with synthetic PII and fake keys"

# Commit 2: Add a file that looks like a private key header
mkdir -p keys
cat > keys/fake_private.key <<'KEY'
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAu0/EXAMPLEPRIVATEKEYDATAK89aR6iF2....
-----END RSA PRIVATE KEY-----
KEY

git add keys/fake_private.key
git commit -m "Add synthetic private key file (for testing only)"

# Commit 3: Remove the secret from config (simulate accidental removal later)
sed -i "s/aws_access_key_id = .*//" app_config.py || true
sed -i "s/aws_secret_access_key = .*//" app_config.py || true

cat >> app_config.py <<'PY'
# Keys removed from working tree to simulate remediation
# (they remain in the commit history)
PY

git add app_config.py
git commit -m "Remove keys from app_config.py (simulate remediation)"

# Commit 4: Add README and privacy docs
cat > README.md <<'MD'
# Privacy Test Repo
This repo contains synthetic test data (PII-like placeholders, fake keys) for static-scanner testing.
DO NOT USE REAL CREDENTIALS HERE.
MD

cat > SECURITY.md <<'MD'
# Security / Responsible Disclosure
This repository is for local testing only.
MD

git add README.md SECURITY.md
git commit -m "Add README and SECURITY.md"

echo "Created test repo at: $TEST_DIR"
echo "Git log (latest 5 commits):"
git --no-pager log --oneline -n 5
echo
echo "Files:"
ls -R
