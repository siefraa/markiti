plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.markiti"
        minSdk = 21
        targetSdk = 34

        versionCode = 1        // hardcode your app version code
        versionName = "1.0.0"  // hardcode your app version name

        multiDexEnabled = true
    }
}
flutter {
    source = "../.."
}

// Make sure these are declared somewhere in the root or via Flutter
val flutterVersionCode: Int by project
val flutterVersionName: String by project