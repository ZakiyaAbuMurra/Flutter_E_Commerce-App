import 'package:ecommrac_app/services/auth_services.dart';
import 'package:ecommrac_app/services/firestore_services.dart';
import 'package:ecommrac_app/utils/app_assets.dart';
import 'package:ecommrac_app/utils/app_colors.dart';
import 'package:ecommrac_app/view_models/profile_cubit/profile_cubit.dart';
import 'package:ecommrac_app/views/pages/cart_page.dart';
import 'package:ecommrac_app/views/pages/favorites_page.dart';
import 'package:ecommrac_app/views/pages/home_page.dart';
import 'package:ecommrac_app/views/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  late PersistentTabController _controller;
  final FirestoreService _firestoreService = FirestoreService.instance;
  // final firebaseAuth = FirebaseAuth.instance;
  final userUid = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
    //  sendDummyData();
  }

  //To send the dummy data to Firestore, as it takes less time to create the database manually from scratch.
  // Future<void> sendDummyData() async {
  //   dummyProducts.forEach((product) async {
  //     await _firestoreService.setData(
  //       path: ApiPaths.product(product.id),
  //       data: product.toMap(),
  //     );
  //   });
  // }

  //To send the dummy data to Firestore, as it takes less time to create the database manually from scratch.
  // Future<void> sendDummyData() async {
  //   dummyAnnouncements.forEach((ann) async {
  //     await _firestoreService.setData(
  //       path: ApiPaths.announcement(ann.id),
  //       data: ann.toMap(),
  //     );
  //   });
  // }

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      FavoritesPage(),
      const CartPage(),
      const ProfilePage(), // Include the ProfilePage here wrapped with BlocProvider
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
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(AppAssets.userImage),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, Zakiya',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              'Let\'s go shopping!',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: AppColors.grey,
                  ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        stateManagement: false,
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
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
