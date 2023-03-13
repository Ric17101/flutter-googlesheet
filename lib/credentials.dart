/// TEST content with Google AppScript
/// https://script.google.com/macros/s/AKfycbyRVRmQqCBUoNlMP8sFdS5zWkwflYLOMKz8Zwrk4uiXZHbmh5BUtOFOj5zfq2xyE3EEWQ/exec GET Feedback


// your google auth credentials
const credentials = r'''
{
  "type": "service_account",
  "project_id": "flutter-notejam",
  "private_key_id": "c26e3ffa9f8bb1a0daf07294dae7ca14af5887ae",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDX3NXUrY1C/3lY\nTWPHAfqVYaKBGk9FyroTBI1qv4PEKfc1xg+f5Es1bBpphIZHjIW0uADNvf4WzY35\nlRDx4oxB9fcwEiEDwt9wdHaosrKbs+PyquilNMOmIOb+lAdMGLkyNRftAPS7EwWO\nTl/ge5NYOZXQulxEgc5cWhrj3RlwC5KCYMGIMk+WszzQs/gjb3Pz6S0sMlFokdRr\nV9g5d2u8Y2ebbpPqkerKHL2+8+fYuQE1AcRr7mKxXU8NFErFuhHMfrR8TtAr1g3a\nBrvaw/jBGOFuxBdQlNyIanVQs4GE+eRmifM7dGTbz+KeNY/OvAriOCV5NipouPqO\nwdnqhsN9AgMBAAECggEACsijfg51giVVII4tL+HvbMsF3UE9OJVaGl0d23lZ0dDu\n4qbUXP6Aq1iNMTxHoQdqHo8aqyyUpvr53sANqqfQrfLluGcPcyqnEu0eiGr09UZV\nWugi2y35oDEAmTM38htCFToFyfdEQpw+qM9Nht9liwDFdTn6Jgn+DysJMNz4yloS\nH/+6Vm7ayNITLQbvfvvgIW/ASnEUkaB5A06lUqw1unjL/aAL7nVb6EKgxtxXOgfR\nIEG/p2sDM1cM+jhJyOITWSgKOFa9ANwWjdRu9h7awV7RQc3vHkae2u+dyJGNpzfd\n/dEeJy1WNhjJ7YTtH/JW+SX2DQk/Urgp2EoX1uHamQKBgQD4K/LGmfJv6/4GSnBX\nfZ1DehASH7rXsYfa95fnNSM8KMiajtIkNA2F8ufcixO9giqS5cEW8juejhjwpqKp\nFbp1L0ePPYlDY/sUEFgF8mfL8TbXNUvvdlFHnFZo4eD9wWJWfYPdvo5P5L1Nuup9\n8VK28FPgaxKlP0CT0MOvCEx8awKBgQDeq/ujL9ZgPVQZWdeuknqHAolfD3y2pjl3\nC5/9bKxa128iPs6rkYJ9HCFAKt/YhTvFGMND00EG4tE+3iKASUPu7pUuSSyoffT7\nM6IjVTerTw5nYWkSGU6Ytca9IcbsyyLMLPbCvOZJPdYPJ+D9x49B2Cv0wKCZVoyH\n3C4CxfI5twKBgQCOnrsbtVclSOsodFkRfqgFIj3gHIoE8QqRJR8QCXKhXRLD9/X+\nRkfLRehHz0ld7FNJLm6EIFtw6Fqe2jS6lTkdpTkrsYKTzv547leXu1I5WvtYPFHS\nYR2e2NKz3bOuQReheupwYdVpRpwf8p5WGHyfk4ewffguLSaQjDYY/dzu1wKBgHr9\n1c1KNAgOd/BUvpwvTjxae1QlcsZURDNsGV/acczvZ/Qrau47Pi8qpXcS93daCCyS\nw/AntKhACkHGYponXb2QzJe3VVJv2CwUVf9cJ5aY4STbGjUkA1S4OuDm0kCi50KN\np3Li8fQMkrrmVRD39DnzVDwpVcu8kXzNciCYA3Y7AoGAJTIs81vWakQ/O/JbABqx\n0Y0m1Nz6eKOIRqdevFgDEZzBxrNjvwKFvVxzflsjwEDhcXboTsfa7UnE40PgkW92\nt/ucq2qOiIzzKRWG4BGYCX94qXyl+GG+CZuHtcjm3XmJYAI50ziRxFVC7IHWqjlc\nwPaQega5wIIfdeRLme5mNyo=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheet-notejam@flutter-notejam.iam.gserviceaccount.com",
  "client_id": "110033987513255690522",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheet-notejam%40flutter-notejam.iam.gserviceaccount.com"
}
''';

// your spreadsheet id
const spreadsheetId = '1QI_2BwwOlz64sxrXfkrZszfWWOGQe4lAFIFF0S-nvmM';
// https://docs.google.com/spreadsheets/d/1QI_2BwwOlz64sxrXfkrZszfWWOGQe4lAFIFF0S-nvmM/edit#gid=0

/***
 * TODO: sample reference flutter project
    Demo flutter web: https://patilshreyas.github.io/Flutter2GoogleSheets-Demo/demo/
    Profile: https://github.com/PatilShreyas
    Medium Ref: https://medium.com/scalereal/getting-data-from-google-sheets-flutter-app-part-2-d6e689fdbbed
    Github Repo: https://github.com/PatilShreyas/Flutter2GoogleSheets-Demo/blob/master/lib/feedback_list.dart
    Google Sheet: https://docs.google.com/spreadsheets/d/1QI_2BwwOlz64sxrXfkrZszfWWOGQe4lAFIFF0S-nvmM/edit#gid=1320242139

    Features to add:
    - Add button or floating button
    - Clean up codes
    - Use and maintain AppScript
    - Unit tests
    Optionals (make it simple as much as possible for reference)
    - Google Authentication (optional)
    - Create other architecture patterns as another branch? (optional)
    - async redux
    - bloc
    - create the spreadsheet if not existed per user (if needed for private GDrive)

    z
 */