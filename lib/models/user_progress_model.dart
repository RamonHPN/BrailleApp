class UserProgress {
  final String userId;
  final Map<String, int> completedFases; // faseId: stepsCompleted
  final Map<String, int> scores; // faseId: score

  UserProgress({
    required this.userId,
    required this.completedFases,
    required this.scores,
  });
}
