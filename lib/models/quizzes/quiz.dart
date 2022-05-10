class Quiz {
  final String question;
  final List<String> choices;
  final int answerNo;
  final String sourceUrl;
  final String imageUrl;
  final String supplement;

  const Quiz(this.question, this.choices, this.answerNo, this.sourceUrl,
      this.imageUrl, this.supplement);
}
