import 'package:flutter/material.dart';
import 'package:list_of_products/app/data/gateway/product_gateway.dart';
import 'package:list_of_products/app/data/gateway/user_gateway.dart';
import 'package:list_of_products/app/data/repository/product_repository_impl.dart';
import 'package:list_of_products/app/data/repository/user_repository_impl.dart';
import 'package:list_of_products/app/domain/services/product_service.dart';
import 'package:list_of_products/app/domain/services/user_service.dart';
import 'package:list_of_products/app/presentations/screens/edit_products/edit_products_controller.dart';
import 'package:list_of_products/app/presentations/screens/home/home_controller.dart';
import 'package:list_of_products/app/presentations/screens/login/login_controller.dart';
import 'package:list_of_products/app/presentations/screens/login/login_screen.dart';
import 'package:list_of_products/app/presentations/screens/register_products/register_products_controller.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:provider/provider.dart';

import 'app/presentations/screens/register_user/register_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = '3cl6GepH7y7GF6nEg72FTMgiuvzVdERlHNt8gbtQ';
  const keyClientKey = 'e1gvu2rN7cWEoLMwD8V9HnjwKDaIU5JxamccpuWw';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => UserGatewayImpl()),
        Provider(create: (_) => ProductGatewayImpl()),
        Provider(
          create: (_) => UserRepositoryImpl(
            gateway: Provider.of<UserGatewayImpl>(_, listen: false),
          ),
        ),
        Provider(
          create: (_) => ProductRepositoryImpl(
            productGatewayImpl:
                Provider.of<ProductGatewayImpl>(_, listen: false),
          ),
        ),
        Provider(
          create: (_) => UserServiceImpl(
            repository: Provider.of<UserRepositoryImpl>(_, listen: false),
          ),
        ),
        Provider(
          create: (_) => ProductServiceImpl(
            productRepository:
                Provider.of<ProductRepositoryImpl>(_, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterController(
            userServiceImpl: Provider.of<UserServiceImpl>(_, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginController(
            userServiceImpl: Provider.of<UserServiceImpl>(_, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterProductsController(
            productServiceImpl:
                Provider.of<ProductServiceImpl>(_, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeController(
            productServiceImpl:
                Provider.of<ProductServiceImpl>(_, listen: false),
            userServiceImpl: Provider.of<UserServiceImpl>(_, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => EditProductsController(
              productServiceImpl:
                  Provider.of<ProductServiceImpl>(_, listen: false)),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        primaryColor: const Color(0XFF22BABB),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

//testevoalle@gmail.com
//12345678voalle
