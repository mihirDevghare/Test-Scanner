# config.py
# Synthetic configuration file for testing static scanners.
# -----------------------
# WARNING: All values below are synthetic placeholders. DO NOT use as real credentials.
# -----------------------

# --- Fake PII (personal identifiable information) ---
USER_FULL_NAME = "Jane Q. Tester"
USER_EMAIL = "jane.tester@example.test"
USER_PHONE = "+1-555-0123"
USER_ADDRESS = {
    "line1": "1234 Fictitious Ave",
    "line2": "Apt 42B",
    "city": "Testville",
    "state": "TS",
    "zip": "00000",
    "country": "Neverland"
}

# --- Fake AWS-like credentials (placeholders only) ---
# These strings are intentionally synthetic and must NOT be used as real credentials.
AWS_ACCESS_KEY_ID = "AKIAEXAMPLE000000000000"  # fake placeholder (matches AKIA[0-9A-Z]{16} style)
AWS_SECRET_ACCESS_KEY = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"  # fake placeholder

# --- Other synthetic secrets to trigger generic-token rules (high-entropy-looking) ---
API_TOKEN = "TJSb7m3y8pQ1Zc6G4v9n2sE0uXrWqLkYzAaBcDeFgHiJkLmOpQr"  # fake high-entropy token
SERVICE_PASSWORD = "P@ssw0rd!_FAKE_2025"

# --- Optional: Example (not secure) function to access config ---
def get_config_summary():
    return {
        "name": USER_FULL_NAME,
        "email": USER_EMAIL,
        "phone": USER_PHONE,
        "aws_access_key": AWS_ACCESS_KEY_ID,
        "has_privacy_info": True
    }

if __name__ == "__main__":
    # Quick sanity print (safe: printing fake values)
    import json
    print("Config summary (synthetic):")
    print(json.dumps(get_config_summary(), indent=2))
