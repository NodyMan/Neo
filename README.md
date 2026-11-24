# Neo

**A personal AI assistant you can talk to, which can also use your phone and your PC for you.**

Neo is a Flutter app for Android and Windows. You talk to it by voice or text in English, Russian or Uzbek. It answers like a person, remembers what you ask it to, and does things on your devices: it opens apps, writes messages, sets timers, plays music, tracks your spending, and controls your computer from your phone.

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)
![Kotlin](https://img.shields.io/badge/Kotlin-7F52FF?logo=kotlin&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-3FCF8E?logo=supabase&logoColor=white)
![Gemini](https://img.shields.io/badge/Google%20Gemini-8E75B2?logo=googlegemini&logoColor=white)

## What Neo can do

| Area | Features |
|---|---|
| **Talk** | Voice and text chat; answers in English, Russian or Uzbek. Gemini is the main model, with Groq as a backup. Neo speaks with Gemini voices. |
| **"Hey Neo"** | A hands-free wake word that works even when the app is closed. Neo can also be the phone's Assistant button. |
| **Phone control** | Uses Android Accessibility to open apps and sites, tap, type, scroll, read the screen, call, text, set alarms and timers, navigate, and control music. A kill switch in Settings stops all actions. |
| **Messages** | "Write to Aziz on WhatsApp that I'm late": Neo drafts the message and opens Telegram, WhatsApp, SMS, Gmail and other apps ready to send. |
| **PC remote** | Sign in to *Neo for PC* on Windows to see the PC screen live on your phone. You can tap, type and use shortcuts, or ask Neo to do things on the PC. |
| **Money** | Logs expenses from receipts (photo) and from bank payment notifications. Warns when spending runs ahead of budget. |
| **Memory and notes** | "Remember that my passport expires in May" goes into searchable notes that Neo uses later. |
| **Smart home screen** | Shows today's tasks, upcoming bills, unusual spending and mood. Neo adapts its tone when you're stressed. |
| **Offline mode** | Timers, alarms, calls, apps and navigation still work without internet. Other requests are queued and sent when you're back online. |

## How it's built

```
neo_app/
  lib/
    neo/        brain (Gemini/Groq), local brain for offline, agent tools, live call, animated face
    screens/    home, chat, live, notes, money, PC, approvals, activity, settings, login
    pc/         remote PC agent: screen capture and input
    desktop/    Windows desktop shell
    money/      categories and the add-transaction sheet
  tool/
    android/    native Kotlin services: wake word, accessibility, notification listener, assist activity
    windows/    app icon
```

- **App:** Flutter (Dart) for Android and Windows
- **Backend:** Supabase (auth, database, Edge Functions)
- **AI:** Google Gemini (chat and voice) with Groq as a fallback
- **Native Android:** Kotlin services for the wake word, Accessibility control and notification reading

## Building

The full app source is in **`neo_app.zip`**. The `neo_app/` folder holds only a few files that the build scripts use.

**With GitHub Actions (no setup needed):** every push runs [`.github/workflows/build.yaml`](.github/workflows/build.yaml). The workflow picks the newest Neo zip in the repo by app version, builds the Android APK and the Windows app, and publishes a Release when the push is to `main`. To keep installs updating in place, add the signing key as repo secrets: `NEO_KEYSTORE_B64`, `NEO_KEYSTORE_PASSWORD`, `NEO_KEY_ALIAS` and `NEO_KEY_PASSWORD`.

**On your own machine:**

```bash
unzip neo_app.zip && cd neo_app
flutter pub get
bash tool/prepare_android.sh   # adds Neo's native Android services and icons
flutter run
```

Set your Supabase project URL and anon key in `lib/config.dart` before running.

## Status

Neo is a personal project under active development (current version **2.4.1**). Built by [Nody](https://github.com/NodyMan) at [Nexora Studio](https://nexorastudio.world).
