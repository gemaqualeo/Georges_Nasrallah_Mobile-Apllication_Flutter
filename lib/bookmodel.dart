//
// class BookModel{
//   int bookId;
//   String name;
//   // String summary;
//   // String author;
//   // String text;
//   String image;
//
//   BookModel({required this.bookId,
//     required this.name,
//     // required this.author,
//     // required this.summary,
//     // required this.text,
//     required this.image});
//
//   BookModel fromJson(Map<String, dynamic> json){
//     BookModel bookModel = BookModel(
//         bookId: (bookId),
//         name: name, image: image);
//   }
//
//   Map<String, dynamic> toJson(BookModel bookModel){
//     Map<String, dynamic> data = {
//       "bookId": bookModel.bookId,
//       "image": bookModel.image,
//       "name": bookModel.name
//
//     };
//     return data;
//   }
//
// }