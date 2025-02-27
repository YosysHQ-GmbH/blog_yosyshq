---
title: "RISC-V Formal Verification Framework Extension for Synopsys VC Formal"
date: 2025-02-27T15:00:00+05:30
description : "riscv-formal extension for proprietary tools"
tags: ["blog"]
image: /static-2025/Sby.png, /static-2025/VCF.png
---

_This blog post is by Rohith V._

# RISC-V Formal Verification Framework Extension for Synopsys VC Formal

Imagine deploying a RISC-V processor in an embedded system, only to discover an instruction-level bug after manufacturing—this could be a costly mistake. Formal verification ensures that such issues never make it past the design phase, and tools like **riscv-formal** help automate this process. However, many engineers rely on proprietary tools like **Synopsys VC Formal**, making integration with open-source solutions a challenge—until now.  

The **riscv-formal** framework has been a game-changer, providing an open-source solution for verifying RISC-V cores against the official ISA specification. While powerful, its integration with industry-grade proprietary tools has remained complex. This project bridges that gap by extending **riscv-formal** to seamlessly interface with **Synopsys VC Formal**, enabling engineers to harness its advanced capabilities while maintaining a structured and efficient verification approach.  

In this post, we’ll explore the role of formal verification in RISC-V core validation, the motivation behind this integration, and the methodology that makes it possible. Ultimately, this extension enhances accessibility and usability, providing the broader verification community with a streamlined, industry-compatible solution.  

## About the Framework  

### Before We Dive In...  
Before diving into the project, let's take a quick look at the **riscv-formal** framework and understand why it plays a crucial role in RISC-V core verification.  

### What is `riscv-formal`?  
`riscv-formal` is an **open-source formal verification framework** designed to rigorously verify **RISC-V processors** against the **RISC-V ISA specification**. Built on the **FOSS SymbiYosys Formal Verification Flow**, it ensures that a processor implementation behaves correctly at the instruction and architectural levels.  

### Why is `riscv-formal` Important?  
- **Automated Property Checking:** Ensures compliance with the RISC-V ISA without requiring manual testbenches.  
- **Minimal Setup, Maximum Coverage:** Works with any RISC-V design using an **RVFI (RISC-V Formal Interface)** wrapper.  

### How it Works  
1. **RVFI Wrapper**: Wraps the core-under-test with an **RVFI-compliant interface** for compatibility.  
2. **Formal Checkers**: A set of **predefined checkers** checks the whole core thoroughly.  
3. **Verification Engines**: Uses predefined **assertions and constraints** to validate core behavior.  
4. **Counterexample Analysis**: If a check fails, it generates a **trace of execution (CEX)** to debug violations.  

### Limitations & Extending to Proprietary Tools  
While `riscv-formal` is highly effective for **open-source formal verification**, its native tooling (SBY/Yosys) **does not support proprietary EDA tools**. This is where our **extension** comes in—adapting `riscv-formal` for **Synopsys VC Formal**, bridging the gap between **open-source and commercial verification flows**.  

## Project Goals

The **RISC-V Formal Verification Framework Extension for Synopsys VC Formal** aims to bridge the gap between **open-source verification methodologies** and **proprietary EDA tools**. By adapting the `riscv-formal` framework (originally built for SymbiYosys) to work with **Synopsys VC Formal**, this project aims to:

- **Seamless Integration with VC Formal** – Ensure that `riscv-formal` works effortlessly with **Synopsys VC Formal**, simplifying the verification process without requiring extensive modifications.  
- **Improve Usability** – Deliver clear documentation and practical examples to help engineers effectively apply the framework.  
- **Enable Easy `.sby → .tcl` Conversion** – Support straightforward translation of `.sby` configurations into `.tcl` scripts, even outside the framework.  

By achieving these goals, the project enhances the **efficiency, accessibility, and adoption** of formal verification for **RISC-V cores**, fostering wider collaboration in the verification community.  

## Adapting riscv-formal for VC Formal & The Verification Process  

Integrating the **riscv-formal framework** with **Synopsys VC Formal** required overcoming several technical challenges, given the differences between **open-source** and **proprietary** formal verification tools.  

This section outlines the core modifications and methodology used to **bridge the gap** between these two verification environments.  


## 1. Key Challenges in Transitioning to VC Formal  

- **Conversion from SymbiYosys Flow:** The **.sby** configuration files used in riscv-formal are specific to SymbiYosys. VC Formal, on the other hand, operates using **Tcl-based** scripts, requiring a structured **translation mechanism** to adapt the verification flow.  
- **Environment Setup & Automation:** Automating the process—so that users can easily set up **VC Formal verification** with minimal manual intervention—was a key goal in this adaptation.  

## 2. Verification Process  

### i. FOSS SymbiYosys Formal Verification Flow

This flow demonstrates the formal verification process using the riscv-formal framework with the open-source SymbiYosys tool. It consists of components like RVFI, the wrapper, and `checks.cfg`. These components are used to generate `.sby` files, which are then processed by SymbiYosys to run verification checks and produce the results, ensuring that the RISC-V implementation adheres to formal specifications. This flow represents a streamlined, FOSS-based approach to formal verification.

![FOSS SymbiYosys formal verification flow](\static\static-2025\Sby.png)

### ii. Synopsys VC Formal Verification Flow

This flow illustrates the modified process, where the riscv-formal framework is used with Synopsys VC Formal. The `.sby` files from the riscv-formal framework are first converted to `.tcl` scripts using a custom `sby to tcl` converter before being processed by VC Formal to generate verification results.

![Synopsys VC Formal verification flow](\static\static-2025\VCF.png)

The framework consists of **three key stages**, each automated for smooth verification:  

1. **Pre-Processing:** Converts `.sby` files into `.tcl` scripts for **VC Formal compatibility**.  
2. **Processing:** Runs the **formal checks**, collects logs, and categorizes **warnings & errors**.  
3. **Post-Processing:** Summarizes verification **results**, helping users quickly identify pass/fail conditions.  

To achieve this, we’ve extended the framework with four core components:  

### **1️⃣ sby_to_tcl.py – Automating Test Setup (Pre-Processing)**  
The `sby_to_tcl.py` script automates the **conversion of SymbiYosys `.sby` files** into **VC Formal-compatible `.tcl` scripts**. It also **creates a Makefile** that organizes multiple verification tasks, allowing batch execution with a single command.  

#### 🔹 **Why is this important?**  
- Eliminates **manual effort** in handling `.tcl` files.  
- Enables **batch verification** by processing multiple `.sby` files at once.  
- Organizes output systematically in a dedicated `vcf` directory.  

### **2️⃣ vcf_cexdata.sh – Error & Warning Processing (Processing Stage)**  
During the verification execution, the `vcf_cexdata.sh` script ensures **structured handling of warnings and errors**. Instead of overwriting logs, it **captures and organizes logs** for all checks, ensuring **every warning/error is properly recorded**.  

#### 🔹 **Key Features:**  
- Prevents loss of information by **storing logs separately**.  
- Formats errors in an **easy-to-read structure** (`warnings.txt`, `errors.txt`).  
- Provides a **quick summary** of issues across multiple checks.  

### **3️⃣ vcf_res_process.py – Summarizing Verification Results (Post-Processing)**  
After verification, `vcf_res_process.py` extracts key results from each check, categorizing assertions as **PASS, FAIL, or INCONCLUSIVE** and consolidating everything into a **single summary file (`results.txt`)**.  

#### 🔹 **Why does this matter?**  
- **Saves time**—no need to inspect multiple files manually.  
- Provides a **high-level overview** of all formal verification checks.  
- Helps users **quickly identify issues** that need further debugging.  

### **4️⃣ Makefile – Automating the Entire Workflow**  
The **Makefile** serves as the backbone of automation, orchestrating all three stages. With simple commands like `make vcf_check`, users can **run all checks**, collect results, and review summaries **without manually executing scripts**.  

#### 🔹 **Key Features:**  
- **One-command execution** of all verification steps.  
- **Automated log collection & clean-up** for an organized workflow.  
- **Results displayed directly in the terminal** for quick review.  

For a **more detailed breakdown** on each file/process, check out the complete repository on **[GitHub](https://github.com/Chaotic-VRBlue/riscv-formal-vc-formal-extension?tab=readme-ov-file#file-descriptions)**! 🚀  

### General Applicability

An interesting aspect of this process is that it is **not exclusive to riscv-formal**. In fact, this approach can be adapted for any `.sby` file(s). The automation framework we've built for converting `.sby` files to `.tcl` scripts, handling formal verification results, and structuring the workflow can be applied to a wide range of formal verification tasks beyond RISC-V.

This flexibility makes it a powerful solution for integrating **SymbiYosys-based verification flows** with commercial formal tools like **Synopsys VC Formal**, streamlining the entire process across different projects.

## Going the Other Way: From VC Formal to SBY  

Let's go the other way for a bit—what if we want to take `.tcl` files from VC Formal and convert them back into `.sby` files for SymbiYosys?  

### Initial Challenges Faced with SymbiYosys  

When I first started using SymbiYosys (SBY) for formal verification, I encountered several challenges:  

- **Toolchain Dependencies**: SBY relies on open-source tools like Yosys, Boolector, and ABC. Ensuring proper installation and configuration was time-consuming.  
- **Assertion Language Differences**: SystemVerilog Assertions (SVA) supported in VC Formal required workarounds in SBY due to syntax or feature limitations.  

Despite these hurdles, **open-source formal verification tools** have improved significantly and can handle complex verification tasks.  

### Automating the Conversion: From `.tcl` to `.sby`  

The scripting ideas used in our Python automation can serve as a foundation for reversing the process. Just like `sby_to_tcl.py` converts `.sby` to `.tcl`, a similar script could parse `.tcl` files and generate `.sby` files, but key challenges remain:  

- **Lack of Direct Equivalence**: VC Formal scripts contain proprietary directives that do not have an exact counterpart in SymbiYosys.  
- **Complex Conversions**: While a fully automated VC Formal-to-SBY conversion may not be feasible, structured scripting can reduce manual effort significantly.  

Fortunately, once the `.sby` files are reconstructed, the existing **riscv-formal automation**—Makefile execution, error handling, and result processing—remains intact.  

A structured conversion process would enable **bidirectional compatibility** between open-source and proprietary formal verification tools.  

### SymbiYosys Flow vs. VC Formal Flow  

Comparison of **SymbiYosys Flow** and **Synopsys VC Formal (VCF)** flows:  

| **Flow**                    | **SymbiYosys (SBY) Flow** | **VC Formal (VCF) Flow** |
|-----------------------------|--------------------------|--------------------------|
| **Configuration File**       | `.sby` file (SBY-based) | `.tcl` file (Tcl-based) |
| **Tool Used**               | SymbiYosys + Yosys       | Synopsys VC Formal       |
| **Solver Backend**          | Boolector, Yices2, etc.,    | Synopsys’ internal solvers |
| **Counterexample Debugging** | GUI-based + logs  | GUI-based + logs |
| **Execution Automation**    | Python, Shell & Makefile  | Python, Shell & Makefile |
|

## Future Scope

1. **Extending to Other Proprietary Tools**  
   While this extension integrates Synopsys VC Formal with riscv-formal, the approach can be further extended to other commercial formal verification tools. Automating `.sby` file conversion and structured result handling can help streamline workflows across multiple environments.

2. **Maintaining Compatibility with File Format Changes**  
   This extension relies on the `.sby` file structure from riscv-formal and the `.tcl` scripting format used by VC Formal. If either of these formats evolve, updates will be needed to ensure compatibility. Keeping the automation scripts adaptable to such modifications will be crucial for long-term usability.

By continuously adapting, this extension can remain a valuable tool for formal verification, extending its reach to new tools and maintaining alignment with updates in the riscv-formal ecosystem.

## Results  

We have successfully developed a complete extension that seamlessly integrates the **riscv-formal framework** with **Synopsys VC Formal (VCF)**, ensuring an efficient, automated, and user-friendly verification experience.  

Using this **extended framework**, we formally verified our **Single Cycle RISC-V core (SCRV32I)** and cross-checked results with **SymbiYosys**. The verification confirms that our core adheres to the **RISC-V ISA specifications**, ensuring correctness and compliance.  

### 🔍 Practical Example 
To demonstrate the workflow, we have included the **SCRV32I processor** as a reference. This provides a **step-by-step guide** to:  
- Understanding the verification setup.  
- Running formal verification on SCRV32I.  

Additionally, we provide a dedicated section on:  
- Configuring the process for custom RISC-V designs.  

This practical approach ensures that users can **replicate adapt, and extend** the verification flow to their own processor designs.  

## Running the Example SCRV32I Processor (For Understanding the Workflow)

1. Clone the Repository [GitHub](https://github.com/Chaotic-VRBlue/riscv-formal-vc-formal-extension/)
   ```bash
   git clone https://github.com/Chaotic-VRBlue/riscv-formal-vc-formal-extension.git
   cd riscv-formal-vc-formal-extension
   ```

2. Navigate to the Core and Clean Previous Files and Results
   ```
   cd cores/scrv32i
   make vcf_clean
   ```

3. Run All Checks Automatically and View Results
   ```
   make vcf_check
   ```

   Once the process is complete, the terminal will display results in the following order:
   - Warnings
   - Errors
   - Verification results (PASS/FAIL/INCONCLUSIVE/UNKNOWN; If failed to run)

   These outputs are also saved in the `vcf_cexdata` folder for later review.

4. *(Optional)* Run a Specific Check:
   To run a specific formal verification check, use the following commands:
   ```
   cd vcf/{check_name}
   vcf -f {check_name}.tcl -batch
   ```
   This runs the selected check in **batch mode** and generates a result file named `{check_name}_results.txt`, where you can review the verification results.

   If you want to run the check directly in **GUI mode** for interactive debugging, use:
   ```
   vcf -f {check_name}.tcl -verdi
   ```
   This command launches **Verdi**, allowing you to visually analyze results and debug in an interactive environment.

5. View Waveforms in GUI Mode for Debugging:
   If you encounter a failing check or wish to analyze waveforms for a specific check:
   ```
   cd vcf/{check_name}
   vcf -restore -session {check_name}_results
   ```
   ```
   start_gui
   ```
   Since the formal verification for this check has already been run, there is no need to rerun it. Simply restore the session to view the waveforms in **GUI mode**. *Note that only one check can be analyzed in GUI mode at a time*.

6. Fix Bugs and Rerun Checks:
After debugging and making necessary fixes, you can rerun the verification. However, ensure you clean the previous results first:
   ```
   make vcf_clean
   make vcf_check
   ```
7. *(Optional)* Customize Checks to Run or Skip (do this before running):
You can configure which checks to run or skip by creating configuration files in the `vcf_checks_config` folder within the core directory (e.g., `cores/scrv32i`):

   - Case 1: Skip Specific Checks -
Create a file named `checks_to_skip.txt` and list the checks to skip, each separated by a space.
   - Case 2: Run Specific Checks Only -
Create a file named `checks_to_run.txt` and list the checks to run, separated by spaces.
   - Case 3: Default Mode (Run All Checks) -
If no configuration files are present, all checks will run by default.
   - Case 4: Conflict Between Files -
If both `checks_to_skip.txt` and `checks_to_run.txt` exist simultaneously, the program will terminate with an error message indicating that this setup is not supported.

## Configuring a New RISC-V Processor

1. First, refer to the `riscv-formal` repository and follow the steps outlined in the [riscv-formal guide](https://github.com/YosysHQ/riscv-formal?tab=readme-ov-file#configuring-a-new-risc-v-processor). Complete everything up to step 5. You don't need to run step 5, as it involves using an open-source tool. For our purpose, we will run it using the VC Formal tool, so step 5 can be skipped. If you're interested, you can explore it, but it's not required for this process.

2. Once the `RVFI` (RISC-V Formal Interface), `wrapper.sv` file, and `checks.cfg` file are implemented for your RISC-V processor as per the steps in the `riscv-formal` repository, you can proceed with running the RISC-V formal framework for your core on the Synopsys VC Formal Tool.

   *(Note: You may need to refer to the entire repository to complete this part, not just the section I linked here.)*

3. Copy the `vcf_cexdata.sh` and `Makefile` files from the `scrv32i` folder into your core folder.

   *(Note: Only the vc_formal folder in the root directory, the vcf_cexdata.sh file in the scrv32i folder, and a few additions to the Makefile inside the scrv32i directory were created to implement this extension. - So copy these files/folder to the right location and it should work with no hassle)*

4. Navigate to your core directory and run:
   ```bash
   cd cores/{core}
   make vcf_clean
   make vcf_check
   ```

   Once the process is complete, the terminal will display results in the following order:
   - Warnings
   - Errors
   - Verification results (PASS/FAIL/INCONCLUSIVE/UNKNOWN - If failed to run)

5. Then you can utilize features such as running specific checks (including in GUI mode), launching the GUI, and customizing checks to run or skip, as shown in the 'Running the Example SCRV32I Processor (For Understanding the Workflow)' section above.

## Conclusion

### Bridging the Gap: RISC-V Formal Meets Synopsys VC Formal  

The **RISC-V Formal Verification Framework Extension** for **Synopsys VC Formal** bridges the gap between open-source and industry-grade proprietary tools, making formal verification more **accessible, efficient, and scalable**.  

With **automated .sby to .tcl conversion**, **structured result handling**, and **batch execution support**, this extension simplifies the entire verification process for **RISC-V cores**—and **beyond**.  

### But This Is Just the Beginning...  

The methodologies introduced here can be extended to other formal verification tasks, making it easier to integrate open-source flows with commercial EDA tools. Whether you’re using **SymbiYosys**, **VC Formal**, or exploring **bidirectional compatibility**, this framework lays the foundation for a **more automated, scalable, and interoperable** verification ecosystem.  

🔎 Want to dive deeper? Explore the **full implementation** in the GitHub repository: [riscv-formal-vc-formal-extension](https://github.com/Chaotic-VRBlue/riscv-formal-vc-formal-extension/) 🚀  

By embracing **automation, interoperability, and scalability**, we can push the boundaries of formal verification—ensuring that RISC-V processors and other designs are functionally correct and future-proof.  

Let’s build smarter, faster, and more robust verification flows—together! 🔬💡
