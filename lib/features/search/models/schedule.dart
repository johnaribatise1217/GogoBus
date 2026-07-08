class BusDriver {
  final String name;
  final String avatarUrl;

  const BusDriver({required this.name, required this.avatarUrl});
}

class BusCrew extends BusDriver {
  const BusCrew({required super.name, required super.avatarUrl});
}

class BusModel {
  final String modelName;
  final String busClass;
  final List<String> facilities;

  const BusModel({
    required this.modelName,
    required this.busClass,
    required this.facilities,
  });
}

class Schedule {
  final String busNumber;
  final String routeType;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final int seatsAvailable;
  final int priceNaira;
  final BusModel busModel;
  final BusDriver driver;
  final BusCrew crew;
  final int crewCount;

  const Schedule({
    required this.busNumber,
    required this.routeType,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.seatsAvailable,
    required this.priceNaira,
    required this.busModel,
    required this.driver,
    required this.crew,
    required this.crewCount,
  });
}

const _driverA = BusDriver(
  name: 'M. Toni Hernandez',
  avatarUrl: '/assets/images/avatar-2.jpeg',
);

const _driverB = BusDriver(
  name: 'Emeka Okafor',
  avatarUrl: '/assets/images/avatar-3.jpeg',
);

// -- mock crew --
const _crewA = BusCrew(
  name: 'Dicky Fernandez',
  avatarUrl: '/assets/images/avatar-2.jpeg',
);

const _crewB = BusCrew(
  name: 'Chukwuemeka Eze',
  avatarUrl: '/assets/images/avatar-3.jpeg',
);

// -- mock bus models --
const _busModelA = BusModel(
  modelName: 'Legacy SR3 XHD Prime',
  busClass: 'Executive',
  facilities: ['Meal Service', 'AC', 'WiFi', 'USB Charging'],
);

const _busModelB = BusModel(
  modelName: 'Higer KLQ6109GQ',
  busClass: 'Business',
  facilities: ['Snack Only', 'AC', 'USB Charging'],
);

const List<Schedule> mockSchedules = [
  Schedule(
    busNumber: 'GB 2201 LG',
    routeType: 'Via Express Direct',
    departureTime: '07:00',
    arrivalTime: '13:00',
    duration: '6 hours',
    seatsAvailable: 20,
    priceNaira: 18500,
    busModel: _busModelA,
    driver: _driverA,
    crew: _crewA,
    crewCount: 2,
  ),
  Schedule(
    busNumber: 'GB 2201 LG',
    routeType: 'Via Express Direct',
    departureTime: '09:00',
    arrivalTime: '15:00',
    duration: '6 hours',
    seatsAvailable: 38,
    priceNaira: 18500,
    busModel: _busModelA,
    driver: _driverA,
    crew: _crewA,
    crewCount: 2,
  ),
  Schedule(
    busNumber: 'GB 3107 AB',
    routeType: 'Via Toll Road',
    departureTime: '11:00',
    arrivalTime: '17:00',
    duration: '6 hours',
    seatsAvailable: 30,
    priceNaira: 17000,
    busModel: _busModelB,
    driver: _driverB,
    crew: _crewB,
    crewCount: 2,
  ),
  Schedule(
    busNumber: 'GB 3107 AB',
    routeType: 'Via Toll Road',
    departureTime: '14:00',
    arrivalTime: '20:00',
    duration: '6 hours',
    seatsAvailable: 40,
    priceNaira: 17000,
    busModel: _busModelB,
    driver: _driverB,
    crew: _crewB,
    crewCount: 2,
  ),
  Schedule(
    busNumber: 'GB 4502 KN',
    routeType: 'Via Express Direct',
    departureTime: '16:00',
    arrivalTime: '22:00',
    duration: '6 hours',
    seatsAvailable: 10,
    priceNaira: 19000,
    busModel: _busModelA,
    driver: _driverA,
    crew: _crewA,
    crewCount: 2,
  ),
];
