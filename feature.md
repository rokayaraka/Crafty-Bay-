# Feature Development Guide

Use this file as the default rulebook for adding a new feature, screen, widget, or UI flow in this Flutter app.

## 1. Core principles

- Start with the user problem, the expected result, and the minimum usable version of the feature.
- Keep the implementation simple unless there is a clear reason to add complexity.
- Reuse existing code before creating new code.
- Keep business logic, UI, and data handling separated when the feature grows beyond a small screen.
- Make changes that are easy to read, test, and maintain.

## 2. Project structure

This project already uses a feature-first structure. Follow the same pattern for any new work.

```text
lib/
	app/
		app_colors.dart
		app_theme.dart
		asset_paths.dart
		crafty_bay_app.dart
		extensions/
		providers/
		routes.dart
	features/
		auth/
			presentation/
				screens/
				widgets/
				providers/
		carts/
			presentation/
				screens/
		home/
			presentation/
				screens/
				widgets/
		products/
			presentation/
				screens/
		Category/
			presentation/
				screens/
		shared/
			presentation/
				presentation/
					providers/
					main_nav_holder_screen.dart
				widgets/
				utility/
	l10n/
	main.dart
assets/
test/
```

### Where code should go

- Put app-wide setup in `lib/app` only when the code is used across multiple features.
- Put feature-specific screens, widgets, and providers inside `lib/features/<feature_name>`.
- Put cross-feature widgets in `lib/features/shared/presentation/widgets`.
- Put shared helper code such as validators in `lib/features/shared/presentation/utility` until a broader shared layer is needed.
- Keep localization files in `lib/l10n`.
- Keep static files in `assets/` and map them through `lib/app/asset_paths.dart`.
- Keep widget and unit tests in `test/`.

### Current app patterns to follow

- Firebase is initialized in `lib/main.dart` before `runApp`.
- Theme mode and locale are managed through providers in `lib/app/providers`.
- Navigation uses named routes from `lib/app/routes.dart`.
- The bottom navigation shell lives in `lib/features/shared/presentation/presentation/main_nav_holder_screen.dart`.
- Shared UI pieces such as cards, buttons, and validators live under `lib/features/shared/presentation`.

## 3. Feature implementation rules

- Put new feature screens in a feature-specific `screens` folder.
- Put feature-only widgets in that feature’s `widgets` folder.
- Put feature state logic in a provider, controller, notifier, or bloc that matches the project style.
- Keep navigation decisions close to the feature that owns the flow.
- Keep reusable code small and focused.
- Avoid mixing presentation code with data fetching or complex business rules.

## 4. UI and design rules

- Design for clarity first: spacing, hierarchy, typography, and interaction states matter more than decoration.
- Keep the UI consistent with the app’s existing theme and color system.
- Make the primary action visually obvious.
- Keep secondary actions quieter and less prominent.
- Use small, reusable widgets for repeated patterns.
- Do not overuse shadows, gradients, or motion unless they improve the experience.
- Make layouts work on different screen sizes and content lengths.
- Keep touch targets comfortable for mobile use.

### UI defaults for this project

- Prefer clean, practical screens over overly decorative ones.
- Use the shared theme colors from `lib/app/app_colors.dart` and `lib/app/app_theme.dart`.
- Keep padding, spacing, and card styles consistent across screens.
- Reuse shared widgets such as product cards, category cards, and section headers when possible.
- Keep app bars, bottom bars, and other shell UI consistent across screens.

## 5. State management rules

- Use the simplest state solution that fits the feature.
- Keep local UI state local.
- Move shared or long-lived state into the app’s existing provider-based structure.
- Treat loading, empty, success, and error as first-class states.
- Make state transitions predictable and easy to debug.

## 6. Data and logic rules

- Validate input before using it.
- Convert raw API or storage data into app-friendly models before it reaches the UI.
- Keep technical errors out of the user interface.
- Fail gracefully when data is missing or invalid.
- Avoid hardcoding environment-specific values inside feature widgets.

## 7. Accessibility rules

- Use clear labels for buttons, icons, and custom controls.
- Keep contrast readable.
- Make sure important information is not communicated by color alone.
- Keep layouts usable with larger text settings.
- Avoid compact controls that are hard to tap on mobile.

## 8. Localization rules

- Keep user-facing text in localization files when the string should be translated.
- Do not hardcode text in widgets when a localized string exists.
- Design layouts that can handle longer translated strings.
- Keep date, number, and currency formatting locale-aware.

## 9. Performance rules

- Avoid rebuilding large widget trees when a smaller widget can update instead.
- Use lazy lists for large collections.
- Dispose controllers and listeners properly.
- Avoid expensive work in `build` methods.
- Keep image and asset sizes reasonable.

## 10. Testing rules

- Add or update widget tests for important screens and interactions.
- Add unit tests for logic that can fail independently of the UI.
- Test loading, empty, success, and error states when they matter.
- Update tests when shared behavior changes.

## 11. Code quality rules

- Keep names descriptive and consistent.
- Keep functions small and focused.
- Remove dead code and temporary debug prints before finishing.
- Match the project’s formatting and lint rules.
- Prefer straightforward code over clever code.

## 12. Feature checklist

- [ ] Requirements are clear.
- [ ] Existing reusable code was checked.
- [ ] The feature fits the current folder structure.
- [ ] UI follows the project’s theme and spacing style.
- [ ] Shared widgets were reused where possible.
- [ ] State handling is simple and correct.
- [ ] Loading, empty, success, and error states are covered.
- [ ] User-facing text is localized where needed.
- [ ] Accessibility was considered.
- [ ] Tests were added or updated.
- [ ] Code was formatted and lint-friendly.

## 13. Before finishing a feature

- Verify the feature works on the intended screen sizes.
- Check that the UI feels consistent with the rest of the app.
- Confirm that navigation, localization, and error handling still behave correctly.
- Review the diff for accidental changes outside the feature scope.

If a new feature needs a special rule set, add it here so the whole team follows one source of truth.
