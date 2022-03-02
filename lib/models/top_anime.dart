class TopAnime {
  Pagination? pagination;
  List<Data>? data;

  TopAnime({this.pagination, this.data});

  TopAnime.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pagination {
  int? lastVisiblePage;
  bool? hasNextPage;

  Pagination({this.lastVisiblePage, this.hasNextPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    lastVisiblePage = json['last_visible_page'];
    hasNextPage = json['has_next_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['last_visible_page'] = this.lastVisiblePage;
    data['has_next_page'] = this.hasNextPage;
    return data;
  }
}

class Data {
  int? malId;
  String? url;
  Images? images;
  Trailer? trailer;
  String? title;
  String? titleEnglish;
  String? titleJapanese;
  List<String>? titleSynonyms;
  String? type;
  String? source;
  int? episodes;
  String? status;
  bool? airing;
  Aired? aired;
  String? duration;
  String? rating;
  double? score;
  int? scoredBy;
  int? rank;
  int? popularity;
  int? members;
  int? favorites;
  String? synopsis;
  Null? background;
  String? season;
  int? year;
  Broadcast? broadcast;
  List<Producers>? producers;
  List<Null>? licensors;
  List<Studios>? studios;
  List<Genres>? genres;
  List<Null>? explicitGenres;
  List<Themes>? themes;
  List<Demographics>? demographics;

  Data(
      {this.malId,
        this.url,
        this.images,
        this.trailer,
        this.title,
        this.titleEnglish,
        this.titleJapanese,
        this.titleSynonyms,
        this.type,
        this.source,
        this.episodes,
        this.status,
        this.airing,
        this.aired,
        this.duration,
        this.rating,
        this.score,
        this.scoredBy,
        this.rank,
        this.popularity,
        this.members,
        this.favorites,
        this.synopsis,
        this.background,
        this.season,
        this.year,
        this.broadcast,
        this.producers,
        this.licensors,
        this.studios,
        this.genres,
        this.explicitGenres,
        this.themes,
        this.demographics});

  Data.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    url = json['url'];
    images =
    json['images'] != null ? new Images.fromJson(json['images']) : null;
    trailer =
    json['trailer'] != null ? new Trailer.fromJson(json['trailer']) : null;
    title = json['title'];
    titleEnglish = json['title_english'];
    titleJapanese = json['title_japanese'];
    titleSynonyms = json['title_synonyms'].cast<String>();
    type = json['type'];
    source = json['source'];
    episodes = json['episodes'];
    status = json['status'];
    airing = json['airing'];
    aired = json['aired'] != null ? new Aired.fromJson(json['aired']) : null;
    duration = json['duration'];
    rating = json['rating'];
    score = json['score'];
    scoredBy = json['scored_by'];
    rank = json['rank'];
    popularity = json['popularity'];
    members = json['members'];
    favorites = json['favorites'];
    synopsis = json['synopsis'];
    background = json['background'];
    season = json['season'];
    year = json['year'];
    broadcast = json['broadcast'] != null
        ? new Broadcast.fromJson(json['broadcast'])
        : null;
    if (json['producers'] != null) {
      producers = <Producers>[];
      json['producers'].forEach((v) {
        producers!.add(new Producers.fromJson(v));
      });
    }
    if (json['licensors'] != null) {
      licensors = <Null>[];
      json['licensors'].forEach((v) {
        licensors!.add(new Null.fromJson(v));
      });
    }
    if (json['studios'] != null) {
      studios = <Studios>[];
      json['studios'].forEach((v) {
        studios!.add(new Studios.fromJson(v));
      });
    }
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(new Genres.fromJson(v));
      });
    }
    if (json['explicit_genres'] != null) {
      explicitGenres = <Null>[];
      json['explicit_genres'].forEach((v) {
        explicitGenres!.add(new Null.fromJson(v));
      });
    }
    if (json['themes'] != null) {
      themes = <Themes>[];
      json['themes'].forEach((v) {
        themes!.add(new Themes.fromJson(v));
      });
    }
    if (json['demographics'] != null) {
      demographics = <Demographics>[];
      json['demographics'].forEach((v) {
        demographics!.add(new Demographics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mal_id'] = this.malId;
    data['url'] = this.url;
    if (this.images != null) {
      data['images'] = this.images!.toJson();
    }
    if (this.trailer != null) {
      data['trailer'] = this.trailer!.toJson();
    }
    data['title'] = this.title;
    data['title_english'] = this.titleEnglish;
    data['title_japanese'] = this.titleJapanese;
    data['title_synonyms'] = this.titleSynonyms;
    data['type'] = this.type;
    data['source'] = this.source;
    data['episodes'] = this.episodes;
    data['status'] = this.status;
    data['airing'] = this.airing;
    if (this.aired != null) {
      data['aired'] = this.aired!.toJson();
    }
    data['duration'] = this.duration;
    data['rating'] = this.rating;
    data['score'] = this.score;
    data['scored_by'] = this.scoredBy;
    data['rank'] = this.rank;
    data['popularity'] = this.popularity;
    data['members'] = this.members;
    data['favorites'] = this.favorites;
    data['synopsis'] = this.synopsis;
    data['background'] = this.background;
    data['season'] = this.season;
    data['year'] = this.year;
    if (this.broadcast != null) {
      data['broadcast'] = this.broadcast!.toJson();
    }
    if (this.producers != null) {
      data['producers'] = this.producers!.map((v) => v.toJson()).toList();
    }
    if (this.licensors != null) {
      data['licensors'] = this.licensors!.map((v) => v.toJson()).toList();
    }
    if (this.studios != null) {
      data['studios'] = this.studios!.map((v) => v.toJson()).toList();
    }
    if (this.genres != null) {
      data['genres'] = this.genres!.map((v) => v.toJson()).toList();
    }
    if (this.explicitGenres != null) {
      data['explicit_genres'] =
          this.explicitGenres!.map((v) => v.toJson()).toList();
    }
    if (this.themes != null) {
      data['themes'] = this.themes!.map((v) => v.toJson()).toList();
    }
    if (this.demographics != null) {
      data['demographics'] = this.demographics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  Jpg? jpg;
  Jpg? webp;

  Images({this.jpg, this.webp});

  Images.fromJson(Map<String, dynamic> json) {
    jpg = json['jpg'] != null ? new Jpg.fromJson(json['jpg']) : null;
    webp = json['webp'] != null ? new Jpg.fromJson(json['webp']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jpg != null) {
      data['jpg'] = this.jpg!.toJson();
    }
    if (this.webp != null) {
      data['webp'] = this.webp!.toJson();
    }
    return data;
  }
}

class Jpg {
  String? imageUrl;
  String? smallImageUrl;
  String? largeImageUrl;

  Jpg({this.imageUrl, this.smallImageUrl, this.largeImageUrl});

  Jpg.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    smallImageUrl = json['small_image_url'];
    largeImageUrl = json['large_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_url'] = this.imageUrl;
    data['small_image_url'] = this.smallImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    return data;
  }
}

class Trailer {
  String? youtubeId;
  String? url;
  String? embedUrl;
  Images? images;

  Trailer({this.youtubeId, this.url, this.embedUrl, this.images});

  Trailer.fromJson(Map<String, dynamic> json) {
    youtubeId = json['youtube_id'];
    url = json['url'];
    embedUrl = json['embed_url'];
    images =
    json['images'] != null ? new Images.fromJson(json['images']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['youtube_id'] = this.youtubeId;
    data['url'] = this.url;
    data['embed_url'] = this.embedUrl;
    if (this.images != null) {
      data['images'] = this.images!.toJson();
    }
    return data;
  }
}

class Images {
  String? imageUrl;
  String? smallImageUrl;
  String? mediumImageUrl;
  String? largeImageUrl;
  String? maximumImageUrl;

  Images(
      {this.imageUrl,
        this.smallImageUrl,
        this.mediumImageUrl,
        this.largeImageUrl,
        this.maximumImageUrl});

  Images.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    smallImageUrl = json['small_image_url'];
    mediumImageUrl = json['medium_image_url'];
    largeImageUrl = json['large_image_url'];
    maximumImageUrl = json['maximum_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_url'] = this.imageUrl;
    data['small_image_url'] = this.smallImageUrl;
    data['medium_image_url'] = this.mediumImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    data['maximum_image_url'] = this.maximumImageUrl;
    return data;
  }
}

class Aired {
  String? from;
  Null? to;
  Prop? prop;
  String? string;

  Aired({this.from, this.to, this.prop, this.string});

  Aired.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    prop = json['prop'] != null ? new Prop.fromJson(json['prop']) : null;
    string = json['string'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    if (this.prop != null) {
      data['prop'] = this.prop!.toJson();
    }
    data['string'] = this.string;
    return data;
  }
}

class Prop {
  From? from;
  To? to;

  Prop({this.from, this.to});

  Prop.fromJson(Map<String, dynamic> json) {
    from = json['from'] != null ? new From.fromJson(json['from']) : null;
    to = json['to'] != null ? new To.fromJson(json['to']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.from != null) {
      data['from'] = this.from!.toJson();
    }
    if (this.to != null) {
      data['to'] = this.to!.toJson();
    }
    return data;
  }
}

class From {
  int? day;
  int? month;
  int? year;

  From({this.day, this.month, this.year});

  From.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    month = json['month'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['month'] = this.month;
    data['year'] = this.year;
    return data;
  }
}

class To {
  Null? day;
  Null? month;
  Null? year;

  To({this.day, this.month, this.year});

  To.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    month = json['month'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['month'] = this.month;
    data['year'] = this.year;
    return data;
  }
}

class Broadcast {
  String? day;
  String? time;
  String? timezone;
  String? string;

  Broadcast({this.day, this.time, this.timezone, this.string});

  Broadcast.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    time = json['time'];
    timezone = json['timezone'];
    string = json['string'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['time'] = this.time;
    data['timezone'] = this.timezone;
    data['string'] = this.string;
    return data;
  }
}

class Producers {
  int? malId;
  String? type;
  String? name;
  String? url;

  Producers({this.malId, this.type, this.name, this.url});

  Producers.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    type = json['type'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mal_id'] = this.malId;
    data['type'] = this.type;
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
