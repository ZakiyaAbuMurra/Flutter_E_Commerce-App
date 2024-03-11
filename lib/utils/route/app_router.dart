import 'package:ecommrac_app/models/product_item_model.dart';
import 'package:ecommrac_app/utils/route/app_routes.dart';
import 'package:ecommrac_app/view_models/product_details_cubit/product_details_cubit.dart';
import 'package:ecommrac_app/views/pages/custom_bottom_navbar.dart';
import 'package:ecommrac_app/views/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouters {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.productDetails:
        final product = settings.arguments as ProductItemModel;

        // Smart Casting for the product item

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = ProductDetailsCubit();
              cubit.getProductDetails(product.id);
              return cubit;
            },
            child: const ProductDetailsPage(),
          ),
          settings: settings,
        );
      case AppRoutes.bottomNavbar:
        return MaterialPageRoute(
          builder: (_) => const CustomButtonNavBar(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Error Page ! ')),
          ),
        );
    }
  }
}
