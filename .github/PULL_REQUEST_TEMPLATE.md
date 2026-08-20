## Security Review Checklist (OWASP ASVS & IEC 62443-4-1 Alignment)

### 1. Threats & Requirements Traceability
- [ ] This PR addresses Jira Ticket: `SEC-XXX`
- [ ] Mapped to Threat Matrix ID: `THR-XXX` inside `docs/security/stride-matrix.md`

### 2. OWASP ASVS Controls
- [ ] **ASVS V5 (Input Validation):** All incoming variables and buffers are checked for length and type bounds.
- [ ] **ASVS V6 (Cryptography):** Cryptographic keys use strong algorithms (e.g., AES-256, RSA-4096) and are stored in HSM/TPM.
- [ ] **ASVS V14 (Build & Pipeline):** Dependabot/Trivy SCA scanners report no Critical/High CVEs in dependencies.

### 3. Verification & Evidence
- [ ] SAST / CodeQL build checks passed in GitHub Actions pipeline.
- [ ] Approved by designated Code Owner (`CODEOWNERS`).