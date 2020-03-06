class QueryAutocompletePredictions {
  List<Predictions> predictions;
  String status;

  QueryAutocompletePredictions({this.predictions, this.status});

  QueryAutocompletePredictions.fromJson(Map<String, dynamic> json) {
    if (json['predictions'] != null) {
      predictions = new List<Predictions>();
      json['predictions'].forEach((v) {
        predictions.add(new Predictions.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.predictions != null) {
      data['predictions'] = this.predictions.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Predictions {
  String description;
  List<MatchedSubstrings> matchedSubstrings;
  StructuredFormatting structuredFormatting;
  List<Terms> terms;

  Predictions(
      {this.description,
        this.matchedSubstrings,
        this.structuredFormatting,
        this.terms});

  Predictions.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    if (json['matched_substrings'] != null) {
      matchedSubstrings = new List<MatchedSubstrings>();
      json['matched_substrings'].forEach((v) {
        matchedSubstrings.add(new MatchedSubstrings.fromJson(v));
      });
    }
    structuredFormatting = json['structured_formatting'] != null
        ? new StructuredFormatting.fromJson(json['structured_formatting'])
        : null;
    if (json['terms'] != null) {
      terms = new List<Terms>();
      json['terms'].forEach((v) {
        terms.add(new Terms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    if (this.matchedSubstrings != null) {
      data['matched_substrings'] =
          this.matchedSubstrings.map((v) => v.toJson()).toList();
    }
    if (this.structuredFormatting != null) {
      data['structured_formatting'] = this.structuredFormatting.toJson();
    }
    if (this.terms != null) {
      data['terms'] = this.terms.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MatchedSubstrings {
  int length;
  int offset;

  MatchedSubstrings({this.length, this.offset});

  MatchedSubstrings.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['length'] = this.length;
    data['offset'] = this.offset;
    return data;
  }
}

class StructuredFormatting {
  String mainText;
  List<MainTextMatchedSubstrings> mainTextMatchedSubstrings;
  String secondaryText;
  List<SecondaryTextMatchedSubstrings> secondaryTextMatchedSubstrings;

  StructuredFormatting(
      {this.mainText,
        this.mainTextMatchedSubstrings,
        this.secondaryText,
        this.secondaryTextMatchedSubstrings});

  StructuredFormatting.fromJson(Map<String, dynamic> json) {
    mainText = json['main_text'];
    if (json['main_text_matched_substrings'] != null) {
      mainTextMatchedSubstrings = new List<MainTextMatchedSubstrings>();
      json['main_text_matched_substrings'].forEach((v) {
        mainTextMatchedSubstrings
            .add(new MainTextMatchedSubstrings.fromJson(v));
      });
    }
    secondaryText = json['secondary_text'];
    if (json['secondary_text_matched_substrings'] != null) {
      secondaryTextMatchedSubstrings =
      new List<SecondaryTextMatchedSubstrings>();
      json['secondary_text_matched_substrings'].forEach((v) {
        secondaryTextMatchedSubstrings
            .add(new SecondaryTextMatchedSubstrings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['main_text'] = this.mainText;
    if (this.mainTextMatchedSubstrings != null) {
      data['main_text_matched_substrings'] =
          this.mainTextMatchedSubstrings.map((v) => v.toJson()).toList();
    }
    data['secondary_text'] = this.secondaryText;
    if (this.secondaryTextMatchedSubstrings != null) {
      data['secondary_text_matched_substrings'] =
          this.secondaryTextMatchedSubstrings.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MainTextMatchedSubstrings {
  int length;
  int offset;

  MainTextMatchedSubstrings({this.length, this.offset});

  MainTextMatchedSubstrings.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['length'] = this.length;
    data['offset'] = this.offset;
    return data;
  }
}

class SecondaryTextMatchedSubstrings {
  int length;
  int offset;

  SecondaryTextMatchedSubstrings({this.length, this.offset});

  SecondaryTextMatchedSubstrings.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['length'] = this.length;
    data['offset'] = this.offset;
    return data;
  }
}


class Terms {
  int offset;
  String value;

  Terms({this.offset, this.value});

  Terms.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = this.offset;
    data['value'] = this.value;
    return data;
  }
}
