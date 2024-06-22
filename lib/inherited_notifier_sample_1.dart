import 'dart:math' as math;

import 'package:flutter/material.dart';

class InheritedNotifierSampleOne extends StatelessWidget {
  const InheritedNotifierSampleOne({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Inherited Notifier Sample'),
        ),
        body: const InheritedNotifierExample(),
      );
}

class ScrollModel extends InheritedNotifier<ScrollController> {
  const ScrollModel({
    required super.notifier,
    required super.child,
    super.key,
  });

  static double of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ScrollModel>()!.notifier!.offset;
  }
}

class Spinner extends StatelessWidget {
  const Spinner({required this.index, super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    final double offset = ScrollModel.of(context);
    final double normalizedOffset = (math.sin(offset / 300) + 1) / 2;
    final Color color = ColorTween(begin: Colors.green, end: Colors.blue).transform(
      normalizedOffset,
    )!;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: color,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(0, 1),
            blurRadius: 10,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Transform.rotate(
        angle: offset / (math.pi * 40) + index * 10,
        child: const SizedBox(
          height: 100,
          child: Center(
            child: Icon(
              Icons.rotate_90_degrees_cw_rounded,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}

class InheritedNotifierExample extends StatefulWidget {
  const InheritedNotifierExample({super.key});

  @override
  State<InheritedNotifierExample> createState() => _InheritedNotifierExampleState();
}

class _InheritedNotifierExampleState extends State<InheritedNotifierExample> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScrollModel(
        notifier: _scrollController,
        child: GridView.builder(
          controller: _scrollController,
          itemCount: 1000,
          itemBuilder: (context, index) => Spinner(
            key: ValueKey(index),
            index: index,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
        ),
      );
}
