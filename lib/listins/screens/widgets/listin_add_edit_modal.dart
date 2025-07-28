import "package:flutter/material.dart";
import "package:flutter_lista_compras_drift_dio/listins/data/data_base.dart";
import "package:flutter_lista_compras_drift_dio/listins/models/listin.dart";

showAddEditListinModal({
  required BuildContext context,
  required Function onRefresh,
  required AppDatabase appDatabase,
  Listin? model,
}) {
  // Labels à serem mostradas no Modal
  String labelTitle = "Adicionar lista de compras";
  String labelConfirmationButton = "Salvar";
  String labelSkipButton = "Cancelar";

  TextEditingController nameController = TextEditingController();
  TextEditingController obsController = TextEditingController();

  DateTime dateCreate = DateTime.now();
  DateTime dateUpdate = DateTime.now();

  if (model != null) {
    labelTitle = "Editando ${model.name}";
    nameController.text = model.name;
    obsController.text = model.obs;
    dateCreate = model.dateCreate;
    dateUpdate = model.dateUpdate;
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return SingleChildScrollView(
        reverse: true,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          padding: const EdgeInsets.all(32.0),
          child: ListView(
            children: [
              Text(
                labelTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.shopping_basket),
                  label: Text("Nome da lista"),
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
                    onPressed: () {
                      Listin listin = Listin(
                        id: "0",
                        name: nameController.text,
                        obs: obsController.text,
                        dateCreate: dateCreate,
                        dateUpdate: dateUpdate,
                      );

                      if (model == null) {
                        appDatabase.insertListin(listin);
                      } else {
                        listin.id = model.id;
                        appDatabase.updateListin(listin);
                      }

                      onRefresh();

                      Navigator.pop(context);
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
        ),
      );
    },
  );
}
