# Flossi: Implementation Plan

Cross-platform (iOS + Android) multi-currency expense tracker **Flossi** (`com.flossi`), built to match the
"Floss Expense Tracker UI" Stitch project (screens exported to `/design`).

- Toolchain found locally: **Flutter 3.47.1 (stable) / Dart 3.13.1**
- Works 100% offline; the network is used only for exchange rates.

---

## 1. Design analysis (from `/design`)

| # | Screen | Key elements to reproduce |
|---|--------|---------------------------|
| 01 | Onboarding: Welcome | Step pill "STEP 1 OF 3", stacked tilted currency cards (MAD/EUR/USD) → "Home balance" card with hero amount, headline "Money without borders…", 3 feature pills, lime "Get Started" CTA |
| 02a | Onboarding: Choose currency | Back + progress dashes, "PRIMARY LEDGER" tag, search field (recessed), *Suggested* (MAD/EUR/USD cards, selected = lime border + check), *All currencies* list with flag, code, name, country, symbol, radio |
| 02b | Onboarding: Monthly budget | Hero budget figure + currency chip, quick-adjust chips (+1,000 / +5,000 / presets / No budget), "Daily safe pace" tile, notify-at-80% toggle, 50/30/20 allocation bar |
| 03 | Home dashboard | Header (logo, greeting, home-currency dropdown chip, bell), **hero card**: total spent this month, budget progress bar, remaining pill, vs-last-month delta; *Original currencies spent* horizontal cards; *This week's pace* 7-bar chart (today = lime); *Recent activity* rows; "Auto-conversion" rates-age banner; **floating dark nav bar** with lime center FAB |
| 04 | Add expense | Currency chip strip (selected = ink), white amount card ("OUTFLOW •", hero amount, conversion pill "≈ 2,601.60 MAD (1 EUR = 10.84 MAD)"), date tile, Card/Cash/Wire segmented, note field, horizontal category grid, custom keypad, "Save Expense" CTA |
| 05 | Transactions list | Search pill, filter chips (date / categories / currencies…), day headers with day total, transaction cards (icon, title, category • time, home amount red with "≈" when converted, original amount or "Direct"), swipe-to-delete red panel, footer total pill |
| 06 | Statistics | Segmented Week/Month/Year/Custom + "View in: MAD" selector, total + vs-previous delta, **donut** with center label + legend chips, **weekly pacing line chart** (curved, gradient fill, peak tooltip), foreign-share card, top categories with progress bars |
| 08 | Currencies & FX | Sync status pill with refresh, primary base card, tracked currency rows (rate in home currency, % change chip, sparkline, enable toggle), "Add new currency", offline cache card |
| 09 | Categories | Header + "New category" CTA, monthly caps summary, category cards with cap progress (colored by category, red when near cap), editor sheet: name, glyph picker, accent palette, monthly cap stepper, Save/Reset |
| 10 | Settings | Grouped cards: Preferences (home currency, appearance segmented Light/Dark/System, language), Budgeting (monthly cap, FX refresh), Data & security (biometric lock, export, reset), About |

### Design tokens (from Stitch design system "Floss")
- **Colors:** Lime `#C6F432` (primary accent, always with ink text), Canvas `#F7F7F4`/`#FBF9F1`,
  Ink `#111111`, Muted `#73736C`, Hairline `#E6E6E1`, Recessed `#EFEFEA`, Expense `#FA5252`,
  Income `#10B981`, Olive (chart dark green) `#506600`, Mint `#70FCBE`.
- **Type:** Plus Jakarta Sans. `hero 44/48 w800 -0.035em`, `lg 32/38 w700`, `md 24/30 w700`,
  `sm 20/26 w600`, `body-lg 17/24 w500`, `body-md 15/22`, `body-sm 13/18 w500`,
  `label-caps 12/16 w700 +0.04em`, `label-code 11/14 w700 +0.08em`. Tabular figures on all amounts.
- **Spacing:** 4 / 8 / 16 / 24 / 32, screen margin 20.
- **Radii:** 8 / 16 (inputs, rows) / 24 (cards) / 32 / 48 / pill.
- **Elevation:** no blurred shadows. Cards are white with a 1px hairline; sheets get `0 12 32 rgba(17,17,17,.04)`.
- **Dark theme:** not in the designs, so I'll derive it: canvas `#0F100D`, card `#1A1B17`, hairline `#2A2B25`,
  recessed `#22231E`, ink→`#F2F1E8`, lime stays the accent (ink text on lime), the nav bar stays dark.

### Design elements I'll adapt or drop (no backend / outside the spec)
Profile/PRO badge/"Sign out of vault", QR code, receipt-scan button, voice search, GPS auto-detect currency,
cloud backup/sync, "Saved X MAD with zero FX markup" (marketing copy), and "Bank Al-Maghrib benchmark" labels.
These get replaced by real data or removed. Details are in the open questions below.

---

## 2. Architecture

Feature-first clean architecture. Dependencies point inward: `presentation → domain ← data`.

```
lib/
  main.dart                      # bootstrap: bindings, prefs, db, ProviderScope
  app.dart                       # MaterialApp.router, theme, locale, app-lock gate
  l10n/                          # app_en.arb, app_fr.arb, app_ar.arb (+ generated)
  core/
    theme/                       # tokens: colors, typography, spacing, radii, motion; app_theme.dart (light/dark)
    widgets/                     # AmountText, CurrencyChip, CategoryIcon, PrimaryButton, SecondaryButton,
                                 # AppCard, FloatingNavBar, SegmentedPill, SectionHeader, ProgressBar, EmptyState
    router/                      # app_router.dart (go_router + StatefulShellRoute), routes.dart
    money/                       # Money, Currency, CurrencyCatalog (ISO 4217), MoneyFormatter, Converter, parsing
    database/                    # drift AppDatabase, tables, migrations, DAOs
    utils/                       # clock abstraction, date ranges, result/failure types, extensions
    constants/
  features/
    onboarding/   {data, domain, presentation}
    transactions/ {data, domain, presentation}
    dashboard/    {domain, presentation}            # read-only aggregations over transactions
    stats/        {domain, presentation}
    currencies/   {data, domain, presentation}      # ExchangeRateRepository + tracked currencies
    categories/   {data, domain, presentation}
    settings/     {data, domain, presentation}      # SettingsRepository (shared_preferences), export, app lock
test/  (mirrors lib/)    integration_test/ (smoke flow, phase 6)
```

- **Domain:** freezed entities plus abstract repository interfaces. No Flutter, drift or http imports.
- **Data:** drift DAOs, the HTTP client and DTOs (json_serializable), and repository implementations
  that map rows/DTOs to entities.
- **Presentation:** screens, widgets, and Riverpod providers/notifiers (`@riverpod` codegen).
  Screens watch providers, and notifiers call repositories.
- **DI:** Riverpod only. `appDatabaseProvider`, `sharedPreferencesProvider` and `httpClientProvider`
  are overridden in `main()` and in tests.
- **Clock:** an injectable `Clock` provider, so "this month", "rates updated X ago" and the 12h staleness check are testable.

### Navigation (go_router)
- `/onboarding/welcome → /onboarding/currency → /onboarding/budget`. A redirect guard sends users here until onboarding is done.
- `StatefulShellRoute.indexedStack` holds 4 branches: `/home`, `/history`, `/stats`, `/settings`.
  `FloatingNavBar` is a custom floating dark capsule with the center lime FAB, matching the designs.
- Full-screen/modal routes above the shell: `/transaction/new`, `/transaction/:id`, `/currencies`,
  `/categories`, `/categories/edit/:id?`, `/settings/language`, `/lock`.
- Add/Edit opens as a full-screen modal with a slide-up page transition.

---

## 3. Money and currency (critical rules)

- `Money { int minor; String currencyCode }`. **No `double` anywhere in money paths.**
- `CurrencyCatalog` is a bundled, offline ISO 4217 table: code, minor-unit exponent (0 for JPY/KRW,
  2 for most, 3 for KWD/BHD/TND/OMR/JOD), symbol, English name, flag emoji, and country. The localized display
  name comes from intl/ARB for the pinned ones, with an English fallback.
- **Rates** are stored and computed as decimals: `package:decimal` with the rate persisted as a TEXT decimal string.
  `convert(Money m, Decimal rate, Currency to)` scales by `10^(toExp - fromExp)` and rounds **half-even** to
  the target minor units. Cross rates go through the snapshot base: `rate(A→B) = rate(base→B) / rate(base→A)`.
- **Parsing input:** the keypad builds a string, `MoneyInput` caps the decimals at the currency's exponent,
  and it converts to minor units with integer math.
- **Formatting:** `MoneyFormatter` wraps `NumberFormat.currency(locale, name, decimalDigits)`. It supports
  symbol vs code style ("1 250,00 MAD" in fr, "€12.50", "$12.50", Arabic digits/RTL via locale), plus a compact form for charts.
- **Totals** only ever sum `homeAmountMinor` (int), never floats.

---

## 4. Data model (drift / SQLite)

**`categories`**
| column | type | notes |
|---|---|---|
| id | TEXT PK (uuid) | |
| nameKey | TEXT? | ARB key for default categories (localized); null for user-created |
| name | TEXT? | user-entered name |
| iconKey | TEXT | key into a curated icon/emoji set |
| colorValue | INT | ARGB |
| kind | INT enum | expense / income |
| monthlyCapMinor | INT? | optional per-category cap, in the home currency (design 09) |
| sortOrder | INT | |
| isArchived | BOOL | soft delete when transactions still reference it |

Defaults (seeded): Dining, Groceries, Transport, Travel, Shopping, Bills & utilities, Subscriptions,
Health, Entertainment, Housing, Education, Other, plus income categories (Salary, Freelance, Gift, Other income).

**`transactions`**
| column | type | notes |
|---|---|---|
| id | TEXT PK (uuid) | |
| type | INT enum | expense / income |
| title | TEXT? | merchant/payee ("Espresso Lab"); shown as the row title in the designs (see Q3) |
| amountMinor | INT | > 0, sign comes from `type` |
| currencyCode | TEXT(3) | |
| homeCurrencyCode | TEXT(3) | home currency **at entry time** |
| fxRate | TEXT | decimal string, `currencyCode → homeCurrencyCode` at transaction time (`"1"` if same) |
| homeAmountMinor | INT | converted, frozen |
| rateSource | INT enum | identity / api / manual |
| categoryId | TEXT FK | |
| paymentMethod | INT enum | card / cash / transfer / other |
| date | DATETIME | user-chosen date and time |
| note | TEXT? | |
| createdAt / updatedAt | DATETIME | |

Indexes: `(date)`, `(categoryId, date)`, `(currencyCode)`.

**`rate_snapshots`**: id, baseCode, fetchedAt, provider, isManual.
**`rate_entries`**: snapshotId FK, quoteCode, rate TEXT. PK is (snapshotId, quoteCode).
- Snapshots are kept as history (pruned to one per day after 30 days, and dropped after 2 years). This history feeds
  the % change chips and sparklines on the Currencies screen, and it enables historical re-conversion.

**`tracked_currencies`**: code PK, sortOrder, isEnabled. These drive the Add screen's chip strip and the Currencies screen.

**Settings (shared_preferences)**: homeCurrency, monthlyBudgetMinor?, budgetAlertEnabled (80%),
themeMode, localeCode?, appLockEnabled, onboardingCompleted, schemaVersion.

### Home-currency change strategy
Stored values are never rewritten. When `tx.homeCurrencyCode ≠ currentHome`, the display amount is resolved in order:
1. `tx.currencyCode == currentHome` → `amountMinor` (exact).
2. The rate snapshot **closest to `tx.date`** (on or before it) → convert the original amount.
3. Otherwise, the latest snapshot (current rates).
4. If no rate exists at all, exclude the transaction from totals and flag it ("n transactions need a rate").

A `HomeAmountResolver` service does this, and every aggregate uses it. Settings shows an explainer dialog before
the change, and the dashboard shows an info chip when any totals use fallback rates.

---

## 5. Exchange rates

- `abstract interface class ExchangeRateRepository`: `Future<RateSnapshot> latest(String base)`,
  `Future<RefreshResult> refreshIfStale({Duration maxAge = 12h})`, `Stream<RateSnapshot?> watchLatest()`,
  `Future<Decimal?> rate(from, to, {DateTime? at})`, `Future<void> saveManualRate(from, to, rate)`.
- `ErApiRateSource` calls `GET https://open.er-api.com/v6/latest/{BASE}` through `package:http` with a 10s timeout,
  and parses the DTO (`result`, `time_last_update_unix`, `rates`) with json_serializable. A `RateSource` interface makes
  the provider swappable.
- On app start (and on resume), refresh if the latest snapshot is older than 12h. Failures are silent and fall back to the cache.
- The UI shows "Rates updated 4 min ago" or "Offline · rates from 2 days ago", plus manual pull-to-refresh.
- **First launch without network:** onboarding works fully. When adding a transaction in a foreign currency with no
  rate available, the conversion pill turns into "Enter rate", which opens a sheet. The result is saved as a manual snapshot.

---

## 6. Packages

| Purpose | Package |
|---|---|
| State | `flutter_riverpod`, `riverpod_annotation` · dev: `riverpod_generator`, `riverpod_lint`, `custom_lint` |
| Routing | `go_router` |
| DB | `drift`, `drift_flutter`, `sqlite3_flutter_libs`, `path_provider` · dev: `drift_dev` |
| Models | `freezed_annotation`, `json_annotation` · dev: `freezed`, `json_serializable`, `build_runner` |
| Money math | `decimal` |
| Network | `http` |
| Charts | `fl_chart` |
| i18n | `intl`, `flutter_localizations` (sdk), `gen-l10n` |
| Settings | `shared_preferences` |
| Export | `csv`, `share_plus` |
| Lock | `local_auth` |
| Misc | `uuid`, `collection` |
| Lints/tests | `very_good_analysis`, `mocktail`, `flutter_test`, `integration_test` |
| Branding | dev: `flutter_launcher_icons`, `flutter_native_splash` |

The font (**Plus Jakarta Sans**, OFL license) ships as a bundled asset in `assets/fonts/`. I'm not using `google_fonts`,
because it fetches fonts at runtime, which breaks the offline-first rule. Versions will be the latest stable at
setup time, resolved with `flutter pub add`.

---

## 7. Phased roadmap

Every phase ends with `dart run build_runner build`, `flutter analyze` (zero issues), `flutter test`, a README
update, and a written summary.

**Phase 1: Foundation**
- `flutter create` (iOS + Android only), strict `analysis_options.yaml` (very_good_analysis), and the folder skeleton.
- Design system: tokens, light and dark `ThemeData`/`ColorScheme` + `ThemeExtension`s for custom tokens,
  and the core widgets (AmountText with animated counter, CurrencyChip, CategoryIcon, PrimaryButton, AppCard,
  FloatingNavBar, SegmentedPill) plus a hidden `/dev/gallery` route to review them.
- go_router with the shell and placeholder screens, the onboarding redirect, and l10n scaffolding (EN ARB to start).
- Drift schema v1 (all tables above), DB provider, and the seed of default categories.
- Money core: `Currency`/catalog, `Money`, `MoneyInput`, `Converter`, `MoneyFormatter`.
- **Tests:** rounding and exponents (JPY 0, KWD 3), cross rates, parsing, formatting in en/fr/ar, and DB smoke tests (in-memory).

**Phase 2: Core flows**
- Onboarding (3 screens per the designs) and the settings repository.
- Categories: list with cap progress, plus create/edit/delete sheet (glyph, palette, cap).
- Add/Edit transaction: keypad, currency strip, conversion pill (rate taken from the cache; a manual entry sheet if none),
  date picker, payment method, note, title, category grid, expense/income toggle.
- Transactions list: grouped by day with day totals, search, filters sheet, swipe-to-delete with an undo snackbar.
- **Tests:** repositories, and a widget test for Add Transaction.

**Phase 3: Exchange rates**
- `ErApiRateSource`, caching repository, staleness refresh on start/resume, the `HomeAmountResolver`, and the
  Currencies screen (tracked list, toggles, % change, sparklines, add currency, sync status, offline card).
- **Tests:** repository with a mocked HTTP client (fresh, stale, offline, and first-launch cases) and the resolver fallbacks.

**Phase 4: Dashboard and Stats**
- Dashboard: hero total, budget progress, by-currency cards, weekly bars, recent activity, and the rates banner.
- Stats: Week/Month/Year/Custom, donut with tap-to-inspect, line chart over time, top categories,
  "view in" any currency, and a comparison with the previous period.
- **Tests:** aggregation logic and a Dashboard widget test.

**Phase 5: Settings, i18n, export, lock**
- Settings screen; home-currency change with an explainer; theme; budget; language (EN/FR/AR) with full RTL
  (directional paddings/icons, mirrored charts where it makes sense); CSV export with share_plus;
  biometric lock on launch and resume; reset data with a confirmation.
- Complete the FR and AR ARB files and audit for any remaining hardcoded strings.

**Phase 6: Polish**
- Motion: hero amount transitions, animated counters, sheet and page transitions, chart entry animations.
- Empty, loading and error states for every screen; accessibility (semantics, text scaling, contrast check for dark mode).
- App icon and splash; an integration smoke test (onboard → add → see on dashboard).

---

## 8. Testing strategy
- **Unit:** money math, formatter, converter, resolver, rate repository (mocktail HTTP + in-memory drift),
  transaction and category repositories, and aggregations (fixed `Clock`).
- **Widget:** Add Transaction (keypad entry, currency switch updates the preview, save calls the repo) and
  Dashboard (renders totals/budget from fake providers), plus golden-free assertions.
- In-memory drift with `NativeDatabase.memory()` for repository tests.

---

## 9. Decisions (confirmed before Phase 1)

1. **App identity:** name **Flossi**, bundle ID / application ID **`com.flossi`**.
2. **Out-of-spec design elements** (profile, PRO badge, sign-out, QR code, receipt scan, voice search, GPS auto-detect,
   cloud backup) are dropped or replaced with real data.
3. **Transaction title** (merchant) and **per-category monthly caps** are included.
4. **Budget alert at 80%** is in-app only for v1 (no push notifications).

Assumptions: the dark theme is derived from the light tokens; Plus Jakarta Sans is bundled (it has no Arabic glyphs,
so Arabic falls back to the platform font, and a bundled Arabic face is considered in Phase 5); default categories have
localized names; the minimum OS is iOS 13+ / Android API 23+.
