📋 Project Overview
This Flutter application was developed as part of a technical interview assessment to demonstrate proficiency in Flutter development, clean architecture, and state management.

✅ Task Requirements Fulfilled
🎯 Core Requirements Implemented
API Integration
✅ API Endpoint: https://randomuser.me/api/?results=20

✅ Data Fields Used:

name.first + name.last → Full name

picture.large → Profile images

dob.age → User age

location.city → User location

location.country → Country filtering

Home Screen ✅
✅ Grid Layout: 2-column scrollable grid displaying user profiles

✅ User Cards: Each card shows:

Profile picture

User name (first + last)

Age

Location (city)

Heart (like) icon

✅ Vertical Scroll: Infinite scrolling through user list

✅ Loading State: Circular progress indicator during API calls

✅ Error State: Error message with retry button for failed API calls

Profile Detail Screen ✅
✅ Navigation: Tap on user image in home screen

✅ Large Image Display: Full-screen profile image

✅ User Information: Name, age, location displayed

✅ Like Toggle: Heart icon for like/dislike functionality

✅ State Synchronization: Like status syncs between home and detail screens

Architecture ✅
✅ Clean Architecture: Proper separation into Data, Domain, Presentation layers

✅ MVVM Pattern: Using Provider as state management solution

✅ Code Organization:

data/ - API models, repositories, data sources

domain/ - Entities, repositories interfaces, use cases

presentation/ - UI screens, widgets, providers (ViewModels)

🏆 Bonus Features Implemented
✅ Heart Icon Animation: Scale animation when liking/unliking

✅ Hero Transition: Smooth image transition between screens

✅ Filters by Country: Dynamic country filter in app bar

✅ Pull-to-Refresh: Refresh functionality with RefreshIndicator

✅ Responsive Layout: Works on various screen sizes and orientations

🏗️ Architecture Implementation
Clean Architecture Structure
text
lib/
├── data/
│   ├── models/user_model.dart          # API response models
│   ├── repositories/user_repository_impl.dart # Repository implementation
│   └── sources/remote_data_source.dart # API communication
├── domain/
│   ├── entities/user.dart              # Business entities
│   ├── repositories/user_repository.dart # Repository contracts
│   └── usecases/get_users_usecase.dart # Business logic
└── presentation/
├── providers/user_provider.dart    # ViewModel (State Management)
├── screens/                        # UI Screens
└── widgets/                        # Reusable Components
State Management with Provider
dart
class UserProvider with ChangeNotifier {
// State
List<User> _users = [];
bool _isLoading = false;
String _error = '';
String _selectedCountry = 'All';

// Business Logic
Future<void> fetchUsers() async { ... }
void toggleLike(String userId) { ... }
void setSelectedCountry(String country) { ... }

// State Synchronization
void notifyListeners(); // Updates UI across all screens
}
🚀 Key Features Demonstrated
1. API Integration & Data Handling
   Efficient API call handling with error management

JSON parsing and model mapping

Loading states during data fetch

2. State Synchronization
   Like status persists across screens using Provider

Real-time UI updates with notifyListeners()

Consistent state management

3. UI/UX Excellence
   Modern, responsive design matching Figma specifications

Smooth animations (Hero transitions, like animations)

Intuitive user interactions

4. Code Quality
   Clean, maintainable code structure

Proper separation of concerns

Reusable components

Error handling and edge cases

📱 App Flow
Launch → HomeScreen loads with loading indicator

Data Fetch → API call to RandomUser.me

Display → Grid of user profiles

Interact →

Tap heart to like/unlike

Tap profile to view details

Pull down to refresh

Filter by country

Navigate → Smooth transition to profile details

State Sync → Like status consistent across screens

🔧 Technical Highlights
Provider State Management
dart
Consumer<UserProvider>(
builder: (context, userProvider, child) {
// Automatic UI updates when state changes
return GridView.builder(...);
},
)
Hero Animations
dart
Hero(
tag: 'user_image_${user.id}',
child: Image.network(user.picture),
)
Pull-to-Refresh
dart
RefreshIndicator(
onRefresh: () async {
await userProvider.refreshUsers();
},
child: GridView.builder(...),
)
📦 Deliverables Completed
✅ Full Source Code: Complete Flutter application

✅ GitHub Repository: Well-documented code repository

✅ Platform Support: Runs on both Android and iOS

✅ Architecture Compliance: Clean Architecture with MVVM

✅ State Management: Provider implementation

✅ Design Compliance: Matches provided Figma design

🎯 Skills Demonstrated
Flutter Development: Widget composition, navigation, animations

State Management: Provider pattern, state synchronization

API Integration: HTTP requests, JSON parsing, error handling

Clean Architecture: Separation of concerns, testability

UI/UX Design: Responsive layouts, smooth animations

Problem Solving: Requirements implementation, edge cases

📄 Project Verification
All task requirements have been successfully implemented:

✅ Mandatory Features: 100% completed

✅ Architecture Guidelines: Fully followed

✅ Bonus Features: All implemented

✅ Code Quality: Clean, maintainable, well-structured

✅ Functionality: Fully working app on Android/iOS

This project demonstrates strong Flutter development skills and the ability to follow complex technical requirements while delivering a polished, production-ready application.

Developer: [AKASH SINGH ANAND]
Position: Flutter Developer
Submission Date: [19-Oct-2025]
Status: ✅ All Requirements Completed