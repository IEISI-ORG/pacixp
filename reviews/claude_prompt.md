`★ Insight ─────────────────────────────────────`
The two reviews reveal a key pattern: the 480-line prompt optimized for *breadth* (18 frameworks, 13 deliverables, 10 scoring dimensions) while the most valuable findings came from *depth* — specifically cross-file consistency checking. Claude caught the RPKI fail-open/fail-closed contradiction by holding two documents in view simultaneously; Gemini evaluated each file more in isolation and missed it entirely, producing an internally inconsistent "deploy immediately" verdict despite listing high-severity risks. The signal is clear: a focused prompt that directs the reviewer to verify claims against evidence outperforms a comprehensive-but-diffuse one.
`─────────────────────────────────────────────────`

Here is the focused replacement prompt:

---

```markdown
You are a senior network engineer conducting a verification-focused review of this repository.
This is a **configuration template and documentation project** — not application software.
Your job is to find gaps between what the project *claims* and what the files *actually contain*.

## Critical Constraints
- Read-only. Do not modify, commit, or create any files.
- All findings must cite specific file paths and line numbers or quoted text.
- Explicitly label each finding: FACT | INFERENCE | SPECULATION.
- Do not praise the architecture — that has already been assessed and is sound.
  Focus on defects, contradictions, and missing artifacts.

## Core Review Method: Cross-File Verification

For every significant claim in one file, find the file(s) that should confirm or implement it,
and check whether they actually do.

Specifically:

**1. Verify all cross-references exist**
Walk every reference of the form "see doc X", "as per DP-N", "config file Y", or any
file path mentioned in prose. Confirm each referenced file actually exists with the
correct filename and extension. List every broken reference.

**2. Find contradictions between documents**
Compare security-relevant claims across all docs. Key tensions to check:
- Every Design Principle has a corresponding implementation artifact — does it?
- If a principle mandates behavior X, does any other doc describe behavior Not-X?
- Does the README's maturity claim match the TODO.md?

**3. Verify implementation artifacts against stated security posture**
For each security control described in `docs/03-security-hardening.md` and
`docs/00-design-principles.md`, check whether the actual config files
(`configs/`, `labs/configs/`, `templates/`) implement that control or contradict it.

**4. Audit the lab environment for deployability**
The README claims configs are validated in a virtual lab. Verify:
- Does `labs/pacixp.clabs.yml` reference files that actually exist with matching names/extensions?
- Can the topology be deployed as-written, or are there blocking gaps?

**5. Check for credential and security hygiene in templates**
Search all configs and strategy docs for: plaintext credentials, predictable strings,
`latest` Docker tags, HTTP where HTTPS is implied, missing TLS configuration.

## Output Format

Produce a **flat, prioritized findings list** — no sections, no frameworks, no scoring.

For each finding:
```
[SEVERITY: Critical/High/Medium/Low]
[TYPE: Contradiction | Missing File | Security | Broken Reference | Incomplete]
File: <path>:<line>
Finding: <one sentence stating the defect>
Evidence: <verbatim quote or file path that proves it>
Impact: <one sentence on operational or security consequence>
Fix: <one sentence on what specifically needs to change>
```

Then a single **Prioritized Action List** — ordered by impact, not by category.
Maximum 20 items. Each item: filename, specific change needed, expected outcome.

## What NOT to produce
- Framework checklists (JTBD, STRIDE, SWOT, gap matrices)
- Architectural praise or summary
- Scoring tables
- Executive summaries
- Anything that cannot be tied to a specific file and line
```

---

The key changes from the original prompt and why they matter:

- **Method over framework** — instructs *how* to find defects (cross-file verification) rather than *what categories* to check. This is what produced Claude's RPKI finding; Gemini's framework-following approach missed it.
- **Flat findings list** — forces every output line to be actionable and cited, preventing the confident-but-wrong "production ready" conclusion that can hide in a long structured report.
- **No architectural assessment** — that work is already done; repeating it wastes tokens and invites the pattern of praising the design while burying the implementation defects.
- **Specific verification tasks** — cross-references, file extension matching, claim verification — are the exact checks that surface the `.conf`/`.cfg` mismatch, the missing member configs, and the RPKI contradiction.
