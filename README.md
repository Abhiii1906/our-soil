# e_shop

E-Shop website.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


lib/
│
├── core/                     # Global utilities & config
│   ├── config/               # Routes, themes, constants
│   ├── services/             # Notifications, storage, etc.
│   ├── network/              # API base client, interceptors
│   ├── utils/                # Helpers
│   ├── widgets/              # Reusable UI widgets
│
├── common/                   # Shared between features or roles
│   ├── models/               # Common models (User, Error, etc.)
│   ├── repositories/         # Common data logic
│   ├── bloc/                 # Global/shared blocs or cubits
│   ├── screens/              # Shared screens (splash, onboarding, etc.)
│
├── features/                 
│   ├── authentication/       # Login, registration, etc.
│   │   ├── bloc/
│   │   ├── screens/
│   │   ├── repository/
│   │   ├── model/
│
│   ├── vendor/               # Vendor-specific features
│   │   ├── dashboard/
│   │       ├── bloc/
│   │       ├── screens/
│   │       ├── repository/
│   │       ├── model/
│  
│   ├── fieldworker/          # Fieldworker-specific features
│   │   ├── Plantation/
│   │       ├── bloc/
│   │       ├── screens/
│   │       ├── repository/
│   │       ├── model/
│
│   │ 
│   ├── customer/             # Both B2B & Retail under customer
│   │   ├── b2b/
│   │   │   ├── orders/
│   │   │   ├── analytics/
│   │   ├── retail/
│   │   │   ├── tree_browser/
│   │   │   ├── purchase/
│
│   ├── home/                 # Common Home screen logic
│   ├── profile/              # Profile for all users
│
├── main.dart
