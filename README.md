# OCI Repository Example

This repository contains an example of how to use an OCI repository to store and retrieve terraform artifacts and use them within the spacelift platform.

## Prerequisites

- A Spacelift Account
- Some sort of OCI repository, this repository uses ghcr.io (githubs package registry)
- An AWS Account

## Usage

From a high level, the process is as follows:
1. A developer creates a change to the `aws/important-s3-buckets` directory.
2. The developer pushes that change to git and opens a pull request.
3. Spacelift triggers a proposed change in the `oci-proposals` stack.
   - Note: this stack has policies applied to it that only allow proposals and will block any applies.
4. Once a developer confirms the proposal, they can merge the pull request to main.
5. The github action setup in `.github` will build the artifacts with `flux-cli` and push them to the OCI repository.
   - Note: the `oci-dev` stack does not get automatically triggered.
6. After the artifacts are pushed to the OCI repository, and the team is ready for the change to be promoted to the `dev` environment.
The developer can edit `locals.tf` and add the new version of the artifact into `dev_oci_version`.
7. The developer can then trigger the `oci-dev` stack.
8. Inside spacelift, the stack will pull the artifact from ghcr, and plan / apply the changes contained within.
9. After applying, the spacelift stack will then retag the image in preperation for the next environment with `{next_env}.{version}`.

![OCI Flow.png](OCI%20Flow.png)

## Repository Structure

There are 4 important directories in this repository:
- `.github` holds a workflow that builds and pushes the terraform artifacts to the OCI repository.
- `aws` holds an example s3 bucket config
- `management` is a managment stack in spacelift that will create nessesary, reusable, contexts, policies, stacks, etc.
- `modules` holds a module that can configure spacelift stacks repeatably. 
