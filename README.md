# Twende Markiti - Online Market Shopping App

## Maelezo ya App

**Twende Markiti** ni application ya online marketplace ambayo inaruhusu watumiaji kununua bidhaa mbalimbali za soko la sokoni. App hii ina mfumo wa admin wenye uwezo wa kusimamia ruhusa (permissions) za watumiaji.

## Vipengele Vikuu (Features)

### 1. Mfumo wa Ruhusa (Permission System)
- **Super Admin** - Ana ruhusa zote
- **Admin** - Ana ruhusa nyingi za kusimamia
- **Muuzaji (Vendor)** - Anaweza kuongeza na kusimamia bidhaa zake
- **Mteja (Customer)** - Anaweza kununua bidhaa

### 2. Aina za Ruhusa (Permission Types)

#### Usimamizi wa Watumiaji
- Tazama watumiaji
- Ongeza watumiaji
- Hariri watumiaji
- Futa watumiaji
- Simamia ruhusa

#### Usimamizi wa Bidhaa
- Tazama bidhaa
- Ongeza bidhaa
- Hariri bidhaa
- Futa bidhaa
- Thibitisha bidhaa

#### Usimamizi wa Maagizo
- Tazama maagizo
- Badilisha hali ya agizo
- Ghairi maagizo
- Rudisha pesa

#### Usimamizi wa Malipo
- Tazama malipo
- Chakata malipo
- Rudisha malipo

#### Ripoti
- Tazama ripoti
- Pakua ripoti

#### Mipangilio
- Simamia mipangilio
- Tazama kumbukumbu za mfumo

### 3. Kategoria za Bidhaa
- Mboga Mbichi
- Matunda
- Nafaka
- Nyama na Samaki
- Maziwa na Bidhaa Zake
- Vyakula Vilivyoandaliwa
- Vinywaji
- Mengineyo

## Muundo wa App

```
lib/
├── main.dart                          # Entry point
├── models/
│   ├── user_model.dart               # User & Permission models
│   ├── product_model.dart            # Product model
│   └── order_model.dart              # Order model
├── services/
│   └── auth_service.dart             # Authentication service
├── screens/
│   ├── splash_screen.dart            # Splash screen
│   ├── auth/
│   │   ├── login_screen.dart         # Login screen
│   │   └── register_screen.dart      # Registration screen
│   ├── admin/
│   │   ├── admin_dashboard.dart      # Admin dashboard
│   │   └── permissions_screen.dart   # Permissions management
│   ├── home/
│   │   └── home_screen.dart          # Customer home screen
│   └── products/
│       └── product_screens.dart      # Product related screens
```

## Jinsi ya Kuanzisha (Setup Instructions)

### Mahitaji (Requirements)
- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / VS Code
- Android Emulator au iOS Simulator

### Hatua za Kuanzisha

1. **Clone repository**
```bash
git clone <repository-url>
cd twende_markiti
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
flutter run
```

## Demo Credentials

### Admin Access
- **Email:** admin@twende.com
- **Password:** admin123
- **Ruhusa:** Zote (Super Admin)

### Vendor Access
- **Email:** vendor@twende.com
- **Password:** vendor123
- **Ruhusa:** Kusimamia bidhaa na maagizo

## Jinsi ya Kutumia

### Kwa Admin

1. **Ingia kwa akaunti ya admin**
2. **Fikia Admin Dashboard** - Utaona takwimu za jumla
3. **Simamia Ruhusa:**
   - Bonyeza "Simamia Ruhusa"
   - Chagua mtumiaji
   - Badilisha wadhifa wake
   - Ongeza au ondoa ruhusa

### Kwa Muuzaji (Vendor)

1. **Ingia kwa akaunti ya muuzaji**
2. **Ongeza bidhaa mpya**
3. **Simamia maagizo yako**

### Kwa Mteja (Customer)

1. **Jisajili au Ingia**
2. **Tazama bidhaa**
3. **Chagua kategoria**
4. **Ongeza kikap**
5. **Lipia na ulipwe**

## Maendeleo ya Baadaye (Future Enhancements)

### Backend Integration
- [ ] Unganisha na Firebase au custom backend
- [ ] Tuma na pokea data kutoka server
- [ ] Real-time updates kwa maagizo

### Payment Integration
- [ ] Integrate M-Pesa API
- [ ] Card payment support
- [ ] Payment history

### Push Notifications
- [ ] Arifa za maagizo mapya
- [ ] Arifa za bei
- [ ] Arifa za bidhaa mpya

### Advanced Features
- [ ] Chat system kati ya wateja na wauzaji
- [ ] Rating na reviews za bidhaa
- [ ] Wishlist
- [ ] Order tracking with maps
- [ ] Discount coupons
- [ ] Multi-language support (Kiswahili & English)

### Analytics
- [ ] Sales analytics
- [ ] User behavior tracking
- [ ] Revenue reports
- [ ] Inventory management

## Technology Stack

- **Framework:** Flutter
- **Language:** Dart
- **State Management:** (Can add Provider, Riverpod, or Bloc)
- **Backend:** (To be integrated - Firebase, Node.js, or Laravel)
- **Database:** (To be integrated - Firestore, MySQL, or PostgreSQL)
- **Payment:** (To be integrated - M-Pesa, Stripe)

## Mchango (Contributing)

Karibu kutoa mchango! Tafadhali fungua issue au tuma pull request.

## License

MIT License

## Mawasiliano (Contact)

Kwa maswali au msaada, wasiliana nasi:
- Email: support@twendemarkiti.co.tz
- Phone: +255 XXX XXX XXX

---

**Twende Markiti** - Nunua Bidhaa Online kwa Urahisi! 🛒
# markiti
