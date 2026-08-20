# STRIDE Threat Matrix & Risk Assessment

> **Standard Compliance:** IEC 62443-4-1 (Practice 3: SD-2 Threat Modeling)  
> **System Component:** UEFI Firmware & SPI Flash Memory  
> **Last Updated:** August 2026  

---

## 1. System Overview & Boundaries
This document details the threat modeling assessment for the pre-boot and UEFI firmware components using the STRIDE methodology.

---

## 2. STRIDE Threat Log

| Threat ID | Threat Name | STRIDE | Description | OWASP ASVS v4.0.3 | NIST SP 800-53 / 800-161 | ISO/IEC 27001:2022 | IEC 62443-4-1 / 4-2 | Acceptance Criteria (Definition of Done) | Mitigation Status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **THR-01** | External High-Speed DMA Hijack | Tampering, Elevation of Privilege | Malicious PCIe Gen5 / USB4 device issues raw DMA read/write commands to compromise host DRAM memory. | **V14.2.1** (Input Validation)<br>**V14.1.3** (Hardware I/O Control) | **NIST SP 800-53:** AC-3, SC-7<br>**NIST SP 800-161:** SR-3 (Supply Chain) | **A.8.20** (Network Security)<br>**A.8.22** (Access Control) | **IEC 62443-4-2:** CR 1.1 (Access Control)<br>CR 2.1 (Authorization) | 1. Enable Intel VT-d / AMD-Vi IOMMU in UEFI config.<br>2. Block unassigned DMA buffer memory addresses.<br>3. Verify automated hardware DMA protection test passes. | **Mitigated** |
| **THR-02** | Real-Time Hypervisor Memory Boundary Break | Elevation of Privilege, Tampering | Untrusted Guest OS (Linux) exploits shared memory or SMM interface to escape virtualization into VxWorks real-time space. | **V14.1.1** (Architecture)<br>**V5.1.1** (Memory Isolation) | **NIST SP 800-53:** SC-39 (Process Isolation)<br>AC-6 (Least Privilege) | **A.8.31** (Separation of Development/Test/Prod) | **IEC 62443-4-2:** CR 2.4 (Mobile Code Isolation)<br>**IEC 62443-4-1:** SM-4 | 1. Enforce strict VT-x page tables separating Guest OS and VxWorks.<br>2. Disable direct SMM pointer dereferencing from Guest OS.<br>3. Run automated hypervisor boundary fuzzing in CI pipeline with 0 crashes. | **Verified** |
| **THR-03** | CG0S Driver Command & Privilege Abuse | Spoofing, Tampering | Local unprivileged application calls `/dev/cgos` or `cgos.sys` IOCTLs to tamper with watchdog, thermal, or board power states. | **V4.1.2** (Access Control)<br>**V1.10.1** (Malicious Code Defenses) | **NIST SP 800-53:** CM-7 (Least Functionality)<br>AC-6 | **A.8.2** (Privileged Access Rights)<br>**A.8.9** (Configuration Management) | **IEC 62443-4-2:** CR 1.2 (Software Execution Enforcement)<br>CR 2.2 | 1. Set filesystem permissions on `/dev/cgos` to `root:root 0600`.<br>2. Mandate valid EV code-signing signatures for Windows `cgos.sys` drivers.<br>3. Verify non-root user execution fails with `EACCES` / `Access Denied`. | **Verified** |
| **THR-04** | Physical Bus Sniffing & Flash Tampering | Information Disclosure, Tampering | Attacker uses physical logic analyzer on eSPI bus to extract TPM data or re-flashes 32MB SPI Flash via external programmer. | **V14.3.2** (Hardened Hardware)<br>**V6.2.1** (Secrets Protection) | **NIST SP 800-53:** SI-7 (Software/Firmware Integrity)<br>SC-28 | **A.8.24** (Use of Cryptography)<br>**A.7.14** (Redundant Physical Security) | **IEC 62443-4-2:** CR 3.4 (Software Integrity)<br>CR 3.9 (Physical Security) | 1. Enable Intel Boot Guard (ACM) Root of Trust.<br>2. Configure TPM 2.0 encrypted session bus communications over eSPI.<br>3. Cryptographically verify signature on UEFI image prior to system initialization. | **Verified** |

---

## 3. Residual Risk Sign-Off
All high and critical threats identified during the threat modeling session have been mitigated with technical controls.

## System Data Flow Diagram

![COM-HPC Mini DFD Diagram](./dfd-diagram.png)