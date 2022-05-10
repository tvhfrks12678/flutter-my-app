class TwitterId {
  late String value;

  TwitterId(String tweetUrl) {
    value = _getTwitterId(tweetUrl);
  }

  String _getTwitterId(String tweetUrl) {
    String regexString = r'/twitter.com/(\w+)/status/';
    RegExp regExp = RegExp(regexString);
    var matches = regExp.allMatches(tweetUrl);

    var match = matches.elementAt(0);
    return "${match.group(1)}";
  }
}
