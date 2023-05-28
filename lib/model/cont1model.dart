class Cont1modl {
  int? id;
  // ignore: prefer_typing_uninitialized_variables
  dynamic selectIndex;
  String? imageUrl;

  // ignore: prefer_typing_uninitialized_variables

  Cont1modl({
    this.id,
    this.selectIndex,
     this.imageUrl,
  });

  factory Cont1modl.fromMap(Map<String, dynamic> map) {
    return Cont1modl(
        id: map["id"],
        selectIndex: map["selectIndex"],
        imageUrl: map["imageUrl"]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "selectIndex": selectIndex,
      "imageUrl": imageUrl
    };
    return map;
  }
}

  // @override
  // String toString() =>
  //     'Cont1modl(id: $id, selectIndex: $selectIndex, imageUrl: $imageUrl)';

