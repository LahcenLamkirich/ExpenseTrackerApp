# Flossi

A multi-currency expense tracker for iOS and Android, built with Flutter.
It works completely offline: all data stays on the device, and the network is used only to refresh exchange rates.

UI designs live in [`design/`](design/), exported from the Stitch project "Floss Expense Tracker UI".
The architecture and roadmap are in [`PLAN.md`](PLAN.md).

## Requirements

- Flutter **3.47+** (stable) / Dart **3.13+**
- Android Studio (Android SDK, API 23+) and/or Xcode 15+ (iOS 13+)

## Setup

```bash
flutter pub get
dart run build_runner build      # drift, riverpod, freezed, json_serializable
flutter gen-l10n                 # also runs automatically on build (generate: true)
flutter run
```

Web preview (dev only; drift uses `web/sqlite3.wasm` + `web/drift_worker.js`):

```bash
flutter run -d web-server --release --web-port 8082
```

While developing, keep code generation running:

```bash
dart run build_runner watch
```

## Quality checks

```bash
flutter analyze                  # very_good_analysis + riverpod_lint, strict casts/inference
flutter test                     # unit + widget tests
```

## Project structure

```
lib/
  core/
    database/     drift schema (categories, transactions, rate snapshots, tracked currencies)
    domain/       enums shared by schema and features
    money/        Money, Currency catalog, ExchangeRate, MoneyInput, MoneyFormatter
    providers/    SharedPreferences + Clock providers
    router/       go_router config, StatefulShellRoute app shell
    theme/        design tokens (colors, typography, spacing, motion) + light/dark ThemeData
    widgets/      AmountText, HeroAmount, CurrencyChip, CategoryIcon, PrimaryButton, AppCard, FloatingNavBar, …
  features/
    onboarding/ transactions/ dashboard/ stats/ currencies/ categories/ settings/
      data/ domain/ presentation/
    dev/          design-system gallery (debug builds: Settings → Design system)
  l10n/           ARB files (en, fr, ar) → generated AppLocalizations
assets/fonts/     Plus Jakarta Sans (OFL), bundled for offline use
design/           Stitch screen exports
```

## Money rules

- Amounts are **integer minor units + ISO 4217 code**. `double` is never used for money.
- Exchange rates are stored as exact decimal strings and applied with rational arithmetic,
  then rounded **half-even** to the target currency's minor units (JPY 0, EUR 2, KWD 3 …).
- Every transaction freezes its rate and its converted home amount at entry time, so historical
  totals never change when rates move.

## Status

| Phase | Scope | Status |
|---|---|---|
| 1 | Setup, design system, router, DB schema, money utilities + tests | ✅ Done |
| 2 | Onboarding, categories, add/edit/list transactions | ✅ Done |
| 3 | Exchange-rate service + caching, Currencies screen | ✅ Done |
| 4 | Dashboard + Stats charts | ✅ Done |
| 5 | Settings, EN/FR/AR + RTL, CSV export, app lock | ✅ Done (device testing of biometrics pending) |
| 6 | Polish, empty/error states, icon + splash | — |

### Exchange rates

- Provider: [open.er-api.com](https://open.er-api.com) (`ErApiRateSource`), behind the `RemoteRateSource`
  interface. Swap it in `remoteRateSourceProvider` (`lib/features/currencies/presentation/rate_providers.dart`).
- Rates are cached as snapshots in SQLite and refreshed on launch and on resume when older than 12 hours.
  Snapshots are kept in full for 30 days, then one per day, for up to 2 years. This history feeds the
  % change and sparklines.
- Offline or on first launch, the last cached rates are used. If none exist, Add Transaction asks for a manual rate,
  which is stored as a manual snapshot.

### Known gaps

- Three DB-backed widget tests (Add Transaction ×2, onboarding flow) are temporarily `skip: true`:
  drift futures don't settle under `testWidgets`' fake-async zone. Re-enabling them is tracked for Phase 6.
  All unit/repository tests run.

## Building the iOS app on Codemagic

`codemagic.yaml` defines two workflows.

1. Push this repository to GitHub, GitLab or Bitbucket, then add it as an app in [Codemagic](https://codemagic.io).
2. **`ios-unsigned`** needs no Apple account. It produces `Flossi-unsigned.ipa`. An unsigned IPA cannot be
   installed on an iPhone directly; it must be re-signed first.
3. **`ios-release`** produces an installable, signed IPA. It requires:
   - an Apple Developer Program membership,
   - the bundle ID `com.flossi` registered in your Apple account (pick another ID if it is taken, and update it in
     Xcode and `codemagic.yaml`),
   - an App Store Connect API key added in Codemagic → Team settings → Integrations, named `Flossi ASC key`,
   - automatic code signing enabled in Codemagic for `com.flossi`.

   Use `distribution_type: ad_hoc` to install directly on registered devices, or `app_store` for TestFlight.
