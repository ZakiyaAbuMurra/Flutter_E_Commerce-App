import 'package:ecommrac_app/views/widgets/categories_tab_view.dart';
import 'package:ecommrac_app/views/widgets/home_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // The number of tabs in the tab bar.
      child: Column(
        children: [
          TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Home',
              ),
              Tab(text: 'Categories'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                HomeTabView(),
                CategoriesTabView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
