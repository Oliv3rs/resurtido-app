class getDataSKUList{

  String ?id;
  String ?sku;
  String ?nombre;
  String ?solicitadas;


  getDataSKUList(this.id, this.sku, this.nombre, this.solicitadas);

  getDataSKUList.fromJson(Map<String, dynamic> json){
    id = json['ID'].toString();
    sku = json['SKU'];
    nombre = json['Nombre_producto'];
    solicitadas = json['Solicitadas'];

  }
}