class LoginResponse {
  final Status status;
  final Map<String, dynamic> body;

  LoginResponse({required this.status, required this.body});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: Status.fromJson(json['status']),
      body: json['body'] ?? {},
    );
  }
}

class Status {
  final int code;
  final String message;

  Status({required this.code, required this.message});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      code: json['code'],
      message: json['message'],
    );
  }
}
