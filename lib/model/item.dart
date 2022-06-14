import 'package:radix_mobile_project/model/produtos.dart';
import 'package:radix_mobile_project/model/vendedor.dart';

class Item {
  final String idItem;
  final Produtos produto;
  final Vendedor vendedor;
  final int quantity;
  final double total;

  const Item({
    required this.idItem,
    required this.produto,
    required this.vendedor,
    required this.quantity,
    required this.total,
  });
}
