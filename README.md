# TeddyVersion Infra

The initial plan is for this repo to house terraform for configuring GCP assets. It might expand scope at a later date.

### Permissions

- GCP - Right now, access is provisioned by a service account key located in `sa_key.json` at the root of the repo. **DO NOT CHECK THIS FILE IN UNDER ANY CIRCUMSTANCES**
- GitHub - Access token required to be set as `GITHUB_TOKEN` in the environment.
