import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waiting/scene/scene_controller.dart';
import 'package:waiting/waiting.dart';
import 'package:waiting_presentation/scene_presentation.dart';

enum Slides {
  intro,
  introPleaseWait,
  introCinema,
  introAlbertGirl,
  introAlbertStove,
  title,
  patience,
  standards,
  now,
  nowEye,
  nowHardware,
  inAMoment,
  inAMomentInternet,
  inAMomentInfinity,
  later,
  laterRoleplaying,
  laterPong,
  inTime,
  inTimeIndicator,
  summary,
  widgetContent,
  widgetScrim,
  widgetProgress,
  widgetTimeout,
  waitingContent,
  waiting,
  qr,
  acquiredPatience,
  thanks,
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

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var colorScheme = ColorScheme.fromSeed(seedColor: _themeColor)
        .copyWith(background: const Color(0xFFDDDDDD));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: colorScheme, fontFamily: "Abel", useMaterial3: true),
        home: Scaffold(
          body: KeyboardListener(
            focusNode: _focusNode,
            autofocus: true,
            onKeyEvent: _onKeyEvent,
            child: Stack(children: [
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
                  scenes: value(Slides.introCinema),
                  sceneController: _sceneController,
                  title: "please wait...",
                  name: "assets/presentation/images/cinema.png"),
              SlideImageWidget(
                  scenes: value(Slides.introAlbertGirl),
                  sceneController: _sceneController,
                  title: "please wait...",
                  name: "assets/presentation/images/albert_girl.png"),
              SlideImageWidget(
                  scenes: value(Slides.introAlbertStove),
                  sceneController: _sceneController,
                  title: "please wait...",
                  name: "assets/presentation/images/albert_stove.png"),
              SlideTextWidget(
                scenes: value(Slides.title),
                sceneController: _sceneController,
                text: "the perception of time\nin user interfaces",
              ),
              SlideImageWidget(
                  scenes: value(Slides.patience),
                  sceneController: _sceneController,
                  title: "patience",
                  name: "assets/presentation/images/patience.png"),
              SlideImageWidget(
                  scenes: value(Slides.standards),
                  sceneController: _sceneController,
                  title: "standards",
                  name: "assets/presentation/images/standarts.png"),
              SlideTextWidget(
                scenes: value(Slides.now),
                sceneController: _sceneController,
                text: "now",
              ),
              SlideImageWidget(
                  scenes: value(Slides.nowEye),
                  sceneController: _sceneController,
                  title: "now",
                  name: "assets/presentation/images/eye.png"),
              SlideImageWidget(
                  scenes: value(Slides.nowHardware),
                  sceneController: _sceneController,
                  title: "now",
                  name: "assets/presentation/images/hardware.png"),
              SlideTextWidget(
                scenes: value(Slides.inAMoment),
                sceneController: _sceneController,
                text: "in a moment",
              ),
              SlideImageWidget(
                  scenes: value(Slides.inAMomentInternet),
                  sceneController: _sceneController,
                  title: "in a moment",
                  name: "assets/presentation/images/internet.png"),
              SlideLottieIndicatorWidget(
                  sceneController: _sceneController,
                  scenes: value(Slides.inAMomentInfinity),
                  title: "in a moment",
                  width: 240 * _indicatorDimensionFactor,
                  height: 240 * _indicatorDimensionFactor,
                  name: "assets/presentation/lottie/waiting_infinite.json"),
              SlideTextWidget(
                scenes: value(Slides.later),
                sceneController: _sceneController,
                text: "later",
              ),
              SlideImageWidget(
                  scenes: value(Slides.laterRoleplaying),
                  sceneController: _sceneController,
                  title: "later",
                  name: "assets/presentation/images/roleplaying.jpg"),
              SlideImageWidget(
                  scenes: value(Slides.laterPong),
                  sceneController: _sceneController,
                  title: "later",
                  name: "assets/presentation/images/pong.jpeg"),
              SlideTextWidget(
                scenes: value(Slides.inTime),
                sceneController: _sceneController,
                text: "in time",
              ),
              SlideWidget(
                scenes: value(Slides.inTimeIndicator),
                sceneController: _sceneController,
                title: "in time",
                content: Center(
                    child: SizedBox(
                  width: 400,
                  height: 36,
                  child: LinearProgressIndicator(value: 0.5),
                )),
              ),
              SlideTextWidget(
                scenes: value(Slides.summary),
                sceneController: _sceneController,
                size: 72,
                text: "now: 0 - 50ms\nin a moment: 50ms - 10s\nlater: 10s - ∞",
              ),
              SlideContentSceneWidget(
                  sceneController: _sceneController,
                  scenes: values([
                    Slides.widgetContent,
                    Slides.widgetScrim,
                    Slides.widgetProgress,
                    Slides.widgetTimeout
                  ]),
                  child: Stack(
                    children: [
                      SlideScrimWidget(
                          controller: _sceneController,
                          scenes: values([
                            Slides.widgetScrim,
                            Slides.widgetProgress,
                            Slides.widgetTimeout
                          ]),
                          child: Content()),
                      SlideProgressWidget(
                        controller: _sceneController,
                        scenes: value(Slides.widgetProgress),
                      ),
                      SlideTimeoutWidget(
                        scenes: value(Slides.widgetTimeout),
                        controller: _sceneController,
                        indicator: const TimeoutContent(),
                      )
                    ],
                  )),
              SlideContentSceneWidget(
                  sceneController: _sceneController,
                  scenes: values([
                    Slides.waitingContent,
                    Slides.waiting,
                  ]),
                  child: WaitingWidget(
                      show: _sceneController.getScene() == Slides.waiting,
                      timeout: const Duration(seconds: 5),
                      timeoutIndicator: const TimeoutContent(),
                      child: const Content())),
              SlideImageWidget(
                  scenes: value(Slides.qr),
                  sceneController: _sceneController,
                  title: "pub.dev/packages/waiting",
                  name: "assets/presentation/images/qr.png"),
              SlideTextWidget(
                scenes: value(Slides.acquiredPatience),
                sceneController: _sceneController,
                text: "acquired patience",
              ),
              SlideTextWidget(
                scenes: value(Slides.thanks),
                sceneController: _sceneController,
                text: "thank you",
              ),
            ]),
          ),
        ));
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

  void _onKeyEvent(event) {
    if (event! is KeyUpEvent) {
      return;
    }
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        _back();
        break;
      case LogicalKeyboardKey.arrowRight:
        _forward();
        break;
    }
  }

  void _back() {
    setState(() {
      var back = _sceneController.back();
      if (back != null) {
        _sceneController.schedule(back);
      }
    });
  }

  void _forward() {
    setState(() {
      var forward = _sceneController.forward();
      if (forward != null) {
        _sceneController.schedule(forward);
      }
    });
  }
}

class TimeoutContent extends StatelessWidget {
  const TimeoutContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("please wait...",
          style:
              TextStyle(fontSize: 32, color: Theme.of(context).primaryColor)),
      SizedBox(
          width: 150,
          child: const Opacity(opacity: 0.7, child: LinearProgressIndicator())),
    ]));
  }
}

class Content extends StatelessWidget {
  const Content({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(width: 300, height: 300, child: FlutterLogo()));
  }
}
