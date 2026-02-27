plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.markiti"
        minSdk = 21
        targetSdk = 34

        // Use function calls
        versionCode(flutter.versionCode)
        versionName(flutter.versionName)

        multiDexEnabled = true
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        // Use compilerOptions DSL instead of deprecated jvmTarget string
        freeCompilerArgs = listOf("-Xjvm-default=all")
        jvmTarget = "17"
    }
}

flutter {
    source = "../.."
}
