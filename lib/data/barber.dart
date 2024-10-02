class Person {
  final String name;
  final String phone;

  const Person(this.name, this.phone);
}

final List<Person> barberList = _barberData.map((e) => Person(e['name'] as String, e['phone'] as String)).toList(growable: false);
final List<Map<String, Object>> _barberData = [
  {
    "_id": "66fc082b01c29b23d5371439",
    "name": "Meadows Roman",
    "phone": "+1 (895) 418-3838",
  },
  {
    "_id": "66fc082bd2a806da81058a8c",
    "name": "Cassandra Holden",
    "phone": "+1 (836) 408-3815",
  },
  {
    "_id": "66fc082bec83b7bd54f11e64",
    "name": "Russell Simon",
    "phone": "+1 (867) 477-3665",
  },
  {
    "_id": "66fc082b5061c8d719225bcc",
    "name": "Morse Carver",
    "phone": "+1 (917) 487-3137",
  },
  {
    "_id": "66fc082b21c3745cb330a415",
    "name": "Rosanne Barrett",
    "phone": "+1 (807) 454-2577",
  }
];
