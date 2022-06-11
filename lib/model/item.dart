import 'package:radix_mobile_project/model/produtos.dart';

class Item {
  final String idItem;
  final Produtos produto;
  final int quantity;
  final double total;

  const Item({
    required this.idItem,
    required this.produto,
    required this.quantity,
    required this.total,
  });
}
