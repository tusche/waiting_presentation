import 'package:flutter/material.dart';
import 'package:waiting_presentation/scene_presentation.dart';
import 'package:waiting/scene/scene_controller.dart';

enum Slides {
  intro,
  introPleaseWait,
  relativityAlbertGirl,
  relativityAlbertStove,
  waiting_2,
  hardware
}

void main() {
  runApp(const PresentationApp());
}

class PresentationApp extends StatefulWidget {
  const PresentationApp({super.key});

  @override
  State<StatefulWidget> createState() => PresentationAppState();
}

class PresentationAppState extends State<PresentationApp>
    with TickerProviderStateMixin {
  final _hueCycleDuration = const Duration(minutes: 30);

  final double _indicatorDimensionFactor = 2;

  late AnimationController _hueAnimationController;

  late MaterialColor _themeColor = Colors.red;

  late SceneController _sceneController;

  @override
  void initState() {
    super.initState();

    _hueAnimationController =
        AnimationController(vsync: this, duration: _hueCycleDuration)
          ..addListener(() {
            setState(() {
              var value = _hueAnimationController.value;
              var color = adjustHue(Colors.red, value);
              _themeColor = getMaterialColor(color);
            });
          })
          ..repeat();

    _sceneController = SceneController(this, Slides.values);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: _themeColor),
          fontFamily: "Abel",
          useMaterial3: true),
      home: Scaffold(
        body: Center(
            child: Stack(
          children: [
            SlideLottieIndicatorWidget(
                sceneController: _sceneController,
                scenes: value(Slides.intro),
                title: null,
                width: 240 * _indicatorDimensionFactor,
                height: 240 * _indicatorDimensionFactor,
                name: "assets/presentation/lottie/waiting_vanilla.json"),
            SlideLottieIndicatorWidget(
                sceneController: _sceneController,
                scenes: value(Slides.introPleaseWait),
                title: "please wait...",
                width: 240 * _indicatorDimensionFactor,
                height: 240 * _indicatorDimensionFactor,
                name: "assets/presentation/lottie/waiting_vanilla.json"),
            SlideImageWidget(
                scenes: value(Slides.relativityAlbertGirl),
                sceneController: _sceneController,
                title: "relativity",
                name: "assets/presentation/images/albert_girl.png"),
            SlideImageWidget(
                scenes: value(Slides.relativityAlbertStove),
                sceneController: _sceneController,
                title: "relativity",
                name: "assets/presentation/images/albert_stove.png"),
            SlideLottieIndicatorWidget(
                sceneController: _sceneController,
                scenes: value(Slides.waiting_2),
                title: "relativity",
                width: 240 * _indicatorDimensionFactor,
                height: 240 * _indicatorDimensionFactor,
                name: "assets/presentation/lottie/waiting_infinite.json"),
            SlideImageWidget(
                scenes: value(Slides.hardware),
                sceneController: _sceneController,
                title: null,
                name: "assets/presentation/images/hardware.png"),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: _nextSlide,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Color adjustHue(Color baseColor, double value) {
    assert(value >= 0 && value <= 1, 'Value must be between 0 and 1');
    HSVColor hsvColor = HSVColor.fromColor(baseColor);
    double newHue = (hsvColor.hue + value * 360) % 360;
    HSVColor newHsvColor = hsvColor.withHue(newHue);
    return newHsvColor.toColor();
  }

  MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;
    final int alpha = color.alpha;

    final Map<int, Color> shades = {
      50: Color.fromARGB(alpha, red, green, blue),
      100: Color.fromARGB(alpha, red, green, blue),
      200: Color.fromARGB(alpha, red, green, blue),
      300: Color.fromARGB(alpha, red, green, blue),
      400: Color.fromARGB(alpha, red, green, blue),
      500: Color.fromARGB(alpha, red, green, blue),
      600: Color.fromARGB(alpha, red, green, blue),
      700: Color.fromARGB(alpha, red, green, blue),
      800: Color.fromARGB(alpha, red, green, blue),
      900: Color.fromARGB(alpha, red, green, blue),
    };

    return MaterialColor(color.value, shades);
  }

  void _nextSlide() {
    setState(() {
      _sceneController.schedule(_sceneController.forward());
    });
  }
}
