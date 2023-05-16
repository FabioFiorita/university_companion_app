class MockJsonClass {
  static const String list = '''
      [
    {
        "time": "08:00:00",
        "day": "tuesday",
        "id": 1,
        "subject_id": "C103"
    },
    {
        "time": "08:00:00",
        "day": "tuesday",
        "id": 2,
        "subject_id": "C317"
    },
    {
        "time": "08:00:00",
        "day": "tuesday",
        "id": 3,
        "subject_id": "C206"
    },
    {
        "time": "08:00:00",
        "day": "tuesday",
        "id": 4,
        "subject_id": "C231"
    }
]
    ''';
}

class MockJsonSubject {
  static const String list = '''
{
    "id": 1,
    "course": "GEC",
    "email": "avner@inatel.br",
    "name": "Avner",
    "subjects": [
        {
            "name": "POO",
            "professor_id": 1,
            "id": "C206"
        },
        {
            "name": "Algoritmos III",
            "professor_id": 1,
            "id": "C103"
        },
        {
            "name": "Topicos Especiais",
            "professor_id": 1,
            "id": "C317"
        }
    ],
    "exams": [
        {
            "date": "1970-01-20T11:43:12",
            "code": "NP1",
            "id": 2,
            "subject_id": "C317"
        }
    ]
}
''';
  static const String single = '''
    {
    "name": "Algoritmos III",
    "id": "C103",
    "exams": [
        {
            "date": "1970-01-20T11:43:12",
            "code": "NP1",
            "id": 1
        }
    ],
    "professor": {
        "name": "Fabio",
        "email": "fabio@inatel.br",
        "id": 1,
        "departament": "Computer Science",
        "phone_number": "98822-6501"
    },
    "students": [
        {
            "id": 1,
            "course": "GEC",
            "email": "avner@inatel.br",
            "name": "Avner"
        }
    ],
    "classes": [
        {
            "time": "08:00:00",
            "day": "tuesday",
            "id": 1
        }
    ]
}
    ''';
}

class MockJsonContact {
  static const String list = '''
      {
        "contacts":[
            {
              "id":1,
              "area":"CRA",
              "number":"(35)3391-3921"
            },
            {
              "id":2,
              "area":"Tesouraria",
              "number":"(35)3391-3922"
            },
            {
              "id":3,
              "area":"RH",
              "number":"(35)3391-3923"
            }
        ]
      }
    ''';
}

class MockJsonTeacher {
  static const String list = '''
      [
          {
              "name": "Fabio",
              "email": "fabio@inatel.br",
              "id": 1,
              "departament": "Computer Science",
              "phone_number": "98822-6501"
          },
          {
              "name": "Fabio",
              "email": "fabio@inatel.br",
              "id": 2,
              "departament": "Computer Science",
              "phone_number": "98822-6501"
          }
      ]
    ''';
  static const String single = '''
      {
        "name": "Fabio",
        "email": "fabio@inatel.br",
        "id": 1,
        "departament": "Computer Science",
        "phone_number": "98822-6501",
        "subjects": [
            {
                "name": "Topicos Especiais",
                "id": "C317"
            },
            {
                "name": "Algoritmos III",
                "id": "C103"
            },
            {
                "name": "POO",
                "id": "C206"
            },
            {
                "name": "Algoritmos IISSI",
                "id": "C231"
            }
        ]
      }
    ''';
}

class MockJsonExam {
  static const String list = '''
{
    "id": 1,
    "course": "GEC",
    "email": "avner@inatel.br",
    "name": "Avner",
    "subjects": [
        {
            "name": "POO",
            "professor_id": 1,
            "id": "C206"
        },
        {
            "name": "Algoritmos III",
            "professor_id": 1,
            "id": "C103"
        },
        {
            "name": "Topicos Especiais",
            "professor_id": 1,
            "id": "C317"
        }
    ],
    "exams": [
        {
            "date": "1970-01-20T11:43:12",
            "code": "NP1",
            "id": 2,
            "subject_id": "C317"
        }
    ]
}
''';
  static const String single = '''
{
    "id": 2,
    "date": "1970-01-20T11:43:12",
    "code": "NP1",
    "subject_id": "C317",
    "students": [
        {
            "student_id": 1,
            "name": "Avner",
            "grade": 90.0
        }
    ]
}
''';
}

class MockLogin {
  static const token = '''
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImF2bmVyQGluYXRlbC5iciIsImlkIjoxLCJuYW1lIjoiQXZuZXIiLCJyb2xlIjoic3R1ZGVudCJ9.paH5T8DvAIKfZmU8GaSdAFa95lKTcVb5m0J-KZ8CaXU"
}
''';
  static const error = '''
{
  "detail": "Invalid credentials"
}
''';
}
