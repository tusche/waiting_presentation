import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:waiting/scene/scene_blur.dart';
import 'package:waiting/scene/scene_controller.dart';
import 'package:waiting/scene/scene_fade.dart';
import 'package:waiting/waiting.dart';

class SlideWidget extends StatelessWidget {
  final SceneController sceneController;

  final bool Function(dynamic) scenes;

  final String? title;

  final Widget content;

  final Duration enterDuration;

  final Duration exitDuration;

  const SlideWidget(
      {super.key,
      required this.sceneController,
      required this.scenes,
      required this.title,
      required this.content,
      this.enterDuration = const Duration(milliseconds: 2000),
      this.exitDuration = const Duration(milliseconds: 2000)});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
          child: SlideContentSceneWidget(
              sceneController: sceneController,
              scenes: scenes,
              child: content)),
      title != null
          ? FadeSceneWidget(
              controller: sceneController,
              scenes: scenes,
              opacity: (AnimationController animationController) {
                return Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(CurvedAnimation(
                  parent: animationController,
                  curve: Curves.easeInOut, // Apply curve here
                ));
              },
              enterDuration: enterDuration,
              exitDuration: exitDuration,
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(title!,
                          style: TextStyle(
                              fontSize: 64,
                              color: Theme.of(context).primaryColor)))),
            )
          : Container(width: 0, height: 0)
    ]);
  }
}

class SlideContentSceneWidget extends StatelessWidget {
  final SceneController _sceneController;

  final bool Function(dynamic) _scenes;

  final Duration _enterExitDuration = const Duration(milliseconds: 2000);

  final Widget _child;

  const SlideContentSceneWidget({
    super.key,
    required SceneController sceneController,
    required bool Function(dynamic) scenes,
    required Widget child,
  })  : _scenes = scenes,
        _sceneController = sceneController,
        _child = child;

  @override
  Widget build(BuildContext context) {
    return FadeSceneWidget(
        scenes: _scenes,
        controller: _sceneController,
        enterDuration: _enterExitDuration,
        exitDuration: const Duration(milliseconds: 2000),
        opacity: (AnimationController animationController) {
          return Tween<double>(
            begin: 0,
            end: 1,
          ).animate(CurvedAnimation(
            parent: animationController,
            curve: Curves.easeInOut, // Apply curve here
          ));
        },
        child: BlurSceneWidget(
          scenes: _scenes,
          controller: _sceneController,
          enterDuration: _enterExitDuration,
          exitDuration: const Duration(milliseconds: 2000),
          sigma: (AnimationController animationController) {
            return Tween<double>(
              begin: 10,
              end: 0,
            ).animate(CurvedAnimation(
              parent: animationController,
              curve: Curves.easeInOut, // Apply curve here
            ));
          },
          child: _child,
        ));
  }
}

class SlideLottieIndicatorWidget extends StatefulWidget {
  final bool Function(dynamic) scenes;
  final SceneController sceneController;
  final String? title;
  final String name;
  final double width;
  final double height;

  const SlideLottieIndicatorWidget({
    super.key,
    required this.scenes,
    required this.sceneController,
    required this.title,
    required this.name,
    this.width = 128,
    this.height = 128,
  });

  @override
  State<StatefulWidget> createState() => SlideLottieIndicatorWidgetState();
}

class SlideLottieIndicatorWidgetState extends State<SlideLottieIndicatorWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideWidget(
      sceneController: widget.sceneController,
      scenes: widget.scenes,
      title: widget.title,
      content: Container(
          width: widget.width,
          height: widget.height,
          child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor,
                BlendMode.srcATop,
              ),
              child: Lottie.asset(widget.name))),
    );
  }
}

class SlideImageWidget extends StatelessWidget {
  const SlideImageWidget({
    super.key,
    required this.scenes,
    required this.sceneController,
    required this.title,
    required this.name,
  });

  final bool Function(dynamic) scenes;
  final SceneController sceneController;
  final String? title;
  final String name;

  @override
  Widget build(BuildContext context) {
    return SlideWidget(
        sceneController: sceneController,
        scenes: scenes,
        title: title,
        content: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Theme.of(context).primaryColorDark.withOpacity(0.2),
                  BlendMode.color),
              child: SizedBox.fromSize(
                size: const Size.fromRadius(300),
                child: Image.asset(name, fit: BoxFit.cover),
              )),
        ));
  }
}

class SlideTextWidget extends StatelessWidget {
  const SlideTextWidget({
    super.key,
    required this.scenes,
    required this.sceneController,
    required this.text,
    this.size = 96
  });

  final bool Function(dynamic) scenes;
  final SceneController sceneController;
  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SlideWidget(
        sceneController: sceneController,
        scenes: scenes,
        title: null,
        content: Text(
          text!,
          style:
              TextStyle(fontSize: size, color: Theme.of(context).primaryColor),
        ));
  }
}



class SlideScrimWidget extends StatelessWidget {
  const SlideScrimWidget({
    super.key,
    required this.scenes,
    required this.controller,
    required this.child,
  });

  final bool Function(dynamic) scenes;
  final SceneController controller;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FadeSceneWidget(
      controller: controller,
      scenes: scenes,
      opacity: (AnimationController animationController) {
        return Tween<double>(
          begin: 1.0,
          end: 0.33,
        ).animate(CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut, // Apply curve here
        ));
      },
      enterDuration: const Duration(milliseconds: 200),
      exitDuration: const Duration(milliseconds: 200),
      child: child,
    );
  }
}

class SlideProgressWidget extends StatelessWidget {
  const SlideProgressWidget(
      {super.key,
        required this.scenes,
        required this.controller,
        this.indicator = const DefaultIndicator()});

  final bool Function(dynamic) scenes;

  final SceneController controller;

  final Widget indicator;

  @override
  Widget build(BuildContext context) {
    return FadeSceneWidget(
      controller: controller,
      scenes: scenes,
      opacity: (AnimationController animationController) {
        return Tween<double>(
          begin: 0,
          end: 1,
        ).animate(CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut, // Apply curve here
        ));
      },
      enterDuration: const Duration(milliseconds: 400),
      exitDuration: const Duration(milliseconds: 200),
      child: indicator,
    );
  }
}

class SlideTimeoutWidget extends StatelessWidget {
  const SlideTimeoutWidget(
      {super.key,
        required this.scenes,
        required this.controller,
        this.indicator = const DefaultTimeoutIndicator()});

  final bool Function(dynamic) scenes;

  final SceneController controller;

  final Widget indicator;

  @override
  Widget build(BuildContext context) {
    return FadeSceneWidget(
      controller: controller,
      scenes: scenes,
      opacity: (AnimationController animationController) {
        return Tween<double>(
          begin: 0,
          end: 1,
        ).animate(CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut, // Apply curve here
        ));
      },
      enterDuration: const Duration(milliseconds: 400),
      exitDuration: const Duration(milliseconds: 200),
      child: indicator,
    );
  }
}
