# Business Registration Services Portal — Complete Form Build Prompt

## Critical Instructions

- Build this **exactly like the GST Registration module** already in the project — same landing page layout, same card design, same form page structure, same components, same styling. Do not invent anything new.
- Same white card sections on `#f3f4f6` background, `border-radius: 8px`, `padding: 24px`, subtle shadow
- Same two-column grid for side-by-side fields, full-width for single fields
- Same file upload fields: gray icon box left + white hover area right
- Same thin `1px solid #e2e8f0` borders on all inputs
- Same labels: `font-weight: 500`, small font, red `*` for required
- Same full-width indigo Submit button at the bottom of every form
- Same footer: `Pentagon Innovations - Product ©` left, `Support | Help Center | Privacy | Terms` right
- Add a new **"Business Registration"** entry in the sidebar under Auditing Services, exactly like "GST Registration" is listed
- Do NOT touch the sidebar structure, navbar, GST pages, Legal Services pages, FSSAI pages, or any other existing page

---

## Part 1 — Landing Page

### Page Header
- Title: **Business Registration** (same two-tone style — "Business" black, "Registration" blue)
- Subtitle: `End-to-end support for all types of business registrations`
- Info banner below header (same blue left-border card style): `Registering your business correctly from the start ensures legal compliance and smooth operations. Our experts handle everything from sole proprietorships to public limited companies.`

### Section Title
- `Choose your registration type` (same style as GST page)

### Service Cards (horizontal scrollable row with left/right arrows, same as GST)

| # | Card Title | Subtitle | Badge |
|---|---|---|---|
| 1 | Sole Proprietorship | Simple single-owner business | Recommended (amber pill) |
| 2 | Partnership Firm | Register with legal agreements | — |
| 3 | Private Limited Company | Incorporate with limited liability | — |
| 4 | Public Limited Company | Company for public investment | — |
| 5 | LLP | Flexible partnership with limited liability | — |
| 6 | Section 8 Company | Non-profit charitable organization | — |
| 7 | Trust Registration | Charitable or private trust | — |
| 8 | One Person Company | Single-owner limited liability | — |

---

## Part 2 — Required Documents Checklist (Dynamic, updates on card click)

**Card 1 — Sole Proprietorship** (4 documents)
- PAN Card
- Address Proof (Utility Bill / Rent Agreement)
- ID Proof (Aadhaar / Passport / Voter ID)
- Bank Account Proof

**Card 2 — Partnership Firm** (4 documents)
- PAN Cards (Firm & Partners)
- Partnership Deed
- Address Proof
- Bank Account Proof

**Card 3 — Private Limited Company** (4 documents)
- Director PAN & ID Proof
- MOA & AOA
- Registered Office Proof
- Bank Account Proof

**Card 4 — Public Limited Company** (5 documents)
- Director PAN & ID Proof
- MOA & AOA
- Registered Office Proof
- SEBI Compliance Documents
- Bank Account Proof

**Card 5 — LLP** (4 documents)
- Partner PAN & ID Proof
- LLP Agreement
- Registered Office Proof
- Bank Account Proof

**Card 6 — Section 8 Company** (5 documents)
- Director PAN & ID Proof
- MOA & AOA
- Section 8 License Application
- Office Address Proof
- Bank Account Proof

**Card 7 — Trust Registration** (4 documents)
- Trust Deed
- Trustees PAN & ID
- Registered Office Proof
- Bank Account Proof

**Card 8 — One Person Company** (4 documents)
- Owner PAN & ID Proof
- MOA & AOA
- Registered Office Proof
- Bank Account Proof

---

## Part 3 — Continue Button

Same dark navy pill-shaped Continue button below the required documents section. Clicking navigates to the selected registration type's form page.

---

## Part 4 — All 8 Form Pages

---

### FORM 1 — Sole Proprietorship
**Breadcrumb:** Business Registration > Sole Proprietorship
**Title:** Sole Proprietorship Registration
**Processing Time note (below title):** Processing Time: 3–7 working days

#### Section 1: Applicant Information

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Applicant Name | Text | Full name of the owner | Yes | Min 3 characters |
| Business Name | Text | Proposed business name | Yes | Min 3 characters |
| PAN | Text | Owner's PAN number | Yes | 10 alphanumeric characters |
| GSTIN | Text | GSTIN (if applicable) | No | 15 alphanumeric if entered |
| Business Type | Dropdown | Options: Trading, Service, Manufacturing, Other | Yes | Must select one |
| Contact Email | Text | Owner's email address | Yes | Valid email format |
| Contact Number | Text | 10-digit mobile number | Yes | Exactly 10 digits, numeric only |

#### Section 2: Business Address

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Business Address | Textarea | Registered business address (min 10 characters) | Yes | Min 10 characters, max 500 |

#### Section 3: Supporting Documents

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| PAN Card | File Upload | Owner's PAN card — PDF/JPG | Yes | PDF/JPG/PNG, max 10MB |
| Address Proof | File Upload | Utility bill or rent agreement — PDF/JPG | Yes | PDF/JPG/PNG, max 10MB |
| ID Proof | File Upload | Aadhaar, Passport, or Voter ID — PDF/JPG | Yes | PDF/JPG/PNG, max 10MB |
| Bank Account Proof | File Upload | Bank passbook or cancelled cheque — PDF | No | PDF only, max 10MB |

---

### FORM 2 — Partnership Firm
**Breadcrumb:** Business Registration > Partnership Firm
**Title:** Partnership Firm Registration
**Processing Time note:** Processing Time: 7–10 working days

#### Section 1: Firm Information

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Firm Name | Text | Proposed name of the firm | Yes | Min 3 characters |
| GSTIN | Text | GSTIN if already registered (optional) | No | 15 alphanumeric if entered |
| Contact Email | Text | Contact email for communication | Yes | Valid email format |
| Contact Number | Text | 10-digit mobile number | Yes | Exactly 10 digits, numeric only |

#### Section 2: Partner Details

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Partner Names | Textarea | List all partner names (minimum 2 partners required) | Yes | Min 2 partners must be listed |
| Business Address | Textarea | Registered office address (min 10 characters) | Yes | Min 10 characters, max 500 |

#### Section 3: Supporting Documents

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| PAN Cards (Firm & Partners) | File Upload | PAN cards of firm and all partners — PDF/JPG | Yes | PDF/JPG/PNG, max 10MB |
| Partnership Agreement | File Upload | Drafted partnership deed — PDF only | Yes | PDF only, max 10MB |
| Address Proof | File Upload | Registered office address proof — PDF/JPG | Yes | PDF/JPG/PNG, max 10MB |
| Bank Account Proof | File Upload | Bank passbook or cancelled cheque — PDF | No | PDF only, max 10MB |

---

### FORM 3 — Private Limited Company
**Breadcrumb:** Business Registration > Private Limited Company
**Title:** Private Limited Company Incorporation
**Processing Time note:** Processing Time: 10–15 working days

#### Section 1: Company Information

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Proposed Company Name | Text | Company name for MCA approval | Yes | Min 3 characters |
| GSTIN | Text | GSTIN if applicable (optional) | No | 15 alphanumeric if entered |
| Registered Office Address | Textarea | Company's official registered address (min 10 characters) | Yes | Min 10 characters, max 500 |
| Contact Email | Text | Company contact email | Yes | Valid email format |
| Contact Number | Text | 10-digit mobile number | Yes | Exactly 10 digits, numeric only |

#### Section 2: Director Details

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Director 1 — Name | Text | Full name of Director 1 | Yes | Min 3 characters |
| Director 1 — PAN | Text | PAN of Director 1 | Yes | 10 alphanumeric characters |
| Director 1 — DIN | Text | Director Identification Number of Director 1 | Yes | 8 digits numeric |
| Director 1 — Email | Text | Email of Director 1 | Yes | Valid email format |
| Director 1 — Mobile | Text | Mobile of Director 1 | Yes | Exactly 10 digits |
| Director 2 — Name | Text | Full name of Director 2 | Yes | Min 3 characters |
| Director 2 — PAN | Text | PAN of Director 2 | Yes | 10 alphanumeric characters |
| Director 2 — DIN | Text | Director Identification Number of Director 2 | Yes | 8 digits numeric |
| Director 2 — Email | Text | Email of Director 2 | Yes | Valid email format |
| Director 2 — Mobile | Text | Mobile of Director 2 | Yes | Exactly 10 digits |

#### Section 3: Supporting Documents

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| MOA & AOA | File Upload | Memorandum and Articles of Association — PDF | Yes | PDF only, max 10MB |
| PAN & TAN | File Upload | Company PAN and TAN documents — PDF | Yes | PDF only, max 10MB |
| Director PAN & ID Proof | File Upload | PAN and ID proof of all directors — PDF/JPG | Yes | PDF/JPG/PNG, max 10MB |
| Registered Office Proof | File Upload | Address proof of registered office — PDF/JPG | Yes | PDF/JPG/PNG, max 10MB |
| Bank Account Proof | File Upload | Bank passbook or cancelled cheque — PDF | No | PDF only, max 10MB |

---

### FORM 4 — Public Limited Company
**Breadcrumb:** Business Registration > Public Limited Company
**Title:** Public Limited Company Incorporation
**Processing Time note:** Processing Time: 20–30 working days

#### Section 1: Company Information

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Company Name | Text | Proposed public company name | Yes | Min 3 characters |
| GSTIN | Text | GSTIN if applicable (optional) | No | 15 alphanumeric if entered |
| Registered Office Address | Textarea | Official registered address (min 10 characters) | Yes | Min 10 characters, max 500 |
| Contact Email | Text | Company contact email | Yes | Valid email format |
| Contact Number | Text | 10-digit mobile number | Yes | Exactly 10 digits, numeric only |

#### Section 2: Director & Shareholder Details

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Director 1 — Name | Text | Full name of Director 1 | Yes | Min 3 characters |
| Director 1 — PAN | Text | PAN of Director 1 | Yes | 10 alphanumeric characters |
| Director 1 — DIN | Text | Director Identification Number | Yes | 8 digits numeric |
| Director 1 — Shares | Number | Number of shares held by Director 1 | Yes | Positive integer only |
| Director 2 — Name | Text | Full name of Director 2 | Yes | Min 3 characters |
| Director 2 — PAN | Text | PAN of Director 2 | Yes | 10 alphanumeric characters |
| Director 2 — DIN | Text | Director Identification Number | Yes | 8 digits numeric |
| Director 2 — Shares | Number | Number of shares held by Director 2 | Yes | Positive integer only |

#### Section 3: Supporting Documents

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| MOA & AOA | File Upload | Memorandum and Articles of Association — PDF | Yes | PDF only, max 10MB |
| SEBI Compliance Documents | File Upload | Required SEBI forms if applicable — PDF | Yes | PDF only, max 10MB |
| PAN & TAN | File Upload | Company PAN and TAN — PDF | Yes | PDF only, max 10MB |
| Director PAN & ID Proof | File Upload | PAN and ID proof of all directors — PDF/JPG | Yes | PDF/JPG/PNG, max 10MB |
| Registered Office Proof | File Upload | Address proof of registered office — PDF/JPG | Yes | PDF/JPG/PNG, max 10MB |
| Bank Account Proof | File Upload | Bank passbook or cancelled cheque — PDF | No | PDF only, max 10MB |

---

### FORM 5 — Limited Liability Partnership (LLP)
**Breadcrumb:** Business Registration > LLP
**Title:** Limited Liability Partnership (LLP) Registration
**Processing Time note:** Processing Time: 10–15 working days

#### Section 1: LLP Information

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| LLP Name | Text | Proposed LLP name | Yes | Min 3 characters |
| GSTIN | Text | GSTIN if applicable (optional) | No | 15 alphanumeric if entered |
| Registered Office Address | Textarea | Registered office address (min 10 characters) | Yes | Min 10 characters, max 500 |
| Contact Email | Text | LLP contact email | Yes | Valid email format |
| Contact Number | Text | 10-digit mobile number | Yes | Exactly 10 digits, numeric only |

#### Section 2: Partner Details

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Partner 1 — Name | Text | Full name of Partner 1 | Yes | Min 3 characters |
| Partner 1 — PAN | Text | PAN of Partner 1 | Yes | 10 alphanumeric characters |
| Partner 1 — DIN | Text | Designated Partner Identification Number | Yes | 8 digits numeric |
| Partner 2 — Name | Text | Full name of Partner 2 | Yes | Min 3 characters |
| Partner 2 — PAN | Text | PAN of Partner 2 | Yes | 10 alphanumeric characters |
| Partner 2 — DIN | Text | Designated Partner Identification Number | Yes | 8 digits numeric |

#### Section 3: Supporting Documents

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| LLP Agreement | File Upload | Drafted LLP agreement — PDF only | Yes | PDF only, max 10MB |
| PAN & TAN | File Upload | LLP PAN and TAN — PDF | Yes | PDF only, max 10MB |
| Partner PAN & ID Proof | File Upload | PAN and ID proof of all partners — PDF/JPG | Yes | PDF/JPG/PNG, max 10MB |
| Registered Office Proof | File Upload | Address proof of registered office — PDF/JPG | Yes | PDF/JPG/PNG, max 10MB |
| Bank Account Proof | File Upload | Bank passbook or cancelled cheque — PDF | No | PDF only, max 10MB |

---

### FORM 6 — Section 8 Company
**Breadcrumb:** Business Registration > Section 8 Company
**Title:** Section 8 Company Registration
**Processing Time note:** Processing Time: 15–20 working days

#### Section 1: Company Information

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Proposed Company Name | Text | Name for MCA approval | Yes | Min 3 characters |
| Contact Email | Text | Company contact email | Yes | Valid email format |
| Contact Number | Text | 10-digit mobile number | Yes | Exactly 10 digits, numeric only |

#### Section 2: Objectives & Director Details

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Charitable / Social Objectives | Textarea | Describe the charitable or social objectives of the company (max 500 characters) | Yes | Max 500 characters, show live counter |
| Director 1 — Name | Text | Full name of Director 1 | Yes | Min 3 characters |
| Director 1 — PAN | Text | PAN of Director 1 | Yes | 10 alphanumeric characters |
| Director 1 — DIN | Text | Director Identification Number | Yes | 8 digits numeric |
| Director 2 — Name | Text | Full name of Director 2 | Yes | Min 3 characters |
| Director 2 — PAN | Text | PAN of Director 2 | Yes | 10 alphanumeric characters |
| Director 2 — DIN | Text | Director Identification Number | Yes | 8 digits numeric |

#### Section 3: Supporting Documents

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| MOA & AOA | File Upload | Memorandum and Articles of Association — PDF | Yes | PDF only, max 10MB |
| Section 8 License Application | File Upload | MCA Section 8 license application — PDF | Yes | PDF only, max 10MB |
| PAN & TAN | File Upload | Company PAN and TAN — PDF | Yes | PDF only, max 10MB |
| Director PAN & ID Proof | File Upload | PAN and ID proof of all directors — PDF/JPG | Yes | PDF/JPG/PNG, max 10MB |
| Office Address Proof | File Upload | Registered office address proof — PDF/JPG | Yes | PDF/JPG/PNG, max 10MB |
| Bank Account Proof | File Upload | Bank passbook or cancelled cheque — PDF | No | PDF only, max 10MB |

---

### FORM 7 — Trust Registration
**Breadcrumb:** Business Registration > Trust Registration
**Title:** Trust Registration
**Processing Time note:** Processing Time: 10–15 working days

#### Section 1: Trust Information

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Trust Name | Text | Name of the trust | Yes | Min 3 characters |
| Registered Office Address | Textarea | Address of the trust (min 10 characters) | Yes | Min 10 characters, max 500 |
| Contact Email | Text | Trustee email address | Yes | Valid email format |
| Contact Number | Text | 10-digit mobile number | Yes | Exactly 10 digits, numeric only |

#### Section 2: Trustee & Beneficiary Details

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Trustee 1 — Name | Text | Full name of Trustee 1 | Yes | Min 3 characters |
| Trustee 1 — PAN | Text | PAN of Trustee 1 | Yes | 10 alphanumeric characters |
| Trustee 2 — Name | Text | Full name of Trustee 2 | Yes | Min 3 characters |
| Trustee 2 — PAN | Text | PAN of Trustee 2 | Yes | 10 alphanumeric characters |
| Beneficiaries | Textarea | Details of beneficiaries of the trust (max 500 characters) | Yes | Max 500 characters, show live counter |

#### Section 3: Supporting Documents

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Trust Deed | File Upload | Drafted trust deed — PDF only | Yes | PDF only, max 10MB |
| Trust PAN | File Upload | PAN card of the trust — PDF | Yes | PDF only, max 10MB |
| Trustees PAN & ID | File Upload | PAN and ID proof of all trustees — PDF/JPG | Yes | PDF/JPG/PNG, max 10MB |
| Registered Office Proof | File Upload | Address proof of registered office — PDF/JPG | Yes | PDF/JPG/PNG, max 10MB |
| Bank Account Proof | File Upload | Bank passbook or cancelled cheque — PDF | No | PDF only, max 10MB |

---

### FORM 8 — One Person Company (OPC)
**Breadcrumb:** Business Registration > One Person Company
**Title:** One Person Company (OPC) Registration
**Processing Time note:** Processing Time: 10–15 working days

#### Section 1: OPC Information

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Proposed OPC Name | Text | Name for MCA approval | Yes | Min 3 characters |
| GSTIN | Text | GSTIN if applicable (optional) | No | 15 alphanumeric if entered |
| Registered Office Address | Textarea | OPC registered address (min 10 characters) | Yes | Min 10 characters, max 500 |
| Contact Email | Text | OPC contact email | Yes | Valid email format |
| Contact Number | Text | 10-digit mobile number | Yes | Exactly 10 digits, numeric only |

#### Section 2: Director / Owner Details

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Director / Owner Name | Text | Full name of the owner/director | Yes | Min 3 characters |
| Director / Owner PAN | Text | PAN of the owner/director | Yes | 10 alphanumeric characters |
| Director / Owner DIN | Text | Director Identification Number | Yes | 8 digits numeric |
| Director / Owner Address | Textarea | Residential address of the owner/director (min 10 characters) | Yes | Min 10 characters, max 500 |

#### Section 3: Supporting Documents

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| MOA & AOA | File Upload | Memorandum and Articles of Association — PDF | Yes | PDF only, max 10MB |
| PAN & TAN | File Upload | OPC PAN and TAN — PDF | Yes | PDF only, max 10MB |
| Owner PAN & ID Proof | File Upload | PAN and ID proof of owner — PDF/JPG | Yes | PDF/JPG/PNG, max 10MB |
| Registered Office Proof | File Upload | Address proof of registered office — PDF/JPG | Yes | PDF/JPG/PNG, max 10MB |
| Bank Account Proof | File Upload | Bank passbook or cancelled cheque — PDF | No | PDF only, max 10MB |

---

## Part 5 — Global Validation Rules

| Field Type | Rule |
|---|---|
| All required text fields | Minimum 3 characters; inline red error if empty on submit |
| PAN | Exactly 10 alphanumeric characters; validate on blur |
| GSTIN | Exactly 15 alphanumeric if entered; validate on blur |
| DIN | Exactly 8 digits numeric; validate on blur |
| Email | Standard regex email validation; inline error on invalid format |
| Phone / Mobile | Exactly 10 digits, numeric only; no spaces or special characters |
| Number fields | Positive integers only; no negatives |
| Textareas | Min 10 characters where specified; max 500 characters; show live character counter |
| File Uploads | Accept PDF, JPG, PNG only; max 10MB per file; show filename after selection |
| Dropdowns | Must have a valid selection; "Select..." counts as empty |

All validation errors appear inline below the field in red text. No alert popups.
