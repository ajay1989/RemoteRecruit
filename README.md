# RemoteRecruit

A job browser iOS app that lets you browse remote jobs, search by title or company, and view full job details.

## Setup

1. Clone the repo
2. Open RemoteRecruit.xcodeproj in Xcode
3. Run with Cmd+R. No additional setup or dependencies needed.

## Architecture

The app follows MVVM with a layered structure:

View > ViewModel > Service > Repository > DataSource

View renders the UI and reads state from the ViewModel. It does not talk to the Service or Repository directly.

ViewModel owns the UI state and manages async tasks. Marked @Observable and @MainActor so SwiftUI tracks changes automatically.

Service contains the business logic and coordinates data flow between the ViewModel and Repository.

Repository decides whether to return cached data or fetch fresh from the network. Uses an in-memory LRU cache to avoid unnecessary API calls.

DataSource handles network calls only. It maps the API response into the domain model used by the rest of the app.

Each layer has a protocol so every dependency can be injected and mocked in tests. AppContainer is the single place where all dependencies are wired together.

## Tech Stack

- Swift 5+, SwiftUI
- async/await for networking
- Combine for search debouncing
- URLSession with no third-party networking libraries
- Generic actor-based LRU Cache
- Swift Testing for unit tests

## Data Source

Remotive public API (https://remotive.com/api/remote-jobs). Free and requires no API key.

## Assumptions

- Search filters the already-fetched list locally. No extra network call per keystroke.
- Pull-to-refresh invalidates the cache and forces a fresh network fetch.
- Salary is shown as returned by the API. Some listings return an empty value.
- Full job list is fetched on launch. The API does not support pagination.

## Known Limitations

- Company logos from Remotive are SVG files. AsyncImage does not support SVG natively so a placeholder icon is shown instead.
- Cache is in-memory only and clears when the app is restarted.
