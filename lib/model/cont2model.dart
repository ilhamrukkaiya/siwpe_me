class Cont2model {
  int? id;
  // ignore: prefer_typing_uninitialized_variables
  dynamic selectIndex;
  String? imageUrl;

  // ignore: prefer_typing_uninitialized_variables

  Cont2model({
    this.id,
    this.selectIndex,
     this.imageUrl,
  });

  factory Cont2model.fromMap(Map<String, dynamic> map) {
    return Cont2model(
        id: map["id"],
        selectIndex: map["selectIndex"],
        imageUrl: map["imageUrl"]);
  }

  get selectIndex2 => null;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "selectIndex": selectIndex,
      "imageUrl": imageUrl
    };
    return map;
  }
}

