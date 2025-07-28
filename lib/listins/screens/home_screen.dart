import 'package:flutter/material.dart';
import 'package:flutter_lista_compras_drift_dio/_core/constants/listin_colors.dart';
import 'package:flutter_lista_compras_drift_dio/authentication/models/mock_user.dart';
import 'package:flutter_lista_compras_drift_dio/listins/data/data_base.dart';
import 'package:flutter_lista_compras_drift_dio/listins/screens/widgets/home_drawer.dart';
import 'package:flutter_lista_compras_drift_dio/listins/screens/widgets/home_listin_item.dart';
import 'package:flutter_lista_compras_drift_dio/_core/helpers/confirmation_dialog.dart';
import '../models/listin.dart';
import 'widgets/listin_add_edit_modal.dart';
import 'widgets/listin_options_modal.dart';

class HomeScreen extends StatefulWidget {
  final MockUser user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Listin> listListins = [];
  late AppDatabase appDatabase;
  bool isOrderedByName = false;
  final TextEditingController _searchController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    appDatabase = AppDatabase();
    refresh();
    super.initState();
  }

  @override
  void dispose() {
    appDatabase.close();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(user: widget.user),
      appBar: AppBar(
        title: const Text("Minhas listas"),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              switch (value) {
                case 'order_by_name':
                  orderByName();
                  break;
                case 'order_default':
                  orderDefault();
                  break;
                case 'save_sky':
                  saveSky();
                  break;
                case 'sync_sky':
                  syncSky();
                  break;
                case 'clear_sky':
                  clearSky();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'order_by_name',
                child: Row(
                  children: [
                    Icon(
                      isOrderedByName ? Icons.check : Icons.sort_by_alpha,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text('Ordenar por nome'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'order_default',
                child: Row(
                  children: [
                    Icon(!isOrderedByName ? Icons.check : Icons.list, size: 20),
                    const SizedBox(width: 8),
                    const Text('Ordem data'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'save_sky',
                child: Row(
                  children: [
                    Icon(
                      !isOrderedByName ? Icons.upload : Icons.save_as,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text('Salvar na nuvem'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'sync_sky',
                child: Row(
                  children: [
                    Icon(
                      !isOrderedByName ? Icons.download : Icons.download,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text('Sincronizar na nuvem'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'clear_sky',
                child: Row(
                  children: [
                    Icon(
                      !isOrderedByName ? Icons.clear : Icons.delete,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text('Remover dados da nuvem'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddModal();
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Campo de pesquisa
          Container(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Pesquisar listas...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: isSearching
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: clearSearch,
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  searchListins(value);
                } else {
                  clearSearch();
                }
              },
            ),
          ),
          Expanded(
            child: (listListins.isEmpty)
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/bag.png"),
                        const SizedBox(height: 32),
                        Text(
                          isSearching
                              ? "Nenhuma lista encontrada.\nTente outro termo de busca."
                              : "Nenhuma lista ainda.\nVamos criar a primeira?",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () {
                      return refresh();
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                      child: ListView(
                        children: List.generate(listListins.length, (index) {
                          Listin listin = listListins[index];
                          return HomeListinItem(
                            listin: listin,
                            showOptionModal: showOptionModal,
                          );
                        }),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  showAddModal({Listin? listin}) {
    showAddEditListinModal(
      context: context,
      onRefresh: refresh,
      model: listin,
      appDatabase: appDatabase,
    );
  }

  showOptionModal(Listin listin) {
    showListinOptionsModal(
      context: context,
      listin: listin,
      onRemove: remove,
    ).then((value) {
      if (value != null && value) {
        showAddModal(listin: listin);
      }
    });
  }

  refresh() async {
    List<Listin> listaListins = await appDatabase.getListins();

    setState(() {
      listListins = listaListins;
    });
  }

  void remove(Listin model) async {
    await appDatabase.deleteProductsByListin(model.id);
    await appDatabase.deleteListin(int.parse(model.id));
    refresh();
  }

  void orderByName() async {
    List<Listin> listaListins = await appDatabase.getListinsOrderedByName();
    setState(() {
      listListins = listaListins;
      isOrderedByName = true;
    });
  }

  void orderDefault() async {
    List<Listin> listaListins = await appDatabase.getListins();
    setState(() {
      listListins = listaListins;
      isOrderedByName = false;
    });
  }

  void searchListins(String searchTerm) async {
    if (searchTerm.trim().isEmpty) {
      clearSearch();
      return;
    }

    List<Listin> searchResults = await appDatabase.searchListinsByName(
      searchTerm,
    );
    setState(() {
      listListins = searchResults;
      isSearching = true;
    });
  }

  void clearSearch() {
    _searchController.clear();
    setState(() {
      isSearching = false;
    });

    if (isOrderedByName) {
      orderByName();
    } else {
      orderDefault();
    }
  }

  void saveSky() async {
    bool? confirmed = await showConfirmationDialog(
      context: context,
      title: 'Salvar na nuvem',
      content: 'Confirma a sobrescrita dos dados na nuvem?',
      confirmButtonText: 'Salvar',
      cancelButtonText: 'Cancelar',
      icon: Icons.cloud_upload,
      confirmButtonColor: ListinColors.green[600],
    );

    if (confirmed != null && confirmed) {
      // Implement the logic to save the listins to the cloud (Sky)
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Listas salvas na nuvem!')));
    }
  }

  void syncSky() async {
    bool? confirmed = await showConfirmationDialog(
      context: context,
      title: 'Sincronizar com a nuvem',
      content:
          'Confirma a sincronização dos dados com a nuvem? Isso pode sobrescrever dados locais.',
      confirmButtonText: 'Sincronizar',
      cancelButtonText: 'Cancelar',
      icon: Icons.sync,
      confirmButtonColor: Colors.blue,
    );

    if (confirmed != null && confirmed) {
      // Implement the logic to sync the listins with the cloud (Sky)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Listas sincronizadas com a nuvem!')),
      );
    }
  }

  void clearSky() async {
    bool? confirmed = await showConfirmationDialog(
      context: context,
      title: 'Remover dados da nuvem',
      content:
          'Tem certeza que deseja remover todos os dados da nuvem? Esta ação não pode ser desfeita.',
      confirmButtonText: 'Remover',
      cancelButtonText: 'Cancelar',
      icon: Icons.delete_forever,
      confirmButtonColor: Colors.red,
    );

    if (confirmed != null && confirmed) {
      // Implement the logic to clear the listins from the cloud (Sky)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados da nuvem removidos!')),
      );
    }
  }
}
