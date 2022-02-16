import 'package:flutter/material.dart';
import 'package:list_of_products/app/domain/entities/products.dart';
import 'package:list_of_products/app/presentations/screens/edit_products/edit_products_screen.dart';
import 'package:list_of_products/app/presentations/screens/home/home_controller.dart';
import 'package:list_of_products/app/presentations/screens/login/login_screen.dart';
import 'package:list_of_products/app/presentations/screens/register_products/register_products_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      final controller = Provider.of<HomeController>(context, listen: false);
      await controller.initializeListProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Produto'),
        actions: [
          Consumer<HomeController>(
            builder: (context, value, child) {
              return GestureDetector(
                onTap: () async {
                  final result = await value.logout();
                  if (result) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 14.0),
                  child: Icon(Icons.logout),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<HomeController>(
        builder: (context, value, child) {
          return Center(
            child: value.isLoading
                ? Center(child: CircularProgressIndicator())
                : value.list.isEmpty
                    ? Center(
                        child: Text('Sem produto cadastrado'),
                      )
                    : Container(
                        padding: const EdgeInsets.all(32),
                        child: ListView.builder(
                          itemCount: value.list.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Products product = value.list[index];
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => EditProductsScreen(
                                      products: product,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Nome: ',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            value.list[index].name,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Text(
                                            'Valor: ',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            value.list[index].price.toString(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Text(
                                            'Fabricante: ',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            value.list[index].fabricator,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Text(
                                            'Descrição: ',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            value.list[index].description,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const RegisterProductsScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
