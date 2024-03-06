import 'package:ecommrac_app/utils/app_assets.dart';
import 'package:ecommrac_app/utils/app_colors.dart';
import 'package:ecommrac_app/views/pages/cart_page.dart';
import 'package:ecommrac_app/views/pages/favorites_page.dart';
import 'package:ecommrac_app/views/pages/home_page.dart';
import 'package:ecommrac_app/views/pages/profile_page.dart';
import 'package:ecommrac_app/views/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class CustomButtonNavBar extends StatefulWidget {
  const CustomButtonNavBar({super.key});

  @override
  State<CustomButtonNavBar> createState() => _CustomButtonNavBarState();
}

class _CustomButtonNavBarState extends State<CustomButtonNavBar> {
  late PersistentTabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PersistentTabController();
  }

  List<Widget> _buildScreens() {
    return const [
      HomePage(),
      FavoritesPage(),
      CartPage(),
      ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        inactiveIcon: const Icon(Icons.home_outlined),
        icon: const Icon(Icons.home_filled),
        title: "Home",
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.grey,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: const Icon(Icons.favorite_border),
        icon: const Icon(Icons.favorite),
        title: "Favorites",
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.grey,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: const Icon(Icons.shopping_cart_outlined),
        icon: const Icon(Icons.shopping_cart),
        title: "Cart",
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.grey,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: const Icon(Icons.person_outline),
        icon: const Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(5.0),
          child: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(AppAssets.userImage),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi , Zakiya',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text('Lets go shopping !',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColors.grey,
                    )),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons
                .search), // Replace with your search icon if it's different

            onPressed: () {
              // Using Navigator to push a new route
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    SearchPage(), // The page you want to navigate to
              ));
            },
          ),
        ],
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.c
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style3, // Choose the nav bar style with this property.
      ),
    );
  }
}
