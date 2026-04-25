#!/usr/bin/env python3
"""
MentalBreak Patch Manifest Generator
Generates filelist_rof.yml compatible with xackery/eqemupatcher.
Computes MD5 hashes for all patch files and writes a YAML manifest.
"""

import os
import hashlib
import zipfile

PATCH_DIR = r"D:\app ideas\MentalBreak\MentalBreak-patch\rof"
DOWNLOAD_PREFIX = "https://github.com/rsharf/MentalBreak/releases/latest/download/"
CLIENT = "rof"

SKIP_FILES = {"filelistbuilder.yml", "filelistbuilder.exe", "filelist_rof.yml", "patch.zip", "generate_manifest.py"}

def md5_file(filepath):
    h = hashlib.md5()
    with open(filepath, "rb") as f:
        for chunk in iter(lambda: f.read(8192), b""):
            h.update(chunk)
    return h.hexdigest().upper()

def main():
    entries = []
    zip_files = []

    for root, dirs, files in os.walk(PATCH_DIR):
        for fname in sorted(files):
            if fname in SKIP_FILES:
                continue
            full_path = os.path.join(root, fname)
            rel_path = os.path.relpath(full_path, PATCH_DIR).replace("\\", "/")
            md5 = md5_file(full_path)
            size = os.path.getsize(full_path)
            entries.append((rel_path, md5, size))
            zip_files.append((full_path, rel_path))

    # Write filelist_rof.yml
    manifest_path = os.path.join(PATCH_DIR, "filelist_rof.yml")
    with open(manifest_path, "w", encoding="utf-8") as f:
        f.write(f"downloadprefix: {DOWNLOAD_PREFIX}\n")
        f.write(f"version: 0.1.7.29\n")
        f.write(f"deletes:\n")
        f.write(f"downloads:\n")
        for rel_path, md5, size in entries:
            f.write(f"- name: {rel_path}\n")
            f.write(f"  md5: {md5}\n")
            f.write(f"  date: \"2026-04-25\"\n")
            f.write(f"  zip: \"\"\n")
            f.write(f"  size: {size}\n")

    print(f"[MANIFEST] Generated {manifest_path} with {len(entries)} entries")

    # Generate patch.zip
    zip_path = os.path.join(PATCH_DIR, "patch.zip")
    with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as zf:
        for full_path, rel_path in zip_files:
            zf.write(full_path, rel_path)

    zip_size = os.path.getsize(zip_path) / (1024 * 1024)
    print(f"[ZIP] Generated {zip_path} ({zip_size:.1f} MB)")
    print(f"[DONE] Ready for GitHub Release upload")

if __name__ == "__main__":
    main()
