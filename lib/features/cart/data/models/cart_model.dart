class CartModel {
  final String id;
  final String title;
  final String photoUrl;
  final String? color;
  final String? size;
  final int currentPrice;
  final int selectedQuantity;
  final int availableQuantity;

  CartModel({
    required this.id,
    required this.title,
    required this.photoUrl,
    required this.color,
    required this.size,
    required this.currentPrice,
    required this.selectedQuantity,
    required this.availableQuantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json){

    return CartModel(
        id: json['_id'],
        title: json['product']['title'],
        photoUrl: json['product']['photos'][0] ?? '',
        color: json['color'],
        size: json['size'],
        currentPrice: json['product']['current_price'],
        selectedQuantity: json['quantity'],
        availableQuantity: json['product']['quantity'],

    );
  }
}
