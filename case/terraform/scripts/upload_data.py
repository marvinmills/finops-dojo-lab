import argparse
import subprocess
import sys
from pathlib import Path

import boto3


def get_terraform_output(name: str) -> str:
    result = subprocess.run(
        ["terraform", "output", "-raw", name],
        capture_output=True,
        text=True,
        check=True,
    )
    return result.stdout.strip()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--csv",
        default="../data/billing.csv",
        help="Path to local CSV relative to terraform/ folder",
    )
    parser.add_argument(
        "--bucket-output",
        default="finops_data_bucket_name",
        help="Terraform output name for the S3 bucket",
    )
    parser.add_argument(
        "--s3-key",
        default="datasets/case-01/billing.csv",
        help="S3 object key to upload to",
    )
    parser.add_argument(
        "--profile",
        default=None,
        help="Optional AWS CLI profile name, e.g. finops-dojo",
    )
    parser.add_argument(
        "--region",
        default=None,
        help="Optional AWS region override",
    )
    args = parser.parse_args()

    terraform_dir = Path(__file__).resolve().parent.parent
    csv_path = (terraform_dir / args.csv).resolve()

    if not csv_path.exists():
        print(f"ERROR: CSV not found at {csv_path}", file=sys.stderr)
        sys.exit(1)

    try:
        bucket_name = subprocess.run(
            ["terraform", "output", "-raw", args.bucket_output],
            cwd=terraform_dir,
            capture_output=True,
            text=True,
            check=True,
        ).stdout.strip()
    except subprocess.CalledProcessError as e:
        print("ERROR: Could not read Terraform output for bucket name.", file=sys.stderr)
        print(e.stderr, file=sys.stderr)
        sys.exit(1)

    session_kwargs = {}
    if args.profile:
        session_kwargs["profile_name"] = args.profile

    session = boto3.Session(**session_kwargs)
    s3_kwargs = {}
    if args.region:
        s3_kwargs["region_name"] = args.region
    s3 = session.client("s3", **s3_kwargs)

    s3.upload_file(str(csv_path), bucket_name, args.s3_key)

    print("Upload successful.")
    print(f"Local file: {csv_path}")
    print(f"S3 URI: s3://{bucket_name}/{args.s3_key}")


if __name__ == "__main__":
    main()