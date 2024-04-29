class MoviesPageModel {
  final List<Movie> content;
  final Pageable pageable;
  final int totalPages;
  final int totalElements;
  final bool last;
  final int size;
  final int number;
  final Sort sort;
  final bool first;
  final int numberOfElements;
  final bool empty;

  MoviesPageModel({
    required this.content,
    required this.pageable,
    required this.totalPages,
    required this.totalElements,
    required this.last,
    required this.size,
    required this.number,
    required this.sort,
    required this.first,
    required this.numberOfElements,
    required this.empty,
  });

  factory MoviesPageModel.fromJson(Map<String, dynamic> json) =>
      MoviesPageModel(
        content: (json['content'] as List)
            .map((data) => Movie.fromJson(data as Map<String, dynamic>))
            .toList(),
        pageable: Pageable.fromJson(json['pageable'] as Map<String, dynamic>),
        totalPages: json['totalPages'],
        totalElements: json['totalElements'],
        last: json['last'],
        size: json['size'],
        number: json['number'],
        sort: Sort.fromJson(json['sort'] as Map<String, dynamic>),
        first: json['first'],
        numberOfElements: json['numberOfElements'],
        empty: json['empty'],
      );

  Map<String, dynamic> toJson() => {
        'content': content.map((e) => e.toJson()).toList(),
        'pageable': pageable.toJson(),
        'totalPages': totalPages,
        'totalElements': totalElements,
        'last': last,
        'size': size,
        'number': number,
        'sort': sort.toJson(),
        'first': first,
        'numberOfElements': numberOfElements,
        'empty': empty,
      };
}

class Movie {
  final int id;
  final int year;
  final String title;
  final List<String> studios;
  final List<String> producers;
  final bool winner;

  Movie({
    required this.id,
    required this.year,
    required this.title,
    required this.studios,
    required this.producers,
    required this.winner,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json['id'],
        year: json['year'],
        title: json['title'],
        studios: List<String>.from(json['studios'].map((x) => x)),
        producers: List<String>.from(json['producers'].map((x) => x)),
        winner: json['winner'],
      );

  toJson() => {
        'id': id,
        'year': year,
        'title': title,
        'studios': studios,
        'producers': producers,
        'winner': winner,
      };
}

class Pageable {
  final Sort sort;
  final int offset;
  final int pageSize;
  final int pageNumber;
  final bool paged;
  final bool unpaged;

  Pageable({
    required this.sort,
    required this.offset,
    required this.pageSize,
    required this.pageNumber,
    required this.paged,
    required this.unpaged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        sort: Sort.fromJson(json['sort'] as Map<String, dynamic>),
        offset: json['offset'],
        pageSize: json['pageSize'],
        pageNumber: json['pageNumber'],
        paged: json['paged'],
        unpaged: json['unpaged'],
      );

  Map<String, dynamic> toJson() => {
        'sort': sort.toJson(),
        'offset': offset,
        'pageSize': pageSize,
        'pageNumber': pageNumber,
        'paged': paged,
        'unpaged': unpaged,
      };
}

class Sort {
  final bool unsorted;
  final bool sorted;
  final bool empty;

  Sort({
    required this.unsorted,
    required this.sorted,
    required this.empty,
  });

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        unsorted: json['unsorted'],
        sorted: json['sorted'],
        empty: json['empty'],
      );

  Map<String, dynamic> toJson() => {
        'unsorted': unsorted,
        'sorted': sorted,
        'empty': empty,
      };
}
