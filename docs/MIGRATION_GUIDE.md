# Migration Guide: Advanced Refactoring Changes

**Date:** October 24, 2025  
**Branch:** `feature/advanced-refactoring`

---

## Overview

This guide helps you update existing dashboards, looks, and reports after the advanced refactoring changes. Most changes are backward compatible, but affiliate dimensions require updates.

---

## 🔴 BREAKING CHANGES

### 1. Affiliate Dimensions Moved to Joined View

**What Changed:**
- `affiliate_name` and `affiliate_label` dimensions moved from `content_integration_search` to a separate `affiliate_mapping` view
- These dimensions are now accessed via a join

**Impact:**
- Any dashboard, look, or saved query using affiliate dimensions will need updating
- Fields will show as "Field not found" until updated

**How to Fix:**

#### In Dashboards & Looks:
1. Open the affected dashboard/look in edit mode
2. For each tile using affiliate fields, click **Edit**
3. Remove the old field
4. Add the new field from the correct view:

| ❌ Old Field (will break) | ✅ New Field (use this) |
|---------------------------|------------------------|
| `Content Integration Search > Affiliate Name` | `Affiliate Mapping > Affiliate Name` |
| `Content Integration Search > Affiliate (ID - Name)` | `Affiliate Mapping > Affiliate (ID - Name)` |

#### In Explores:
- Old: `content_integration_search.affiliate_name`
- New: `affiliate_mapping.affiliate_name`

- Old: `content_integration_search.affiliate_label`  
- New: `affiliate_mapping.affiliate_label`

---

## ✅ NON-BREAKING CHANGES

These changes should work automatically:

### 2. Currency Dimensions (Backward Compatible)
- `site_currency` and `content_currency` now use normalized fields in derived table
- **No action needed** - fields work the same way

### 3. Affiliate ID Dimension (Now Visible)
- `affiliate_id` was previously hidden, now visible
- **No action needed** - existing queries continue to work

### 4. Comment Style Changes
- Section headers now use `===` style
- **No action needed** - cosmetic change only

### 5. Response Time NULL Handling
- Better NULL handling in derived table
- **No action needed** - improved accuracy

---

## 🔍 How to Check if Your Dashboard Needs Updates

### Step 1: Identify Affected Dashboards

Run this query in Looker's SQL Runner (System Activity):
```sql
-- Find dashboards using affiliate dimensions
SELECT 
  dashboard_id,
  dashboard_title,
  COUNT(*) as affected_tiles
FROM dashboard_elements
WHERE query LIKE '%affiliate_name%' 
   OR query LIKE '%affiliate_label%'
GROUP BY dashboard_id, dashboard_title
```

### Step 2: Check Individual Dashboards

1. Go to the dashboard
2. Look for tiles showing errors or "(field not found)"
3. Those tiles need updating per instructions above

---

## 📋 Field Reference Changes

### Dimensions That Moved

| Field | View (Old) | View (New) | Status |
|-------|-----------|-----------|--------|
| `affiliate_name` | `content_integration_search` | `affiliate_mapping` | ⚠️ **Requires update** |
| `affiliate_label` | `content_integration_search` | `affiliate_mapping` | ⚠️ **Requires update** |
| `affiliate_id` | `content_integration_search` | `content_integration_search` | ✅ Same (now visible) |

### Dimensions That Didn't Change

All other dimensions remain in `content_integration_search`:
- ✅ `dayd_date`, `dayd_time`, etc.
- ✅ `content_source`
- ✅ `office_id`
- ✅ `site_currency`, `content_currency`
- ✅ `search_engine`
- ✅ `api_call`
- ✅ `origin`, `destination`
- ✅ All measures

---

## 🧪 Testing Checklist

After updating dashboards:

- [ ] All tiles load without errors
- [ ] Affiliate names display correctly
- [ ] Filters on affiliate dimensions still work
- [ ] All measures calculate correctly
- [ ] No "field not found" errors
- [ ] Performance is acceptable (should be same or better)

---

## 💡 Benefits of the Change

**Why we made this change:**

1. **Easier Maintenance:** Adding new affiliates is now 1 line instead of 2
2. **Better Performance:** Affiliate mapping computed once, not per query
3. **Cleaner Code:** 157-line CASE statement eliminated
4. **Data Quality:** Easier to spot duplicates or errors
5. **Scalability:** Can easily add more affiliate metadata (categories, active status, etc.)

---

## 🆘 Need Help?

**Common Issues:**

**Issue:** "Field not found" error  
**Solution:** Update field reference from `content_integration_search.affiliate_name` to `affiliate_mapping.affiliate_name`

**Issue:** Affiliate dimension shows in two places  
**Solution:** This is expected - use the one from `Affiliate Mapping` view

**Issue:** Performance seems slower  
**Solution:** The join is efficient (many-to-one). If issues persist, check query and database indexes

---

## 📞 Support

For questions or issues with migration:
1. Check this guide first
2. Review the code review document: `docs/reviews/2025-10-24_REVIEW.md`
3. Contact your Looker administrator

---

*Last Updated: October 24, 2025*

