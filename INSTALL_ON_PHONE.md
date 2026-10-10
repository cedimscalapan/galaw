# Install Galaw on Android Phone

This repository includes a GitHub Actions workflow that builds a debug APK.

## Build the APK using your phone

1. Open this repository on GitHub.
2. Tap **Actions**.
3. Choose **Build Android APK**.
4. Tap **Run workflow**.
5. Wait for the workflow to finish.
6. Open the completed workflow run.
7. Download the artifact named **galaw-debug-apk**.
8. Extract the downloaded ZIP.
9. Install `app-debug.apk` on your Android phone.

## Android note

Since this is a debug APK, Android may ask you to allow installation from unknown sources. Allow it only for your own testing.

## Current app status

The mobile app is ready for offline demo/testing. It includes:

- Dashboard
- Workout routines
- Active workout tracker
- Sets, reps, and weight logging
- Exercise guide
- Progress summary
- Local storage for completed workouts

The backend and PostgreSQL starter are also included for future online sync.
