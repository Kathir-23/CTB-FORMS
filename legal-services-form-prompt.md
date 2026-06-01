# Legal Services Portal — Complete Form Build Prompt

## Critical Instructions

- Build this **exactly like the GST Registration module** already in the project — same landing page layout, same card design, same form page structure, same components, same styling. Do not invent anything new.
- Same white card sections on `#f3f4f6` background, `border-radius: 8px`, `padding: 24px`, subtle shadow
- Same two-column grid for side-by-side fields, full-width for single fields
- Same file upload fields: gray icon box left + white hover area right
- Same thin `1px solid #e2e8f0` borders on all inputs
- Same labels: `font-weight: 500`, small font, red `*` for required
- Same full-width indigo Submit button at the bottom of every form
- Same footer: `Pentagon Innovations - Product ©` left, `Support | Help Center | Privacy | Terms` right
- Add a new **"Legal Services"** entry in the sidebar under Auditing Services, exactly like "GST Registration" is listed
- Do NOT touch the sidebar structure, navbar, GST pages, FSSAI pages, or any other existing page

---

## Part 1 — Landing Page

### Page Header
- Title: **Legal Services** (same two-tone style as GST — "Legal" black, "Services" blue)
- Subtitle: `Expert legal document drafting and agreement services`
- Info banner below header (same blue left-border card style): `Legal agreements and NDAs are critical for protecting your business. Our expert team drafts clear, enforceable documents tailored to your needs.`

### Section Title
- `Choose your service` (same style as "Choose your business type" on GST page)

### Service Cards (horizontal scrollable row with left/right arrows, same as GST)

| # | Card Title | Subtitle | Badge |
|---|---|---|---|
| 1 | NDA Service | Protect confidential information | Recommended (amber pill) |
| 2 | Legal Agreement Drafting | Clear & enforceable agreements | — |
| 3 | Franchise Agreement | Define franchise relationships | — |

---

## Part 2 — Required Documents Checklist (Dynamic, updates on card click)

**Card 1 — NDA Service** (4 documents)
- PAN Card of Entity
- Business Registration Certificate
- Identity Proof of Signatory
- Address Proof (Utility Bill / Rent Agreement)

**Card 2 — Legal Agreement Drafting** (4 documents)
- PAN Card of Entity
- Business Proof (Incorporation Certificate / Partnership Deed)
- ID Proof of Authorized Signatory
- Draft Business Terms / Clauses (if any)

**Card 3 — Franchise Agreement** (5 documents)
- PAN of Franchisor
- Business Incorporation Certificate
- Trademark / Brand Registration Certificate
- ID & Address Proof of Franchisor & Franchisee
- Franchise Model Document (Operations / Standards)

---

## Part 3 — Continue Button

Same dark navy pill-shaped Continue button below the required documents section. Clicking navigates to the selected service's form page.

---

## Part 4 — All 3 Form Pages

---

### FORM 1 — NDA Service
**Breadcrumb:** Legal Services > NDA Service
**Title:** NDA (Non-Disclosure Agreement) Service

#### Section 1: Client Information

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Client Name | Text | Applicant or business name | Yes | Min 3 characters |
| Business Type | Dropdown | Options: Proprietorship, Partnership, Pvt Ltd, LLP, Startup, Other | Yes | Must select one |
| Business PAN | Text | Entity PAN number | Yes | PAN format: 5 letters, 4 digits, 1 letter (e.g. ABCDE1234F) |
| Contact Email | Text | Email ID of the client | Yes | Valid email format |
| Contact Number | Text | 10-digit mobile number | Yes | Exactly 10 digits, numeric only |

#### Section 2: NDA Details

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Agreement Type | Dropdown | Options: One-way NDA, Mutual NDA | Yes | Must select one |
| Confidentiality Duration | Number | Duration in years (e.g. 2) | Yes | Positive integer, 1 to 10 years only |
| Parties Involved | Textarea | Names and details of all parties involved in the NDA (min 10 characters) | Yes | Min 10 characters, max 500 |
| Business Address | Textarea | Registered office address (min 10 characters) | Yes | Min 10 characters, max 500 |

#### Section 3: Supporting Documents

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| PAN Card of Entity | File Upload | Upload entity PAN card — PDF only | Yes | PDF only, max 10MB |
| Business Registration Certificate | File Upload | Partnership Deed or Incorporation Certificate — PDF | Yes | PDF only, max 10MB |
| Identity Proof of Signatory | File Upload | Aadhaar, Passport, or PAN of authorized signatory — PDF/JPG | Yes | PDF/JPG/PNG, max 10MB |
| Address Proof | File Upload | Utility bill or rent agreement — PDF/JPG | Yes | PDF/JPG/PNG, max 10MB |

---

### FORM 2 — Legal Agreement Drafting
**Breadcrumb:** Legal Services > Legal Agreement Drafting
**Title:** Legal Agreement Drafting

#### Section 1: Client Information

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Client Name | Text | Business or entity name | Yes | Min 3 characters |
| Business Type | Dropdown | Options: Proprietorship, Partnership, Pvt Ltd, LLP, NGO, Other | Yes | Must select one |
| Business PAN | Text | PAN of entity | Yes | PAN format: 5 letters, 4 digits, 1 letter |
| Contact Person Name | Text | Name of authorized signatory | Yes | Min 3 characters |
| Contact Email | Text | Email ID | Yes | Valid email format |
| Contact Number | Text | 10-digit mobile number | Yes | Exactly 10 digits, numeric only |

#### Section 2: Agreement Details

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Agreement Type | Dropdown | Options: Partnership Agreement, Service Agreement, Vendor Agreement, Client Agreement, Other | Yes | Must select one |
| Effective Date | Date Picker | Date of agreement commencement | Yes | Cannot be a future date |
| Key Clauses | Textarea | Specific requirements or clauses to be included (min 10 characters) | Yes | Min 10 characters, max 500 |

#### Section 3: Supporting Documents

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| PAN Card of Entity | File Upload | Upload entity PAN card — PDF | Yes | PDF only, max 10MB |
| Business Proof | File Upload | Incorporation Certificate or Partnership Deed — PDF | Yes | PDF only, max 10MB |
| ID Proof of Signatory | File Upload | Aadhaar, Passport, or PAN of authorized signatory — PDF/JPG | Yes | PDF/JPG/PNG, max 10MB |
| Draft Business Terms | File Upload | Any existing draft terms or clauses document — Word or PDF | No | PDF/DOCX, max 10MB |

---

### FORM 3 — Franchise Agreement Drafting
**Breadcrumb:** Legal Services > Franchise Agreement
**Title:** Franchise Agreement Drafting

#### Section 1: Franchisor & Franchisee Information

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Franchisor Name | Text | Full name of the franchisor | Yes | Min 3 characters |
| Franchisee Name | Text | Full name of the franchisee | Yes | Min 3 characters |
| Business Type | Dropdown | Options: Retail, Food & Beverage, Education, Service, Other | Yes | Must select one |
| Business PAN | Text | PAN of the franchisor entity | Yes | PAN format: 5 letters, 4 digits, 1 letter |
| Contact Email | Text | Email address | Yes | Valid email format |
| Contact Number | Text | 10-digit mobile number | Yes | Exactly 10 digits, numeric only |

#### Section 2: Franchise Agreement Details

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Business Address | Textarea | Registered office address of franchisor (min 10 characters) | Yes | Min 10 characters, max 500 |
| Franchise Territory | Textarea | Location or territory being granted to franchisee (min 10 characters) | Yes | Min 10 characters, max 500 |
| Agreement Duration | Number | Number of years the agreement is valid | Yes | Positive integer only |
| Franchise Fee (INR) | Number | Initial one-time franchise fee amount | Yes | Positive numeric only |
| Royalty Percentage | Number | Percentage of sales payable as royalty | Yes | 1 to 100 only |
| IP Protection Clauses | Textarea | IP and trademark protection details to be included (min 10 characters) | Yes | Min 10 characters, max 500 |

#### Section 3: Supporting Documents

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| PAN of Franchisor | File Upload | Franchisor entity PAN card — PDF | Yes | PDF only, max 10MB |
| Business Incorporation Certificate | File Upload | Certificate of incorporation of franchisor — PDF | Yes | PDF only, max 10MB |
| Trademark / Brand Registration | File Upload | Trademark or brand registration certificate — PDF | Yes | PDF only, max 10MB |
| ID & Address Proof | File Upload | ID and address proof of franchisor and franchisee — PDF/JPG | Yes | PDF/JPG/PNG, max 10MB |
| Franchise Model Document | File Upload | Operations manual or franchise standards document — PDF | Yes | PDF only, max 10MB |

---

## Part 5 — Global Validation Rules

| Field Type | Rule |
|---|---|
| All required text fields | Minimum 3 characters; inline red error if empty on submit |
| PAN | Format: 5 uppercase letters + 4 digits + 1 uppercase letter (e.g. ABCDE1234F); validate on blur |
| Email | Standard regex email validation; inline error on invalid format |
| Phone / Mobile | Exactly 10 digits, numeric only; no spaces or special characters |
| Number fields | Positive integers only; no negatives or decimals unless specified |
| Confidentiality Duration | 1 to 10 years only |
| Royalty Percentage | 1 to 100 only |
| Dates | Cannot be a future date |
| Textareas | Min 10 characters where specified; max 500 characters; show live character counter |
| File Uploads | Accept PDF, JPG, PNG, DOCX only; max 10MB per file; show filename after selection |
| Dropdowns | Must have a valid selection; "Select..." placeholder counts as empty |

All validation errors appear inline below the field in red text. No alert popups.
