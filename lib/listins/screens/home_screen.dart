import 'package:flutter/material.dart';
import 'package:flutter_lista_compras_drift_hive/authentication/models/mock_user.dart';
import 'package:flutter_lista_compras_drift_hive/listins/data/data_base.dart';
import 'package:flutter_lista_compras_drift_hive/listins/screens/widgets/home_drawer.dart';
import 'package:flutter_lista_compras_drift_hive/listins/screens/widgets/home_listin_item.dart';
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
}
