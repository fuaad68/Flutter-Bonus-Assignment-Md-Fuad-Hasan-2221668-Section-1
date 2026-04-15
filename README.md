# flutter_ui_class

## Firebase Assignment Setup

### 1. Firebase Setup
1. Create a Firebase project from the Firebase Console.
2. Enable Cloud Firestore in test mode.
3. Add your Android app in Firebase and download `google-services.json` into `android/app/`.
4. Add your iOS app in Firebase and download `GoogleService-Info.plist` into `ios/Runner/`.
5. Run `flutterfire configure` from this project root to generate `lib/firebase_options.dart`.

### 2. Firestore Rules
Use the rule file `firestore.rules` and publish from Firebase Console or Firebase CLI:

```txt
allow read, write: if true;
```

### 3. Implemented Features
- Add new task to Firestore
- Delete task from Firestore
- Real-time task list using StreamBuilder + Firestore snapshots

### 4. Task Data Model
The app uses a Task model with:
- `id`
- `title`
- `description`
- `createdAt` (optional)

