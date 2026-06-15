class Terminal {
  final String city;
  final String terminalName;

  const Terminal({required this.city, required this.terminalName});
}

// mock terminal data
const List<Terminal> mockTerminals = [
  Terminal(city: 'Surabaya', terminalName: 'Bungurasih Terminal'),
  Terminal(city: 'Mojokerto', terminalName: 'Mojokerto Toll Exit'),
  Terminal(city: 'Nganjuk', terminalName: 'Nganjuk Terminal'),
  Terminal(city: 'Madiun', terminalName: 'Madiun Terminal'),
  Terminal(city: 'Maospati', terminalName: 'Maospati Terminal'),
  Terminal(city: 'Geneng', terminalName: 'Rejomulyo Barat Magetan Geneng, Ngawi Regency'),
  Terminal(city: 'Ngawi', terminalName: 'Ngawi Terminal'),
  Terminal(city: 'Sragen', terminalName: 'Sragen Terminal'),
  Terminal(city: 'Surakarta', terminalName: 'Tirtonadi Terminal'),
  Terminal(city: 'Klaten', terminalName: 'Delanggu, Klaten Regency'),
  Terminal(city: 'Yogyakarta', terminalName: 'Giwangan Terminal'),
];