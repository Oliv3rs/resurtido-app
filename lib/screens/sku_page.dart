import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SkuPage extends StatelessWidget {
  final  data;
  final product;
SkuPage({this.data, this.product});
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resurtir SKU'),
        backgroundColor: const Color.fromARGB(255, 4, 51, 255),
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        alignment: Alignment.center,
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(1),
              child: const Text('Detalle del SKU',
               style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25.0,
                   )
                  ) 
                ),
                 _espacio(),
                 _espacio(),
           Container(
                  alignment: Alignment.center,
                  child: Text(product,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                        )
                      ),
                 ),
           
                 _espacio(),
            Text('SKU: $data',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                )),
             _espacio(),
             Column(
              mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
               TextField(
                textAlign: TextAlign.center,
                 decoration: const InputDecoration(
                  labelText: "Actualizar número de piezas:"
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.redAccent
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                     FilteringTextInputFormatter.digitsOnly
                 ],
               )
               ]
             )
           

          ],
        ),
      ),
    );
  }
  Widget _espacio(){
    return const SizedBox(
      height: 10.0,
    );
  }
}