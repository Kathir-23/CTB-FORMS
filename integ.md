# Team Forms Integration Prompt
## For OpenCode — Business & Regulatory Registration, Employee & Business Compliance, TDS & Financial Management Services

---

## OVERVIEW

You have to complete and integrate **3 service modules** into the main Flutter Web app (`formsfinal`). The code for each service already exists inside its respective team folder. Your job is to:

1. Extract **only** the relevant service from each folder (ignore FSSAI, Legal, and any other unrelated services — those are already handled separately)
2. Restyle every page to **exactly match** the existing GST Registration and Income Tax Services UI
3. Wire each service into the sidebar with the **exact correct name**
4. Ensure all forms work without errors

---

## FOLDER → SERVICE MAPPING

| Folder | Service Name (exact) | Sidebar Position |
|---|---|---|
| `sugan` | Business & Regulatory Registration | 4 |
| `thoufeeq` | Employee & Business Compliance | 5 |
| `tejaswini` | TDS & Financial Management Services | 6 |

> ⚠️ Each folder may contain other services like FSSAI, Legal Services, etc. **Completely ignore those.** Only work on the service listed above for each folder.

---

## STEP 1 — SIDEBAR NAMES (Fix First)

Open the main sidebar file and ensure the sidebar items are named **exactly** as follows (spelling, spacing, and capitalization must match):

1. GST Services
2. Business Registration Services
3. Income Tax Services
4. **Business & Regulatory Registration**
5. **Employee & Business Compliance**
6. **TDS & Financial Management Services**
7. Legal Services

Do not rename, abbreviate, or change any of these. Update the routes/navigation to point to the correct pages for items 4, 5, and 6.

---

## STEP 2 — EXTRACT THE CORRECT CODE

For each folder:

- Open `sugan/` → find only the **Business & Regulatory Registration** related files
- Open `thoufeeq/` → find only the **Employee & Business Compliance** related files
- Open `tejaswini/` → find only the **TDS & Financial Management Services** related files

Take the existing forms, landing pages, and logic from these files. Do not delete anything from the original folders — just copy/use what is needed.

---

## STEP 3 — UI RESTYLING (MOST IMPORTANT)

**You must copy the UI exactly from the GST Registration module.** Open the GST Registration module and use it as the direct reference for every single UI element. Do not create a new design — replicate it precisely.

### Landing Page Structure (copy from GST exactly):

```
1. Two-tone page title
   - First word: black, bold
   - Second word(s): blue (#3b5bdb or matching blue), bold
   - Subtitle below in gray

2. Info Banner
   - Blue left border (4px solid blue)
   - Light blue background
   - Icon on left
   - Two lines of text (bold key phrases)

3. Section heading: "Choose your service type" (or relevant equivalent)

4. Horizontal Scrollable Cards Row
   - Left arrow button | scrollable cards | Right arrow button
   - Card 1 always has amber "Recommended" badge at top center
   - Selected card: dark navy background (#2d3a6b), white text, white icon
   - Unselected card: white background, colored icon, dark text, hover effect
   - Each card has: icon (top), service name (bold), short description below

5. Required Documents Section (below cards, updates when card is selected)
   - Header: "Required documents — [Selected Service Name]"
   - Count badge on the right: "X documents" in blue
   - Two-column grid of document items
   - Each item: blue checkmark icon + document name
   - White card container with border-radius and shadow

6. Continue Button
   - Full-width dark navy pill shape (#2d3a6b)
   - White bold text "Continue"
   - Centered at bottom of page

7. Footer
   - Left: "Pentagon Innovations - Product ©"
   - Right: "Support | Help Center | Privacy | Terms"
   - Light gray text, thin top border
```

### Form Page Structure (copy from GST exactly):

```
- Breadcrumb at top: Home > [Service Name] > [Form Name]
- Page title (two-tone same as landing)
- Two-column grid layout for form fields
- Labels: font-weight 500, red asterisk (*) for required fields
- TextFields: thin 1px solid #e2e8f0 border, border-radius 8px, white background
- File upload fields: gray icon box on left + white upload area on right, hover effect
- Full-width indigo/navy Submit button at bottom
- Same footer as landing page
```

### Global Design Tokens:

```
Background:         #f3f4f6
Card background:    #ffffff
Card border-radius: 8px
Card padding:       24px
Card shadow:        subtle box shadow
Input border:       1px solid #e2e8f0
Selected card bg:   #2d3a6b
Button color:       #2d3a6b
Recommended badge:  amber/orange
Blue accent:        #3b5bdb (or match GST exactly)
Label weight:       500
Required marker:    red *
```

---

## STEP 4 — LAYOUT WRAPPER (Critical — No Errors)

Every single page (landing page AND form pages) for all 3 services **must** be wrapped in the **exact same main layout scaffold** used by GST Registration. This scaffold includes:

- The sidebar (left)
- The top navbar
- The main content area (right/center)

**Do not render any page outside this scaffold.** If a page is missing the scaffold wrapper, the sidebar will disappear or freeze and the app will break.

---

## STEP 5 — FLUTTER ERROR PREVENTION CHECKLIST

Apply all of the following to every page and form in all 3 services:

- [ ] Every page is wrapped in the main layout scaffold (sidebar + navbar)
- [ ] Every `TextField` has a `Material` or `Scaffold` ancestor — never place TextFields outside a Material widget
- [ ] Every scrollable page uses `SingleChildScrollView` to prevent overflow errors
- [ ] All routes for items 4, 5, 6 are registered in the main router/navigation file
- [ ] No `Navigator` or route calls reference screens that don't exist
- [ ] All `required` widget parameters are passed correctly
- [ ] No hardcoded pixel heights that cause RenderFlex overflow — use `Expanded`, `Flexible`, or `constraints` where needed
- [ ] All assets/images referenced in these folders actually exist in the project
- [ ] `pubspec.yaml` includes any new assets if added
- [ ] Hot restart the app after integration and confirm all 3 sidebar items navigate correctly without blank screens or crashes

---

## STEP 6 — POPUP MODAL (User Details)

When the user clicks the **Continue** button on any landing page, show a popup modal with:

- Name (required)
- Mobile Number (required)
- Email Address (required)
- A **Submit** button that navigates to the form page

This modal must match the one used in GST Registration exactly — same styling, same fields, same behavior.

---

## FINAL CHECKLIST BEFORE DONE

- [ ] Sidebar shows all 7 services with exact names
- [ ] Clicking item 4 → Business & Regulatory Registration landing page loads (no blank screen)
- [ ] Clicking item 5 → Employee & Business Compliance landing page loads (no blank screen)
- [ ] Clicking item 6 → TDS & Financial Management Services landing page loads (no blank screen)
- [ ] All landing pages have: two-tone title, info banner, scrollable cards, required docs section, Continue button, footer
- [ ] All form pages have: breadcrumb, two-column layout, correct field styling, Submit button, footer
- [ ] Required documents section updates when a different card is selected
- [ ] No Flutter errors in console (no overflow, no missing Material ancestor, no missing routes)
- [ ] UI matches GST Registration module visually — not similar, **identical**
