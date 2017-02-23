# codecommmit-backup

## Description
Fetches all repos for an AWS account and clones them to a new folder every day/week/month as
defined to create a traditional backup schedule including retention by each folder

## Prerequisites

- Requires the AWS CLI tools for Linux: http://docs.aws.amazon.com/cli/latest/userguide/awscli-install-linux.html
- Requires AWS IAM User access key ID and secrete key configured using `aws configure` and output type `json`
- IAM User requires `AWSCodeCommitPowerUser` policy or simlar to perform clone operations

## History

23-Feb-2017: Initial script

## Credits

Written by: Anthony Siano

## License

MIT License
