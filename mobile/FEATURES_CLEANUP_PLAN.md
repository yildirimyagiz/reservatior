# 🗂️ Features Directory Cleanup Plan

## 📊 Current Issues
- **19 nearly-empty folders** with 1-3 files each
- **Duplicate functionality** (ai_chat vs ai_generation, social vs social_feed)
- **Poor organization** - entities scattered across folders
- **Missing clean architecture** structure

## 🎯 Proposed New Structure

### **Core Features (Keep & Enhance)**
```
features/
├── auth/                    # Authentication (8 files) ✅
├── agency/                  # Agency management (5 files) ✅
├── agents/                  # Agent performance (3 files) ✅
├── analytics/               # Business analytics (4 files) ✅
├── ai/                      # Consolidated AI features
│   ├── generation/          # AI video generation
│   ├── chat/               # AI chat functionality
│   └── listing/            # AI listing assistance
├── video/                   # Consolidated video features
│   ├── editor/             # Video editing (16 files)
│   ├── capture/            # Video capture (4 files)
│   └── player/             # Video playback
├── social/                  # Consolidated social features
│   ├── feed/               # Social feed (6 files)
│   └── sharing/            # Social sharing
├── messaging/               # Messaging system (5 files) ✅
├── notifications/           # Notifications (1 file) ✅
├── referral/               # Referral system (5 files) ✅
├── reservation/             # Reservations (7 files) ✅
└── home/                    # Home/dashboard (9 files) ✅
```

### **Property Management (Consolidate)**
```
features/
├── property/                # Consolidated property features
│   ├── listings/           # Property listings
│   ├── details/            # Property details
│   ├── search/             # Property search
│   ├── facilities/         # Property facilities
│   └── management/         # Property management
```

### **Business Operations (Consolidate)**
```
features/
├── business/                # Consolidated business features
│   ├── dashboard/          # Business dashboard
│   ├── analytics/          # Business analytics
│   ├── reports/            # Business reports
│   ├── finance/            # Financial operations
│   │   ├── expenses/       # Expense tracking
│   │   ├── payments/       # Payment processing
│   │   └── commissions/    # Commission tracking
│   ├── contracts/          # Contract management
│   └── mls/                # MLS integration
```

### **User Management (Consolidate)**
```
features/
├── user/                    # Consolidated user features
│   ├── profile/            # User profiles
│   ├── settings/           # User settings
│   ├── roles/              # User roles & permissions
│   ├── tasks/              # User tasks
│   └── communication/     # User communication
```

### **Platform Features (Consolidate)**
```
features/
├── platform/               # Platform-level features
│   ├── membership/         # Membership system
│   ├── packages/           # Service packages
│   ├── localization/       # Internationalization
│   ├── government/         # Government integrations
│   └── support/            # Customer support
```

## 🔄 Migration Actions

### **Phase 1: Remove Empty/Redundant Folders**
- Delete folders with only 1 entity file
- Move entity files to shared/models/
- Consolidate duplicate functionality

### **Phase 2: Create New Structure**
- Create consolidated folders
- Move existing files to new locations
- Update imports and navigation

### **Phase 3: Clean Architecture**
- Add proper data/domain/presentation layers
- Create proper repository patterns
- Update providers and services

## 📁 Files to Move

### **Entity Files → shared/models/**
- expense_entity.dart
- government_entity.dart
- role_entity.dart
- mls_entity.dart
- social_entity.dart
- package_entity.dart
- communication_entity.dart
- facility_entity.dart (move to property/)
- localization_entity.dart
- membership_entity.dart

### **Screen Files → Proper Features**
- settings_screen.dart → user/settings/
- expense_screen.dart → business/finance/expenses/
- task_screens.dart → user/tasks/
- contract_screen.dart → business/contracts/
- listing_screens.dart → property/listings/
- mls_screen.dart → business/mls/
- dashboard_screen.dart → business/dashboard/
- notifications_screen.dart → notifications/
- reports_screen.dart → business/reports/

## 🎯 Expected Results
- **From 33 folders to 12 folders** (63% reduction)
- **Proper clean architecture** structure
- **Eliminated duplicates** and redundancy
- **Clear separation of concerns**
- **Easier maintenance** and development

## ⚡ Quick Wins
1. Remove 19 nearly-empty folders
2. Consolidate AI features (ai_chat + ai_generation + ai_listing)
3. Consolidate video features (video_editor + video_capture)
4. Move all entity files to shared/models/
5. Create proper business/property/user structure
