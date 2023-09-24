## When integrating this service into the project, you can use the following code segments to call the service.

### **Add dependencies to 'pubspec.yaml'**

       dependencies:
            flutter:
                sdk: flutter
            provider: ^6.0.1
            flutter_tts: ^3.3.0
make sure after adding those, run `flutter run` to install the dependencies.

### **[project name]/app/build.gradle**

    make minSdkVersion 21 or above;

### **main.dart**

    runApp(
        const ChangeNotifierProvider(
            create: (context) => TextToVoiceModel(),
            child: const TextToVoiceScreen(),
        )
    );

### **How to call the service**  (if needed)

    TextToVoiceModel textToVoiceModel = Provider.of<TextToVoiceModel>(context);
    textToVoiceModel.textToVoice( enter the text you want to convert );
