# threat-modelling-project
This repository shows detailed threat modeling DFD and workflows

# congatec COM-HPC Mini Hardware/Software Threat Model

This repository demonstrates a **Docs-as-Code** approach to threat modeling for embedded hardware targets. It models the **congatec COM-HPC Mini** ecosystem across four core trust boundaries.

## System Threat Model Diagram
![congatec COM-HPC Mini Threat Model](dfd-diagram.png)

## Threat Matrix & Compliance
For the complete STRIDE threat analysis mapped against **OWASP ASVS**, **NIST SP 800-53/161**, **ISO/IEC 27001**, and **IEC 62443**, see [`docs/stride-matrix.md`](docs/stride-matrix.md).

## CI/CD Validation
This repository includes an automated pipeline (`.github/workflows/markdown-lint.yml`) that validates compliance checks and executes acceptance testing scripts located in `/src/`.