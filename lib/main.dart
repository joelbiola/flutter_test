import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DropDown extends StatefulWidget {
  DropDown() : super();

  final String title = "Demo enregistrement des Produits";

  @override
  DropDownState createState() => DropDownState();
}

class Produit {
  int code;
  String nom;

  Produit(this.code, this.nom);

  static List<Produit> getProduits() {
    return <Produit>[
      Produit(1, 'Banc'),
      Produit(2, 'Telephones'),
      Produit(3, 'Vetements'),
      Produit(4, 'Buffet'),
    ];
  }
}

class DropDownState extends State<DropDown> {
  //
  List<Produit> _produits = Produit.getProduits();
  List<DropdownMenuItem<Produit>> _dropdownMenuItems;
  Produit _selectedProduit;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_produits);
    _selectedProduit = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Produit>> buildDropdownMenuItems(List produits) {
    List<DropdownMenuItem<Produit>> items = List();
    for (Produit pr in _produits) {
      items.add(
        DropdownMenuItem(
          value: pr,
          child: Text(pr.nom),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Produit selectedProduit) {
    setState(() {
      _selectedProduit = selectedProduit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Enregistrement des produits"),
        ),
        body: new Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Entrer quelque chose ici'
                  ),
                  validator: (input) => input.contains('') ? 'Veuillez renseigner ce champs' : null,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("Selectionnez votre produit"),
                SizedBox(
                  height: 20.0,
                ),
                DropdownButton(
                  value: _selectedProduit,
                  items: _dropdownMenuItems,
                  onChanged: onChangeDropdownItem,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text('Le produit selectionner est : ${_selectedProduit.nom}'),
                RaisedButton(
                  child: Text("Toaster"),
                  onPressed: () => _showToastMessage("Merci d'avoir ajouter un produit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showToastMessage(String text) {
    Fluttertoast.showToast(msg: text);
  }
}