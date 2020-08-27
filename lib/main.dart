import 'package:flutter/material.dart';
import 'package:practice_app/providers/product_provider.dart';
import 'package:practice_app/screens/product_home_screen.dart';
import 'package:practice_app/screens/set_album_screen.dart';
import 'package:provider/provider.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './providers/cart_provider.dart';
import './screens/authentication_screen.dart';
import './screens/http_practice_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
        //create: (ctx) => ProductProvider(),
        value: ProductProvider(),),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        )
      ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: ProductHomeScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            AuthenticationScreen.routeName: (ctx) => AuthenticationScreen(),
            HttpPage.routeName: (ctx) => HttpPage(),
            SetAlbum.routeName: (ctx) => SetAlbum(),

          },
        ),
      );
  }
}



