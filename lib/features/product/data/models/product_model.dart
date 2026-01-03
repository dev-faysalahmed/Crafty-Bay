// {
// "_id": "67c7c21a623a876bc4767015",
// "title": "TUS Product 4",
// "photos": [
// "https://opsg-img-cdn-gl.heytapimg.com/epb/202501/26/KL3ZNGfgHubc8642.jpg",
// "https://opsg-img-cdn-gl.heytapimg.com/epb/202501/02/zDc3USjyFOIYnO3M.jpg",
// "https://opsg-img-cdn-gl.heytapimg.com/epb/202412/19/P9iQuoBXP9MSFAG2.png",
// "https://opsg-img-cdn-gl.heytapimg.com/epb/202412/19/9xpwKzGQvvCpSZd6.png",
// "https://opsg-img-cdn-gl.heytapimg.com/epb/202412/19/8GSbdJcv5EIXej07.png",
// "https://opsg-img-cdn-gl.heytapimg.com/epb/202412/19/aHKkrDjJY0AWXDLm.png"
//current_price

class ProductModel {
  final String id;
  final String title;
  final String photo;
  final int currentPrice;

  ProductModel({
    required this.id,
    required this.title,
    required this.photo,
    required this.currentPrice,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      title: json['title'],
      photo: json['photos'][0],  // TODO: find a better way to handle null or empty list
      currentPrice: json['current_price'],
    );
  }
}
