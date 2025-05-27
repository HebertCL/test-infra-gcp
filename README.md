# Couchsurfing task infra

This is a repository showing a simple 2-tier, VM based infrastructure intended to host a dummy app which performs connection to a DB

## Getting started

The configurations in this repository are functional. To spin them up you need to install terraform/open tofu.

Check the installation page of both to get them installed below:

- [Terraform]()
- [OpenTofu]()

## Repository structure

This repository is structured in 2 main folders: `environments` and `modules`. This creates a mono-repo structure with both environments and configurations in the same repository.

### Modules structure

The main purpose of `modules` folder is to host configurations blocks. These confiuration blocks are used to create different components, such as networks, compute, database or any other resources.
Modules should aim to be self-contained: This means that, while they require inputs which may come from other modules or independen resources, they should create a complete functionality.

In example, a network module that creates subnets should not depend from an external module to create VPCs etc.

Using local modules provides with the ability to easily catch and fix potential bugs that may have been introduced without the need of interacting with external repositories.
It is still possible to use tagged versions for the modules in this format, properly introducing semantic versioning and automation for it.

### Environments structure

This repo uses environment isolation approach to create infrastructure. That means every folder inside `environments` represents an isolated environment in GCP.

The environment isolation approach helps teams to easily identify environments and its respective configuration, at the expense of duplicating configurations when multiple environments share the exact same configuration.
Overall it's easier to ramp up, though it may become challenging when too many environments are required.
