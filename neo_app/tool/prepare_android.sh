#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

if [ ! -f android/gradlew ]; then
  flutter create --platforms=android .
fi

python3 - <<'PY'
from pathlib import Path

manifest_path = Path('android/app/src/main/AndroidManifest.xml')
manifest_path.write_text('''<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />

    <queries>
        <intent>
            <action android:name="android.intent.action.TTS_SERVICE" />
        </intent>
    </queries>

    <application
        android:label="Neo"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:theme="@style/LaunchTheme">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <meta-data
                android:name="io.flutter.embedding.android.NormalTheme"
                android:value="@style/NormalTheme" />
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
</manifest>
''')

build_gradle = Path('android/app/build.gradle')
text = build_gradle.read_text()
text = text.replace('minSdkVersion flutter.minSdkVersion', 'minSdkVersion 24')
text = text.replace('targetSdkVersion flutter.targetSdkVersion', 'targetSdkVersion flutter.targetSdkVersion')
if 'ndkVersion' not in text:
    text = text.replace('compileSdkVersion flutter.compileSdkVersion\n', 'compileSdkVersion flutter.compileSdkVersion\n\n    ndkVersion = "27.1.12297006"\n')
build_gradle.write_text(text)

project_gradle = Path('android/build.gradle')
text = project_gradle.read_text()
text = text.replace("ext.kotlin_version = '1.7.10'", "ext.kotlin_version = '2.0.21'")
project_gradle.write_text(text)
PY

flutter pub get
