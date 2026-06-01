# Legal Services – Developer Prompt

## Overview

Build a **Legal Services** module following the **exact same structure, UI pattern, and code architecture as the existing FSSAI Services module** already in the codebase. Do not deviate from that pattern. Every screen, section, component, and interaction must mirror FSSAI's implementation — only the content and fields differ.

---

## Screen 1 — Landing Page (`/legal-services`)

### Header Block
- Page icon: shield/legal icon (same style as other service icons)
- Title: `Legal Services` with word `Registration` in blue (accent color)
- Subtitle: `Expert guidance for your legal documentation and compliance`

### Info Banner (blue left-border card)
- Line 1: `Legal compliance and documentation are critical for business success. Navigating complex legal requirements can be overwhelming.`
- Line 2: `Our service provides` **`expert guidance to simplify the entire process.`** `We handle the heavy lifting so you can focus on` **`growing your business with peace of mind.`**

### Service Selection — "Select a Legal Service"

Three selectable cards side by side:

| Card | Icon | Badge | Title | Subtitle |
|------|------|-------|-------|----------|
| 1 | Shield icon | `Recommended` (orange pill) | `NDA (Non-Disclosure Agreement) Service` | `Confidentiality agreement preparation` |
| 2 | Document icon | _(none)_ | `Legal Agreement Drafting` | `Draft custom legal contracts` |
| 3 | Tag/ribbon icon | _(none)_ | `Franchise Agreement Drafting` | `Prepare franchise contract documents` |

- Card 1 (NDA) is the default selected state (dark navy background, white text)
- Cards 2 and 3 are unselected (white/light background)
- Selecting a card updates the Required Documents section below

### Required Documents Section

Header: `Required documents — [Selected Service Name]` with document count badge (e.g. `4 documents`) right-aligned.

**When NDA is selected — 4 documents:**
1. PAN card of entity – PDF
2. Address proof (Utility bill/Rent agreement) – PDF/JPG
3. Business registration certificate (Partnership Deed / Incorporation Certificate) – PDF
4. Identity proof of signatory (Aadhaar/Passport/PAN) – PDF/JPG

**When Legal Agreement Drafting is selected — 4 documents:**
1. PAN card of entity – PDF
2. Business proof (Incorporation Certificate/Partnership Deed) – PDF
3. ID proof of authorized signatory – PDF/JPG
4. Draft business terms/clauses (if any) – Word/PDF

**When Franchise Agreement Drafting is selected — 5 documents:**
1. PAN of franchisor – PDF
2. Business Incorporation Certificate – PDF
3. Trademark/Brand registration certificate – PDF
4. ID & Address proof of franchisor & franchisee – PDF/JPG
5. Franchise model document (operations/standards) – PDF

Each document displayed as a checklist card with a checkmark icon.

### Continue Button
- Full-width dark navy rounded button: `Continue`
- On click → opens **User Details Modal**

---

## Screen 2 — User Details Modal

Modal overlay (same as FSSAI pattern):

**Title:** `User Details`

**Fields (2-column layout then 1 full-width):**
| Label | Type | Placeholder |
|-------|------|-------------|
| User Name | Text input | `Enter your name` |
| Mobile Number | Text input | `Enter Mobile Number` |
| Mail Address | Text input (full width) | `Enter Mail Address` |

**Button:** `Submit` (full-width blue/purple button)

On submit → navigate to the Request Form for the selected service.

---

## Screen 3A — NDA Request Form

**Breadcrumb:** `Business & Regulatory Registration Portal > NDA Service`
**Page Title:** `NDA (Non-Disclosure Agreement) Request Form`

---

### Section 1: Client & Agreement Details
_(Shield icon + section heading)_

| Field | Type | Placeholder | Required | Validation |
|-------|------|-------------|----------|------------|
| Client Name | Text | `Applicant/Business name` | ✅ | Min 3 characters |
| Business Type | Dropdown | `-- Select --` | ✅ | Must select one |
| Business PAN | Text | `Entity PAN` | ✅ | PAN regex: `[A-Z]{5}[0-9]{4}[A-Z]{1}` |
| Agreement Type | Dropdown | `-- Select --` | ✅ | Must select one |
| Confidentiality Duration (years) | Number | `Duration 1-10` | ✅ | Positive integer, range 1–10 |
| Parties Involved | Text | `Names & details` | ✅ | Min 10 characters |
| Business Address | Textarea (full width) | `Registered office address` | ✅ | Min 10 characters |

**Business Type dropdown options:** Proprietorship, Partnership, Pvt Ltd, LLP, Startup, Other

**Agreement Type dropdown options:** One-way NDA, Mutual NDA

---

### Section 2: Contact & Supporting Documents
_(Contact icon + section heading)_

| Field | Type | Placeholder | Required | Validation |
|-------|------|-------------|----------|------------|
| Contact Email | Text | `Email ID` | ✅ | Valid email regex |
| Contact Number | Text | `10-digit mobile` | ✅ | Exactly 10 digits |
| Supporting Docs | File Upload | `No file chosen` | ✅ | PDF/JPG ≤ 10MB |

File upload helper text: `Identity & Business Proof – PDF/JPG ≤ 10MB`

---

**Submit Button:** Full-width blue button: `Submit Application`

---

## Screen 3B — Legal Agreement Drafting Request Form

**Breadcrumb:** `Business & Regulatory Registration Portal > Legal Agreement Drafting`
**Page Title:** `Legal Agreement Drafting Request Form`

---

### Section 1: Client & Agreement Details
_(Document icon + section heading)_

| Field | Type | Placeholder | Required | Validation |
|-------|------|-------------|----------|------------|
| Client Name | Text | `Business/Entity name` | ✅ | Min 3 characters |
| Business Type | Dropdown | `-- Select --` | ✅ | Must select one |
| Business PAN | Text | `PAN of entity` | ✅ | PAN regex |
| Agreement Type | Dropdown | `-- Select --` | ✅ | Must select one |
| Key Clauses | Textarea (full width) | `Specific requirements/clauses` | ✅ | Min 10 characters |
| Effective Date | Date picker | _(date field)_ | ✅ | Cannot be in the future (≤ current date) |

**Business Type dropdown options:** Proprietorship, Partnership, Pvt Ltd, LLP, NGO, Other

**Agreement Type dropdown options:** Partnership, Service, Vendor, Client, Other

---

### Section 2: Contact & Supporting Documents
_(Contact icon + section heading)_

| Field | Type | Placeholder | Required | Validation |
|-------|------|-------------|----------|------------|
| Contact Person Name | Text | `Authorized signatory` | ✅ | Min 3 characters |
| Contact Email | Text | `Email ID` | ✅ | Valid email regex |
| Contact Number | Text | `Mobile` | ✅ | Exactly 10 digits |
| Supporting Docs | File Upload | `No file chosen` | ✅ | PDF/JPG ≤ 10MB |

File upload helper text: `Business Proofs – PDF/JPG ≤ 10MB`

---

**Submit Button:** Full-width blue button: `Submit Application`

---

## Screen 3C — Franchise Agreement Drafting Request Form

**Breadcrumb:** `Business & Regulatory Registration Portal > Franchise Agreement Drafting`
**Page Title:** `Franchise Agreement Drafting Request Form`

---

### Section 1: Franchise & Business Details
_(Tag/ribbon icon + section heading)_

| Field | Type | Placeholder | Required | Validation |
|-------|------|-------------|----------|------------|
| Franchisor Name | Text | `Name of franchisor` | ✅ | Min 3 characters |
| Franchisee Name | Text | `Name of franchisee` | ✅ | Min 3 characters |
| Business Type | Dropdown | `-- Select --` | ✅ | Must select one |
| Business PAN | Text | `PAN of franchisor entity` | ✅ | PAN regex |
| Business Address | Textarea (full width) | `Registered office address` | ✅ | Min 10 characters |
| Franchise Territory | Textarea (full width) | `Location/territory granted` | ✅ | Min 10 characters |
| Agreement Duration | Number | `Years of validity` | ✅ | Positive integer |
| Franchise Fee | Number | `Initial fee amount` | ✅ | Numeric |
| Royalty Percentage | Number | `% of sales payable` | ✅ | Range 1–100 |
| IP Protection Clauses | Textarea (full width) | `IP/Trademark protection details` | ✅ | Min 10 characters |

**Business Type dropdown options:** Retail, Food & Beverage, Education, Service, Other

---

### Section 2: Contact & Supporting Documents
_(Contact icon + section heading)_

| Field | Type | Placeholder | Required | Validation |
|-------|------|-------------|----------|------------|
| Contact Email | Text | `Email` | ✅ | Valid email regex |
| Contact Number | Text | `Mobile` | ✅ | Exactly 10 digits |
| Supporting Docs | File Upload | `No file chosen` | ✅ | PDF/JPG ≤ 10MB |

File upload helper text: `Proofs & Agreements – PDF/JPG ≤ 10MB`

---

**Submit Button:** Full-width blue button: `Submit Application`

---

## Global Validation Rules (Apply to ALL three forms)

| Rule | Constraint |
|------|-----------|
| Mandatory fields | Cannot be blank |
| Text fields | Min 3, Max 200 characters |
| Textarea fields | Min 10 characters |
| Numeric fields | Positive integers only |
| Email | Must match valid email regex |
| Phone | Exactly 10 digits |
| PAN | `[A-Z]{5}[0-9]{4}[A-Z]{1}` |
| Dates | Cannot be in the future |
| File uploads | PDF/JPG/PNG/DOCX only, max 10MB |

---

## Sidebar Navigation

Add `Legal Services` as a menu item under the **Auditing Services** group in the left sidebar, same position and style as the existing entries (GST Registration, Business & Regulatory Registration Portal, Fssai Services, PF & ESI Services).

---

## Implementation Notes

- Follow the **exact same file/folder structure, routing, state management, and component pattern** as the FSSAI Services module.
- Reuse all shared components (form inputs, dropdowns, file upload, modal, section cards, breadcrumb, submit button).
- The three service forms are separate routes/pages, navigated to after the user selects a service on the landing page and submits the User Details modal.
- No new patterns or libraries — match FSSAI exactly.
