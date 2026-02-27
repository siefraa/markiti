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

        // Kotlin DSL syntax for Flutter version properties
        versionCode = project.extra["flutterVersionCode"] as Int
        versionName = project.extra["flutterVersionName"] as String

        multiDexEnabled = true
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        freeCompilerArgs += listOf("-Xjvm-default=all")
        jvmTarget = "17"
    }
}

// Flutter source
flutter {
    source = "../.."
}

// Make sure these are declared somewhere in the root or via Flutter
val flutterVersionCode: Int by project
val flutterVersionName: String by project