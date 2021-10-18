


import 'package:korek/helpers/subjects.dart';

class Filters{
    String? searchStr;
    SortType sortType = SortType.sortMethods[0];
    List<Subjects> subjects = [];
}


class SortType {
  String name;
  Sort sort;

  SortType(this.name, this.sort);

  static List<SortType> get sortMethods => [
        SortType("Rating", Sort.rating),
        SortType("Name [A-Z]", Sort.nameAZ),
        SortType("Name [Z-A]", Sort.nameZA),
        SortType("Price ⬇", Sort.lowPrice),
        SortType("Price ⬆", Sort.highPrice),
      ];
}

enum Sort {
  rating,
  highPrice,
  lowPrice,
  nameAZ,
  nameZA,
}
