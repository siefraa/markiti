# Twende Markiti - Mwongozo wa Uanzishaji (Setup Guide)

## Hatua za Kuanzisha Project

### 1. Mahitaji (Prerequisites)

Kabla ya kuanza, hakikisha una:

- **Flutter SDK** (version 3.0.0 au zaidi)
- **Dart SDK** 
- **Android Studio** au **Visual Studio Code**
- **Git**

### 2. Kupata Flutter SDK

#### Windows
```bash
# Download Flutter SDK from: https://flutter.dev/docs/get-started/install/windows
# Extract na ongeza kwenye PATH
```

#### macOS
```bash
# Download Flutter SDK from: https://flutter.dev/docs/get-started/install/macos
# Au tumia Homebrew:
brew install flutter
```

#### Linux
```bash
# Download Flutter SDK from: https://flutter.dev/docs/get-started/install/linux
# Extract na ongeza kwenye PATH
```

### 3. Verify Installation

```bash
flutter doctor
```

Hii itaonyesha kama Flutter imeinstall vizuri na kuna nini kinachokosekana.

### 4. Setup Project

```bash
# Clone repository
git clone <your-repo-url>
cd twende_markiti

# Get dependencies
flutter pub get

# Run the app
flutter run
```

## Project Structure

```
twende_markiti/
├── lib/
│   ├── main.dart                      # Entry point ya app
│   ├── models/                        # Data models
│   │   ├── user_model.dart
│   │   ├── product_model.dart
│   │   └── order_model.dart
│   ├── services/                      # Business logic & API calls
│   │   └── auth_service.dart
│   ├── screens/                       # UI screens
│   │   ├── splash_screen.dart
│   │   ├── auth/
│   │   │   ├── login_screen.dart
│   │   │   └── register_screen.dart
│   │   ├── admin/
│   │   │   ├── admin_dashboard.dart
│   │   │   └── permissions_screen.dart
│   │   ├── home/
│   │   │   └── home_screen.dart
│   │   ├── products/
│   │   │   ├── product_list_screen.dart
│   │   │   └── product_detail_screen.dart
│   │   ├── cart/
│   │   │   └── cart_screen.dart
│   │   └── orders/
│   │       └── orders_screen.dart
├── pubspec.yaml                       # Dependencies
└── README.md
```

## Jinsi ya Kuongeza Backend

### Option 1: Firebase

1. **Fungua Firebase Console**
   - Nenda https://console.firebase.google.com
   - Unda project mpya

2. **Ongeza Firebase kwenye Flutter app**
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure
```

3. **Ongeza dependencies kwenye pubspec.yaml**
```yaml
dependencies:
  firebase_core: ^2.24.2
  firebase_auth: ^4.16.0
  cloud_firestore: ^4.14.0
```

4. **Initialize Firebase kwenye main.dart**
```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TwendeMarkitiApp());
}
```

### Option 2: Custom REST API

1. **Setup HTTP package**
```yaml
dependencies:
  http: ^1.1.0
```

2. **Create API service**
```dart
// lib/services/api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://your-api.com/api';
  
  Future<dynamic> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
    );
    return json.decode(response.body);
  }
  
  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return json.decode(response.body);
  }
}
```

## Jinsi ya Kuongeza M-Pesa Payment

### 1. Get M-Pesa API Credentials
- Jisajili kwenye https://developer.safaricom.co.ke
- Pata Consumer Key na Consumer Secret

### 2. Install M-Pesa Package
```yaml
dependencies:
  mpesa_flutter_plugin: ^1.3.0
```

### 3. Implement Payment
```dart
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

// Initialize M-Pesa
MpesaFlutterPlugin.setConsumerKey("YOUR_CONSUMER_KEY");
MpesaFlutterPlugin.setConsumerSecret("YOUR_CONSUMER_SECRET");

// STK Push
dynamic result = await MpesaFlutterPlugin.initializeMpesaSTKPush(
  businessShortCode: "174379",
  transactionType: TransactionType.CustomerPayBillOnline,
  amount: 1000.0,
  partyA: "254712345678",
  partyB: "174379",
  callBackURL: "https://your-callback-url.com",
  accountReference: "ORDER_123",
  phoneNumber: "254712345678",
  baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
  transactionDesc: "Payment for order",
  passKey: "YOUR_PASS_KEY",
);
```

## State Management Options

### Option 1: Provider (Recommended for beginners)
```yaml
dependencies:
  provider: ^6.1.1
```

### Option 2: Riverpod (Modern & Powerful)
```yaml
dependencies:
  flutter_riverpod: ^2.4.9
```

### Option 3: Bloc (Enterprise Level)
```yaml
dependencies:
  flutter_bloc: ^8.1.3
  bloc: ^8.1.2
```

## Testing

### Unit Tests
```bash
flutter test
```

### Integration Tests
```bash
flutter drive --target=test_driver/app.dart
```

## Building for Release

### Android
```bash
# Build APK
flutter build apk --release

# Build App Bundle (for Google Play)
flutter build appbundle --release
```

### iOS
```bash
# Build for iOS
flutter build ios --release
```

## Common Issues & Solutions

### Issue 1: Gradle Build Failed
**Solution:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Issue 2: SDK Version Issues
**Solution:**
Badilisha `minSdkVersion` kwenye `android/app/build.gradle`:
```gradle
defaultConfig {
    minSdkVersion 21  // Badilisha kuwa 21
    targetSdkVersion 33
}
```

### Issue 3: CocoaPods Issues (iOS)
**Solution:**
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter run
```

## Useful Commands

```bash
# Check Flutter version
flutter --version

# Update Flutter
flutter upgrade

# Clean project
flutter clean

# Get dependencies
flutter pub get

# Run app
flutter run

# Run on specific device
flutter run -d <device-id>

# List devices
flutter devices

# Build APK
flutter build apk

# Check for issues
flutter doctor
```

## Resources

- **Flutter Documentation:** https://flutter.dev/docs
- **Dart Documentation:** https://dart.dev/guides
- **Firebase Documentation:** https://firebase.google.com/docs
- **M-Pesa API Documentation:** https://developer.safaricom.co.ke/docs

## Support

Kwa msaada zaidi, wasiliana:
- Email: support@twendemarkiti.co.tz
- GitHub Issues: <repository-issues-url>

---

**Happy Coding! 🚀**
