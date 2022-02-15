import 'package:flutter/material.dart';
import 'package:list_of_products/app/presentations/screens/home/home_screen.dart';
import 'package:list_of_products/app/presentations/screens/register_products/register_products_controller.dart';
import 'package:list_of_products/app/presentations/widgets/custom_text_field_widget.dart';
import 'package:list_of_products/app/presentations/widgets/information_error_widget.dart';
import 'package:provider/provider.dart';

class RegisterProductsScreen extends StatelessWidget {
  const RegisterProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: GestureDetector(
        //   onTap: () {
        //     Navigator.of(context).pop();
        //   },
        //   child: Icon(Icons.arrow_back),
        // ),
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
                  // ImageFieldWidget(
                  //   onImageSelected: value.onImageSelected,
                  // ),
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
                    hintText: 'Descrição',
                    controller: value.descriptionController,
                    errorText: value.errorText(
                        value.descriptionIsValid, value.descriptionError),
                  ),
                  const SizedBox(height: 25),
                  CustomTextFieldWidget(
                    fillColor: Colors.black12,
                    hintText: 'Valor',
                    controller: value.priceController,
                    textInputType: TextInputType.number,
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
                      ? const InformationErrorWidget(
                          text: 'Erro ao cadastrar produto')
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
