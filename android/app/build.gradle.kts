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

        // Access Flutter version code and name properly in Kotlin DSL
        versionCode = (extra["flutter.versionCode"] as? Int) ?: 1
        versionName = (extra["flutter.versionName"] as? String) ?: "1.0.0"

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

flutter {
    source = "../.."
}

// Make sure these are declared somewhere in the root or via Flutter
val flutterVersionCode: Int by project
val flutterVersionName: String by project