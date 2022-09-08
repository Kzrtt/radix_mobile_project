class Pedido {
  final int idPedido;
  final String data;
  final int frete;
  final int idCliente;
  final int idVendedor;
  final int idCupomCliente;
  final int idEntregador;

  Pedido({
    required this.idPedido,
    required this.data,
    required this.frete,
    required this.idCliente,
    required this.idVendedor,
    required this.idCupomCliente,
    required this.idEntregador,
  });
}
