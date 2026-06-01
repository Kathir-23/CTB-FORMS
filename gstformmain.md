# GST Services Portal — Complete 8 Form Build Prompt (v2)

## Critical Instructions

- Use the **exact same layout, design, components, and styling** as the existing FSSAI forms already in the project. Do not invent anything new.
- White card sections on `#f3f4f6` background, `border-radius: 8px`, `padding: 24px`, subtle shadow
- Two-column grid for side-by-side fields, full-width for single fields
- File upload fields: gray icon box left + white hover area right
- Thin `1px solid #e2e8f0` borders on all inputs
- Labels: `font-weight: 500`, small font, red `*` for required
- Full-width indigo Submit button at the bottom of every form
- Footer: `Pentagon Innovations - Product` left, `Support | Help Center | Privacy | Terms` right
- Do NOT touch the sidebar, navbar, or any other page

---

## Part 1 — Landing Page: Replace Cards with 8 Service Cards

Replace existing service cards with these 8 cards using the exact same card component:

| # | Card Title | Subtitle | Badge |
|---|---|---|---|
| 1 | GST Advisory Service | Expert tax guidance & planning | Recommended (amber pill) |
| 2 | GST Revocation | Reinstate your GST registration | — |
| 3 | GST Returns Filing | GSTR-1, GSTR-3B & more | — |
| 4 | GST Annual Return | GSTR-9 / GSTR-9C filing | — |
| 5 | GST Notice Reply | Respond to GST notices | — |
| 6 | GST Amendment | Update your GST details | — |
| 7 | Final Return (GSTR-10) | Close your GST account | — |
| 8 | GST Health Check | Audit your GST compliance | — |

Each card click navigates to that service's form page.

---

## Part 2 — Required Documents Checklist (Landing Page, Dynamic)

The "Required documents" section below the cards must dynamically update based on which card is selected. Use the same checkmark list UI as the existing implementation.

**Card 1 — GST Advisory Service** (5 documents)
- Past GST Returns (GSTR-1, GSTR-3B)
- Purchase Invoices
- Sales Invoices
- Financial Statements (Profit & Loss, Balance Sheet)
- Correspondence with GST Authorities

**Card 2 — GST Revocation** (5 documents)
- GST Revocation Notice
- Copy of GST Registration Certificate
- Financial Statements
- Correspondence with GST Authorities
- Identity Proof of Authorized Signatory

**Card 3 — GST Returns Filing** (5 documents)
- Sales Invoices (B2B & B2C)
- Purchase Invoices
- Debit / Credit Notes
- Payment Challans for Tax Deposited
- Prior Period Adjustment Entries

**Card 4 — GST Annual Return** (5 documents)
- Monthly / Quarterly GST Returns
- Reconciliation of ITC
- Audited Financial Statements
- Bank Statements
- Audit Reports (for GSTR-9C)

**Card 5 — GST Notice Reply** (5 documents)
- GST Notice Copy
- Related Invoices or Bills
- Previous GST Returns
- Bank Statements
- Correspondence with GST Department

**Card 6 — GST Amendment** (5 documents)
- Proof of New Address (Electricity Bill / Rent Agreement)
- PAN Card (if changing PAN)
- Bank Statement / Cancelled Cheque
- Identity Proof of Signatory
- Board Resolution / Authorization Letter

**Card 7 — Final Return (GSTR-10)** (5 documents)
- Cancellation / Surrender Application Copy
- Last Filed GST Returns
- Final Sales & Purchase Summary
- Payment Challans
- Prior Period Adjustments / Corrections

**Card 8 — GST Health Check** (4 documents)
- GST Returns (GSTR-1, GSTR-3B)
- Purchase & Sales Ledger
- GSTR-2B Statements
- Financial Statements

---

## Part 3 — All 8 Form Pages

Each form page has: breadcrumb, page title, sections as white cards, Submit button.

---

### FORM 1 — GST Advisory Service
**Breadcrumb:** GST Services > GST Advisory Service
**Title:** GST Advisory Service

#### Section 1: Client Information

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Client Name | Text | Full name of the client | Yes | Min 3 characters |
| Business Name | Text | Registered business name | Yes | Min 3 characters |
| GSTIN | Text | GST Identification Number (optional) | No | 15-digit alphanumeric if entered |
| Business Type | Dropdown | Options: Manufacturer, Trader, Service Provider, Other | Yes | Must select one |
| Annual Turnover (INR) | Number | Annual turnover in Indian Rupees | Yes | Positive numeric only |
| Contact Email | Text | Client email address | Yes | Valid email format |
| Contact Number | Text | 10-digit mobile number | Yes | Exactly 10 digits, numeric |

#### Section 2: Advisory Requirements

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Advisory Required | Multi-select checkboxes | Options: Tax Planning, Input Tax Credit, Compliance Updates, Other | Yes | At least one must be selected |
| Description / Query | Textarea | Describe your query or situation in detail (max 500 characters) | Yes | Max 500 chars, show live counter |

#### Section 3: Supporting Documents

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Past GST Returns | File Upload | Upload GSTR-1 / GSTR-3B — PDF or Excel | No | PDF/XLSX, max 10MB |
| Purchase Invoices | File Upload | Upload purchase invoice records — PDF or Excel | No | PDF/XLSX, max 10MB |
| Sales Invoices | File Upload | Upload sales invoice records — PDF or Excel | No | PDF/XLSX, max 10MB |
| Financial Statements | File Upload | Profit & Loss, Balance Sheet — PDF or Excel | No | PDF/XLSX, max 10MB |
| GST Authority Correspondence | File Upload | Any letters or notices from GST department — PDF | No | PDF only, max 10MB |

---

### FORM 2 — GST Revocation
**Breadcrumb:** GST Services > GST Revocation
**Title:** GST Revocation

#### Section 1: Client Information

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Client Name | Text | Full name of the client | Yes | Min 3 characters |
| Business Name | Text | Registered business name | Yes | Min 3 characters |
| GSTIN | Text | Revoked GST Identification Number | Yes | Exactly 15 alphanumeric characters |
| Contact Email | Text | Client email address | Yes | Valid email format |
| Contact Number | Text | 10-digit mobile number | Yes | Exactly 10 digits, numeric |

#### Section 2: Revocation Details

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Reason for Revocation | Textarea | Explain why GST was cancelled and why it should be revoked (max 500 characters) | Yes | Max 500 chars, show live counter |

#### Section 3: Documents

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Revocation Notice | File Upload | Official GST revocation/cancellation notice — PDF only | Yes | PDF only, max 5MB |
| GST Registration Certificate | File Upload | Copy of original GST registration certificate — PDF | No | PDF only, max 10MB |
| Financial Statements | File Upload | Recent financial statements — PDF or Excel | No | PDF/XLSX, max 10MB |
| Identity Proof of Signatory | File Upload | Aadhaar, PAN, or passport of authorized signatory | No | PDF/JPG/PNG, max 10MB |
| Additional Documents | File Upload | Any other supporting documents | No | PDF/JPG/PNG, max 10MB |

---

### FORM 3 — GST Returns Filing
**Breadcrumb:** GST Services > GST Returns Filing
**Title:** GST Returns Filing

#### Section 1: Client Information

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Client Name | Text | Full name of the client | Yes | Min 3 characters |
| Business Name | Text | Registered business name | Yes | Min 3 characters |
| GSTIN | Text | 15-digit GST Identification Number | Yes | Exactly 15 alphanumeric characters |
| Contact Email | Text | Client email address | Yes | Valid email format |
| Contact Number | Text | 10-digit mobile number | Yes | Exactly 10 digits, numeric |

#### Section 2: Return Details

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Return Type | Dropdown | Type of return to be filed — Options: GSTR-1, GSTR-3B, CMP-08, Other | Yes | Must select one |
| Filing Period | Month & Year Picker | Month and year for which return is being filed | Yes | Cannot be a future date |

#### Section 3: Documents

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Sales / Turnover Details | File Upload | B2B and B2C sales invoice data — Excel or PDF | Yes | XLSX/PDF, max 10MB |
| Purchase / Input Tax Details | File Upload | Purchase invoices and input tax data — Excel or PDF | No | XLSX/PDF, max 10MB |
| Debit / Credit Notes | File Upload | Any debit or credit note records — Excel or PDF | No | XLSX/PDF, max 10MB |
| Payment Challans | File Upload | Tax payment challan copies — PDF | No | PDF only, max 10MB |
| Prior Period Entries | File Upload | Adjustments or corrections from prior periods — PDF or Excel | No | PDF/XLSX, max 10MB |

---

### FORM 4 — GST Annual Return Filing
**Breadcrumb:** GST Services > GST Annual Return
**Title:** GST Annual Return Filing

#### Section 1: Client Information

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Client Name | Text | Full name of the client | Yes | Min 3 characters |
| Business Name | Text | Registered business name | Yes | Min 3 characters |
| GSTIN | Text | 15-digit GST Identification Number | Yes | Exactly 15 alphanumeric characters |
| Contact Email | Text | Client email address | Yes | Valid email format |
| Contact Number | Text | 10-digit mobile number | Yes | Exactly 10 digits, numeric |

#### Section 2: Annual Return Details

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Financial Year | Dropdown | Financial year for annual return — Options: FY 2022-23, FY 2023-24, FY 2024-25 | Yes | Must select one, cannot be future FY |

#### Section 3: Documents

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| GSTR-9 Annual Data | File Upload | Annual GST return data (GSTR-9) — Excel or PDF | Yes | XLSX/PDF, max 10MB |
| GSTR-9C Auditor Statement | File Upload | Auditor-certified reconciliation statement if applicable — PDF only | No | PDF only, max 10MB |
| ITC Reconciliation | File Upload | Reconciliation of Input Tax Credit — Excel or PDF | No | XLSX/PDF, max 10MB |
| Audited Financial Statements | File Upload | Audited Profit & Loss and Balance Sheet — PDF or Excel | No | PDF/XLSX, max 10MB |
| Bank Statements | File Upload | Bank statements if required for verification — PDF | No | PDF only, max 10MB |

---

### FORM 5 — GST Notice Reply
**Breadcrumb:** GST Services > GST Notice Reply
**Title:** GST Notice Reply

#### Section 1: Client Information

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Client Name | Text | Full name of the client | Yes | Min 3 characters |
| Business Name | Text | Registered business name | Yes | Min 3 characters |
| GSTIN | Text | 15-digit GST Identification Number | Yes | Exactly 15 alphanumeric characters |
| Contact Email | Text | Client email address | Yes | Valid email format |
| Contact Number | Text | 10-digit mobile number | Yes | Exactly 10 digits, numeric |

#### Section 2: Notice Details

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Notice Type | Dropdown | Type of GST notice received — Options: Show Cause Notice, Demand Notice, Audit Notice, Others | Yes | Must select one |
| Notice Date | Date Picker | Date mentioned on the GST notice | Yes | Cannot be a future date |
| Client Explanation | Textarea | Describe the situation and context of the notice (max 500 characters) | Yes | Max 500 chars, show live counter |

#### Section 3: Documents

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| GST Notice Copy | File Upload | Scanned copy of the GST notice received — PDF only | Yes | PDF only, max 5MB |
| Related Invoices / Bills | File Upload | Invoices or bills related to the notice — PDF or Excel | No | PDF/XLSX, max 10MB |
| Previous GST Returns | File Upload | Past return filings relevant to the notice period — PDF or Excel | No | PDF/XLSX, max 10MB |
| Bank Statements | File Upload | Bank statements showing tax payments if applicable — PDF | No | PDF only, max 10MB |
| GST Department Correspondence | File Upload | Prior communication with the GST department — PDF | No | PDF only, max 10MB |

---

### FORM 6 — GST Amendment
**Breadcrumb:** GST Services > GST Amendment
**Title:** GST Amendment

#### Section 1: Client Information

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Client Name | Text | Full name of the client | Yes | Min 3 characters |
| Business Name | Text | Registered business name | Yes | Min 3 characters |
| GSTIN | Text | 15-digit GST Identification Number | Yes | Exactly 15 alphanumeric characters |
| Contact Email | Text | Client email address | Yes | Valid email format |
| Contact Number | Text | 10-digit mobile number | Yes | Exactly 10 digits, numeric |

#### Section 2: Amendment Details

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Amendment Type | Dropdown | What needs to be changed — Options: Business Address, Business Name, PAN, Bank Details, Authorized Signatory, Other | Yes | Must select one |
| Amendment Description | Textarea | Describe the amendment in detail (max 300 characters) | Yes | Max 300 chars, show live counter |

#### Section 3: Supporting Documents

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Proof of New Details | File Upload | Document proving the new information (utility bill, new PAN, etc.) | Yes | PDF/JPG/PNG, max 10MB |
| PAN Card | File Upload | New PAN card if PAN is being changed — PDF | No | PDF only, max 10MB |
| Bank Statement / Cancelled Cheque | File Upload | For bank detail changes — PDF | No | PDF only, max 10MB |
| Identity Proof of Signatory | File Upload | Aadhaar/PAN/Passport of the authorized signatory | No | PDF/JPG/PNG, max 10MB |
| Board Resolution / Authorization Letter | File Upload | If applicable for company or firm — PDF | No | PDF only, max 10MB |

---

### FORM 7 — Final Return (GSTR-10)
**Breadcrumb:** GST Services > Final Return (GSTR-10)
**Title:** Final Return (GSTR-10)

#### Section 1: Client Information

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Client Name | Text | Full name of the client | Yes | Min 3 characters |
| Business Name | Text | Registered business name | Yes | Min 3 characters |
| GSTIN | Text | 15-digit GST Identification Number | Yes | Exactly 15 alphanumeric characters |
| Contact Email | Text | Client email address | Yes | Valid email format |
| Contact Number | Text | 10-digit mobile number | Yes | Exactly 10 digits, numeric |

#### Section 2: Closure Details

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| GST Cancellation Date | Date Picker | Date on which GST registration was cancelled | Yes | Cannot be a future date |
| Last Filing Period | Month & Year Picker | Month and year of the last GST return filed | Yes | Cannot be a future date |

#### Section 3: Documents

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Sales & Purchase Summary | File Upload | Final summary of all sales and purchases up to closure date — Excel or PDF | Yes | XLSX/PDF, max 10MB |
| Cancellation / Surrender Application | File Upload | Copy of GST cancellation or surrender application — PDF | No | PDF only, max 10MB |
| Last Filed GST Returns | File Upload | Most recent GST return filings — PDF or Excel | No | PDF/XLSX, max 10MB |
| Payment Challans | File Upload | Tax payment challans for outstanding dues — PDF | No | PDF only, max 10MB |
| Prior Period Corrections | File Upload | Any adjustments or corrections for prior periods — PDF or Excel | No | PDF/XLSX, max 10MB |

---

### FORM 8 — GST Health Check
**Breadcrumb:** GST Services > GST Health Check
**Title:** GST Health Check

#### Section 1: Client Information

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Client Name | Text | Full name of the client | Yes | Min 3 characters |
| Business Name | Text | Registered business name | Yes | Min 3 characters |
| GSTIN | Text | 15-digit GST Identification Number | Yes | Exactly 15 alphanumeric characters |
| Contact Email | Text | Client email address | Yes | Valid email format |
| Contact Number | Text | 10-digit mobile number | Yes | Exactly 10 digits, numeric |

#### Section 2: Health Check Scope

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| Review Period | Dropdown | Period to be reviewed — Options: Last 3 Months, Last 6 Months, Last 1 Year, Custom | Yes | Must select one |
| Areas to Review | Multi-select checkboxes | Options: Return Review (GSTR-1 & GSTR-3B reconciliation), ITC Verification (match ITC with GSTR-2B), Books vs GST Reconciliation (sales & purchase), Tax Liability Check (correct rate & output tax), Compliance Status Review (pending returns & e-way bills), Vendor & Customer Risk Analysis | Yes | At least one must be selected |
| Additional Notes | Textarea | Any specific concerns or focus areas (max 500 characters) | No | Max 500 chars, show live counter |

#### Section 3: Documents

| Field | Type | Placeholder / Description | Required | Validation |
|---|---|---|---|---|
| GST Returns (GSTR-1, GSTR-3B) | File Upload | Filed GST returns for the review period — PDF or Excel | Yes | PDF/XLSX, max 10MB |
| Purchase & Sales Ledger | File Upload | Detailed purchase and sales ledger from books — Excel or PDF | No | XLSX/PDF, max 10MB |
| GSTR-2B Statements | File Upload | Auto-drafted ITC statements from GST portal — PDF or Excel | No | PDF/XLSX, max 10MB |
| Financial Statements | File Upload | Profit & Loss and Balance Sheet for the review period — PDF or Excel | No | PDF/XLSX, max 10MB |

---

## Part 4 — Global Validation Rules (Apply to Every Form)

| Field Type | Rule |
|---|---|
| All required text fields | Minimum 3 characters; show inline red error if empty on submit |
| GSTIN | Exactly 15 alphanumeric characters; validate on blur |
| Email | Standard regex email validation; show error on invalid format |
| Phone / Mobile | Exactly 10 digits, numeric only; no spaces or special characters |
| Annual Turnover | Positive number only; no negatives |
| Dates | Cannot be a future date |
| Month/Year Pickers | Cannot be a future month/year |
| File Uploads | Accept PDF, JPG, PNG, XLSX only; max 10MB (5MB for notice/revocation copies); show filename after selection |
| Textareas | Max 500 chars (300 for Amendment Description); live character counter below field |
| Multi-select checkboxes | At least one must be selected; show inline error if none selected on submit |
| Dropdowns | Must have a valid selection; placeholder "Select..." counts as empty |

All validation errors appear inline below the field in red. No alert popups.
