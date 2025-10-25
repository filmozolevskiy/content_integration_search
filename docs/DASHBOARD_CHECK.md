# Dashboard Compatibility Check

**Date:** October 24, 2025  
**Branch:** `feature/advanced-refactoring`

---

## 🎯 Dashboard Found

**Dashboard ID:** 1646  
**Dashboard Name:** "Content Integration - Search"

This dashboard likely uses the `content_integration_search` explore and may be affected by our refactoring.

---

## 🔍 Fields to Check

### ⚠️ BREAKING CHANGE: Affiliate Dimensions

These fields have moved and **WILL BREAK** if used:

| Field Type | Old Location | New Location | Status |
|-----------|--------------|--------------|--------|
| **affiliate_name** | `Content Integration Search` view | `Affiliate Mapping` view | 🔴 **MOVED** |
| **affiliate_label** | `Content Integration Search` view | `Affiliate Mapping` view | 🔴 **MOVED** |

### ✅ Safe Fields (No Changes)

These fields still work the same:

| Field | Type | Status |
|-------|------|--------|
| `dayd_date`, `dayd_time`, etc. | Dimension Group | ✅ No change |
| `search_id` | Dimension | ✅ No change |
| `content_source` | Dimension | ✅ No change |
| `office_id` | Dimension | ✅ No change |
| `suppliers_to_fetch` | Dimension | ✅ No change |
| `airline_codes` | Dimension | ✅ No change |
| `preferred_carriers` | Dimension | ✅ No change |
| `num_packages_returned` | Dimension | ✅ No change |
| `multiticket_part` | Dimension | ✅ No change |
| `is_multiticket` | Dimension | ✅ No change |
| `search_source` | Dimension | ✅ No change |
| `search_engine` | Dimension | ✅ No change |
| `affiliate_id` | Dimension | ✅ No change (now visible) |
| `target_id` | Dimension | ✅ No change |
| `api_user` | Dimension | ✅ No change |
| `device_type` | Dimension | ✅ No change |
| `site_currency` | Dimension | ✅ No change |
| `content_currency` | Dimension | ✅ No change |
| `is_multicurrency` | Dimension | ✅ No change |
| `api_call` | Dimension | ✅ No change |
| `origin` | Dimension | ✅ No change |
| `destination` | Dimension | ✅ No change |
| `origin_country` | Dimension | ✅ No change |
| `destination_country` | Dimension | ✅ No change |
| `response_time` | Dimension | ✅ No change (improved NULL handling) |
| `response` | Dimension | ✅ No change |
| `errors` | Dimension | ✅ No change |
| **ALL MEASURES** | Measure | ✅ No change |

---

## 📋 Step-by-Step Dashboard Check

### Step 1: Access the Dashboard
1. Go to Looker
2. Navigate to **Dashboards**
3. Open: **"Content Integration - Search"** (ID: 1646)

### Step 2: Check for Errors
Look for tiles showing:
- ❌ "Field not found"
- ❌ Red error icons
- ❌ Empty visualizations where data should be

### Step 3: Identify Affected Tiles
For each broken tile, check if it uses:
- `affiliate_name` dimension
- `affiliate_label` dimension
- Filters on affiliate fields

### Step 4: Fix Affected Tiles

For each affected tile:

1. **Click the tile menu (⋮) → Edit**
2. **In the Explore:**
   - Remove: `Content Integration Search > Affiliate Name`
   - Add: `Affiliate Mapping > Affiliate Name`
   
   OR
   
   - Remove: `Content Integration Search > Affiliate (ID - Name)`
   - Add: `Affiliate Mapping > Affiliate (ID - Name)`

3. **Check Filters:**
   - Update any filters using affiliate fields
   - They should now reference `Affiliate Mapping` view

4. **Save the tile**
5. **Save the dashboard**

---

## 🧪 Testing Checklist

After making updates, verify:

- [ ] Dashboard opens without errors
- [ ] All tiles display data
- [ ] Affiliate names/labels show correctly
- [ ] Filters work properly
- [ ] No "field not found" errors
- [ ] Data matches expectations
- [ ] All drill-downs work
- [ ] Export functions work

---

## 🔧 Quick Fix Examples

### Example 1: Simple Tile Fix

**Before (broken):**
```
Explore: content_integration_search
Dimensions:
  - Content Integration Search > Affiliate Name ❌
  - Content Integration Search > dayd Date
Measures:
  - Content Integration Search > All Requests Count
```

**After (fixed):**
```
Explore: content_integration_search
Dimensions:
  - Affiliate Mapping > Affiliate Name ✅
  - Content Integration Search > dayd Date
Measures:
  - Content Integration Search > All Requests Count
```

### Example 2: Filter Fix

**Before (broken):**
```
Filter: Content Integration Search > Affiliate Name is "SkyScanner" ❌
```

**After (fixed):**
```
Filter: Affiliate Mapping > Affiliate Name is "SkyScanner" ✅
```

---

## 💡 Pro Tips

1. **Use "Affiliate (ID - Name)" instead of just "Affiliate Name"**
   - More informative
   - Easier to debug
   - Now available from `Affiliate Mapping` view

2. **Affiliate ID is now visible**
   - You can now filter by specific affiliate_id numbers
   - Useful for debugging or specific analysis

3. **Performance should be the same or better**
   - The join is efficient (many-to-one)
   - Affiliate mapping computed once per query

4. **Future-proof**
   - Adding new affiliates is now much easier
   - Less likely to have errors

---

## 📞 Questions?

If you encounter issues:

1. **Field not found?** → Update field reference (see Step 4 above)
2. **Duplicate affiliate fields?** → Use the one from `Affiliate Mapping` view
3. **Performance issues?** → Contact Looker admin (should not happen)
4. **Other problems?** → Check Migration Guide: `docs/MIGRATION_GUIDE.md`

---

## 📊 Related Dashboards to Check

These dashboards may also use content integration data:

- Revenue Content Integration Dash (ID: 1121)
- Content Dashboard (ID: 52)
- Content Dashboard 2.0 (ID: 499)
- Content Dashboard 4 (ID: 723)
- Content Performance (ID: 1541)

**Action:** Review these dashboards as well if they use affiliate dimensions.

---

*Last Updated: October 24, 2025*

