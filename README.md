# textapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

#   R e a l T i m e - T a l k e r 
 
 

1.go to android folder > app > build.gradle 
    - compileSdkVersion 33
    - minSdkVersion 21
    - targetSdkVersion 28
2. go to android/app/src/main/AndroidManifest.xml to add permission
    - add these permissons
    <p>"android.permission.RECORD_AUDIO"
    "android.permission.INTERNET"
    "android.permission.BLUETOOTH"
   "android.permission.BLUETOOTH_ADMIN"
 "android.permission.BLUETOOTH_CONNECT"

 <p>
     <queries>
        <intent>
            <action android:name="android.speech.RecognitionService" />
        </intent>
    </queries>
 </p>

   
