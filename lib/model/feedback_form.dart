/// FeedbackForm is a data class which stores data fields of Feedback.
class FeedbackForm {
  String id;
  String name;
  String email;
  String mobileNumber;
  String feedback;

  FeedbackForm(
    this.id,
    this.name,
    this.email,
    this.mobileNumber,
    this.feedback,
  );

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm(
      "${json['id']}",
      "${json['name']}",
      "${json['email']}",
      "${json['mobileNumber']}",
      "${json['feedback']}",
    );
  }

  // Method to make GET parameters.
  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'mobileNumber': mobileNumber,
        'feedback': feedback,
      };
}
