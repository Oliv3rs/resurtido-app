import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../models/getDataSKUList.dart';
import 'editQuantitySku_page.dart';

class Home extends StatefulWidget{
  @override 
  _HomeState createState() => _HomeState();

}


class _HomeState extends State<Home> {
  List<getDataSKUList> data = <getDataSKUList>[];

  Future<List<getDataSKUList>> getDatos() async {
    var url ='http://192.168.10.120:3002/ResurtidoApp/getSKUList';
     Response response = await get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      ).timeout(const Duration(seconds: 90));
      print(response.body);
    var datos = json.decode(response.body);
    //print(datos);
    var registros = <getDataSKUList>[];

    for(datos in datos) {
      registros.add(getDataSKUList.fromJson(datos));
    }

    return registros;
  }
  
  @override
  void initState() {
    super.initState();
    getDatos().then((value){
      setState(() {
        data.addAll(value);
      });

    });
  }

   void getInfoSKU(String sku) async {
     Map datos = {
                    'SKU' : sku
                 };
        var body = json.encode(datos);

    try{
          Response response = await post(
                  Uri.parse('http://192.168.10.120:3002/ResurtidoApp/getSKUinfo'),
                  headers: {"Content-Type": "application/json"},
                  body: body
                );
                if(response.statusCode == 200){
        
                  var res = response.body;
                  print(res);
                var dataSKU = [];
                dataSKU = json.decode(res);

                String product = dataSKU[0]['Nombre_producto'];
                  // ignore: use_build_context_synchronously
                 /* Navigator.push(
                  context,
                MaterialPageRoute(
                  builder: (context) => SkuPage(
                    product: product
                    )
                  ),
     );*/

                }
      
      }catch(e){

      print(e.toString());

    }
    }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      //padding: const EdgeInsets.all(13),
                      //child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        title: Text("SKU: ${data[index].sku}" " ${data[index].nombre}", 
                                    style: const TextStyle(
                                      fontSize: 15, 
                                      fontWeight: FontWeight.w600
                                      ),
                                    ),
                        subtitle :Text("Piezas solicitadas: ${data[index].solicitadas}", 
                            style:const TextStyle(
                              color: Color.fromARGB(255, 4, 51, 255),
                              ),
                          ),
                        onLongPress: () {
                          print('Seleccionaste el ID: ${data[index].id}');
                          var skuId = data[index].id;
                          Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => editQuantitySku(
                            id: skuId,
                            )
                          ),
                        );
                        },
                      ),
                    );
                  
                }

                ),
          ),
        ],
      ),
      
    );
  }

}


  