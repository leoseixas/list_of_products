import 'dart:io';

import 'package:flutter/material.dart';
import 'package:list_of_products/app/presentations/screens/home/home_screen.dart';
import 'package:list_of_products/app/presentations/screens/register_products/register_products_controller.dart';
import 'package:list_of_products/app/presentations/widgets/custom_text_field_widget.dart';
import 'package:list_of_products/app/presentations/widgets/information_error_widget.dart';
import 'package:provider/provider.dart';

class RegisterProductsScreen extends StatefulWidget {
  const RegisterProductsScreen({Key key}) : super(key: key);

  @override
  _RegisterProductsScreenState createState() => _RegisterProductsScreenState();
}

class _RegisterProductsScreenState extends State<RegisterProductsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      final controller =
          Provider.of<RegisterProductsController>(context, listen: false);
      await controller.clearControllers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Consumer<RegisterProductsController>(
          builder: (context, value, child) {
            return GestureDetector(
              onTap: () {
                value.clearControllers();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: Icon(Icons.arrow_back),
            );
          },
        ),
        title: const Text('Cadastro de Produtos'),
      ),
      body: Consumer<RegisterProductsController>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 25),
                  CustomTextFieldWidget(
                    fillColor: Colors.black12,
                    hintText: 'Nome',
                    controller: value.nameController,
                    errorText:
                        value.errorText(value.nameIsValid, value.nameError),
                  ),
                  const SizedBox(height: 25),
                  CustomTextFieldWidget(
                    fillColor: Colors.black12,
                    hintText: 'Descri????o',
                    controller: value.descriptionController,
                    errorText: value.errorText(
                        value.descriptionIsValid, value.descriptionError),
                  ),
                  const SizedBox(height: 25),
                  CustomTextFieldWidget(
                    fillColor: Colors.black12,
                    hintText: 'Valor',
                    controller: value.priceController,
                    textInputType: Platform.isIOS
                        ? TextInputType.number
                        : TextInputType.number,
                    errorText:
                        value.errorText(value.priceIsValid, value.priceError),
                  ),
                  const SizedBox(height: 25),
                  CustomTextFieldWidget(
                    fillColor: Colors.black12,
                    hintText: 'Fabricante',
                    controller: value.fabricatorController,
                    errorText: value.errorText(
                        value.fabricatorIsValid, value.fabricatorError),
                  ),
                  const SizedBox(height: 25),
                  value.showError
                      ? InformationErrorWidget(
                          text: value.messageError,
                        )
                      : Container(),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await value.onPressed();
                      if (result) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: value.isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Cadastrar'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
