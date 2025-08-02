import "package:flutter/material.dart";
import 'package:flutter_lista_compras_drift_dio/products/data/products_drift_handler.dart';
import 'package:uuid/uuid.dart';
import '../../model/product.dart';

showProductAddEditProductModal({
  required BuildContext context,
  required Function onRefresh,
  required ProductsDriftHandler productsDriftHandler,
  Product? product,
}) {
  String labelTitle = "Adicionar produto";
  String labelConfirmationButton = "Salvar";
  String labelSkipButton = "Cancelar";

  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController obsController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  bool isPurchased = false;
  bool isKilograms = false;

  bool isOptionalExpanded = false;

  if (product != null) {
    labelTitle = "Editando ${product.name}";
    nameController.text = product.name;
    obsController.text = product.obs;
    categoryController.text = product.category;

    if (product.price != null) {
      priceController.text = product.price.toString();
    }

    if (product.amount != null) {
      amountController.text = product.amount.toString();
    }

    isPurchased = product.isPurchased;
    isKilograms = product.isKilograms;

    isOptionalExpanded = true;
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (context) {
      return SingleChildScrollView(
        reverse: true,
        child: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: ListView(
                children: [
                  Text(
                    labelTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      label: Text("Nome do produto"),
                      icon: Icon(Icons.shopping_basket),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: false,
                    ),
                    decoration: const InputDecoration(
                      label: Text("Quantidade"),
                      icon: Icon(Icons.numbers),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: priceController,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: false,
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      label: Text("Preço"),
                      icon: Icon(Icons.attach_money_rounded),
                      prefixText: "€ ",
                    ),
                    onChanged: (value) {
                      priceController.text = value.replaceAll(",", ".");
                    },
                  ),
                  const SizedBox(height: 16),
                  CheckboxListTile(
                    value: isKilograms,
                    title: const Text("Dividir por quilogramas?"),
                    onChanged: (value) {
                      setState(() {
                        isKilograms = !isKilograms;
                      });
                    },
                  ),
                  CheckboxListTile(
                    value: isPurchased,
                    title: const Text("Estou comprando agora"),
                    onChanged: (value) {
                      setState(() {
                        isPurchased = !isPurchased;
                      });
                    },
                  ),
                  ExpansionPanelList(
                    elevation: 0,
                    materialGapSize: 0,
                    expandedHeaderPadding: EdgeInsets.zero,
                    expansionCallback: (panelIndex, isExpanded) {
                      setState(() {
                        isOptionalExpanded = !isOptionalExpanded;
                      });
                    },
                    children: [
                      ExpansionPanel(
                        isExpanded: isOptionalExpanded,
                        canTapOnHeader: true,
                        backgroundColor: Colors.white,
                        headerBuilder: (context, isExpanded) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "Outros campos",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                        body: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: categoryController,
                              keyboardType: TextInputType.name,
                              textCapitalization: TextCapitalization.words,
                              decoration: const InputDecoration(
                                label: Text("Categoria"),
                                icon: Icon(Icons.tag),
                              ),
                            ),
                            TextFormField(
                              controller: obsController,
                              minLines: 2,
                              maxLines: null,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.abc),
                                label: Text("Observações"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(labelSkipButton),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () async {
                          final navigator = Navigator.of(context);

                          Product produto = Product(
                            id: const Uuid().v1(),
                            name: nameController.text,
                            category: categoryController.text,
                            obs: obsController.text,
                            isPurchased: isPurchased,
                            isKilograms: isKilograms,
                            listinId: "",
                          );

                          if (product != null) {
                            produto.id = product.id;
                            produto.listinId = product.listinId;
                            product.name = nameController.text;
                            product.category = categoryController.text;
                            product.obs = obsController.text;
                            product.isPurchased = isPurchased;
                            product.isKilograms = isKilograms;
                          }

                          if (amountController.text != "") {
                            produto.amount = double.parse(
                              amountController.text,
                            );
                            if (product != null) {
                              product.amount = double.parse(
                                amountController.text,
                              );
                            }
                          }

                          if (priceController.text != "") {
                            produto.price = double.parse(priceController.text);
                            if (product != null) {
                              product.price = double.parse(
                                priceController.text,
                              );
                            }
                          }

                          if (product == null) {
                            await productsDriftHandler.insertProduct(produto);
                          } else {
                            await productsDriftHandler.updateProduct(product);
                          }

                          onRefresh();

                          navigator.pop();
                        },
                        child: Text(labelConfirmationButton),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
