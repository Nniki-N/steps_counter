import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AchivementsTabBar extends StatefulWidget {
  const AchivementsTabBar({super.key});

  @override
  State<AchivementsTabBar> createState() => _AchivementsTabBarState();
}

class _AchivementsTabBarState extends State<AchivementsTabBar> {
  onTap({required int index, required TabsRouter tabsRouter}) {
    tabsRouter.setActiveIndex(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(25),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConnectionsTabBarItem(
            index: 0,
            text: 'My achivements',
            onTap: onTap,
          ),
          const SizedBox(width: 20),
          ConnectionsTabBarItem(
            index: 1,
            text: 'All achivements',
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

class ConnectionsTabBarItem extends StatelessWidget {
  final int index;
  final String text;
  final void Function({
    required int index,
    required TabsRouter tabsRouter,
  }) onTap;

  const ConnectionsTabBarItem({
    super.key,
    required this.index,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final TabsRouter tabsRouter = AutoTabsRouter.of(context);
    final int activeIndex = tabsRouter.activeIndex;

    final Color color = index == activeIndex ? Colors.green : Colors.red;

    return GestureDetector(
      onTap: () {
        onTap(
          index: index,
          tabsRouter: tabsRouter,
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
        ),
      ),
    );
  }
}
