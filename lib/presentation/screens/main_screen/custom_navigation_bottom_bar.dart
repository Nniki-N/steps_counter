import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  onTap({required int index, required TabsRouter tabsRouter}) {
    tabsRouter.setActiveIndex(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomBottomNavigationBarItem(
            index: 0,
            itemText: 'Steps',
            iconData: Icons.account_box,
            onTap: onTap,
          ),
        ),
        Expanded(
          child: CustomBottomNavigationBarItem(
            index: 1,
            itemText: 'Achivements',
            iconData: Icons.abc,
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}

class CustomBottomNavigationBarItem extends StatelessWidget {
  final int index;
  final IconData iconData;
  final String itemText;
  final void Function({
    required int index,
    required TabsRouter tabsRouter,
  }) onTap;

  const CustomBottomNavigationBarItem({
    super.key,
    required this.iconData,
    required this.itemText,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final TabsRouter tabsRouter = AutoTabsRouter.of(context);
    final int activeIndex = tabsRouter.activeIndex;

    final Color color = index == activeIndex ? Colors.green : Colors.red;

    return GestureDetector(
      onTap: () {
        onTap(index: index, tabsRouter: tabsRouter);
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            size: 37,
            color: color,
          ),
          const SizedBox(height: 5),
          Text(
            itemText,
          )
        ],
      ),
    );
  }
}
