# Kiranpreet Kaur — Flutter Developer Portfolio

A personal portfolio website built with Flutter Web to showcase Kiranpreet Kaur's experience, projects, technical skills, and case studies.

## Built With

- Flutter
- Dart
- Flutter Web
- shared_preferences, for saving the selected theme

## Features

- Responsive portfolio website
- Dark, light, and system appearance
- Accent theme selection: Ocean Blue, Editorial Burgundy, Emerald, Violet, Coral, and Amber
- Project showcase
- Project case studies
- Responsive layouts for mobile, tablet, and desktop
- Smooth section navigation
- Contact section
- Resume access when a resume file is configured
- Flutter Web release build for static hosting

## Featured Projects

- **Daawat** — An integrated restaurant and bakery ecosystem covering customer ordering, services, rewards, and order workflows. Android, iOS, and web.
- **ViewGhana** — A platform connecting users with offers and experiences from restaurants, lounges, cinemas, and other businesses in Ghana. Android and iOS.
- **Bumper Buds** — A Flutter application for placing customizable banners in PDF documents and purchasing those placements.

## Project Structure

- `lib/` — Application code. `lib/app` holds theming and routing. `lib/features` holds the homepage, about, skills, projects, experience, education, and contact sections. `lib/core` holds shared layout, navigation, and public link settings.
- `assets/` — Public project screenshots under `assets/projects/`, and the resume file under `assets/resume/` when it is added.
- `web/` — Flutter Web entry files, icons, manifest, and `robots.txt`.
- `deploy/` — Sitemap template. It stays out of the release build until a public site URL exists.
- `test/` — Widget tests for the portfolio.

Public links live in `lib/core/constants/app_links.dart`. The site URL and Open Graph image path live in `lib/core/config/site_config.dart`. Leave a value unset until the real public value exists.

## Running Locally

```bash
flutter pub get
flutter run -d chrome
```

## Production Build

```bash
flutter build web --release
```

The release output is written to `build/web`.

## Deployment

The release build is a set of static files. It can be deployed to any static host that serves HTTPS and can use a custom domain. No hosting provider is hard-coded in the app.

1. Install dependencies:

```bash
flutter pub get
```

2. Build:

```bash
flutter build web --release
```

3. Deployment output:

`build/web`

Upload the contents of that folder. The default build uses `<base href="/">`, which matches a site hosted at the domain root.

The host must serve `index.html` for application routes when the browser requests a path directly. Those routes are `/`, `/profile`, `/freelance`, `/projects/viewghana`, `/projects/bumper-buds`, and `/projects/daawat`.

`web/robots.txt` allows crawling. The sitemap line stays commented until a public site URL is set in `lib/core/config/site_config.dart`. This repository does not record a completed deployment.

## Author

Kiranpreet Kaur

Flutter Developer
