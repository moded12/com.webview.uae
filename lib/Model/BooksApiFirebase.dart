class BooksApiFirebase {
 late List<Books> books;

  BooksApiFirebase({required this.books});

  BooksApiFirebase.fromJson(Map<String, dynamic> json) {
    if (json['books'] != null) {
      books = [];
      json['books'].forEach((v) {
        books.add(new Books.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.books != null) {
      data['books'] = this.books.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Books {
 late String name;
 late String server;
 late String totalPages;
 late String ext;
 late String fileName;
 late String img;
 late String hasFehrist;

  Books(
      {required this.name,
       required this.server,
       required this.totalPages,
       required this.ext,
       required this.fileName,
       required this.img,
       required this.hasFehrist
      });

  Books.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    server = json['server'];
    totalPages = json['total_pages'];
    ext = json['ext'];
    fileName = json['file_name'];
    img = json['img'];
    hasFehrist = json['hasFehrist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['server'] = this.server;
    data['total_pages'] = this.totalPages;
    data['ext'] = this.ext;
    data['file_name'] = this.fileName;
    data['img'] = this.img;
    data['hasFehrist'] = this.hasFehrist;
    return data;
  }
}
