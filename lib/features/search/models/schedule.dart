class Schedule {
  final String busNumber;
  final String routeType;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final int seatsAvailable;
  final int priceNaira;

  const Schedule({
    required this.busNumber,
    required this.routeType,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.seatsAvailable,
    required this.priceNaira,
  });
}

const List<Schedule> mockSchedules = [
  Schedule(
    busNumber: 'GB 2201 LG',
    routeType: 'Via Express Direct',
    departureTime: '07:00',
    arrivalTime: '13:00',
    duration: '6 hours',
    seatsAvailable: 20,
    priceNaira: 18500,
  ),
  Schedule(
    busNumber: 'GB 2201 LG',
    routeType: 'Via Express Direct',
    departureTime: '09:00',
    arrivalTime: '15:00',
    duration: '6 hours',
    seatsAvailable: 38,
    priceNaira: 18500,
  ),
  Schedule(
    busNumber: 'GB 3107 AB',
    routeType: 'Via Toll Road',
    departureTime: '11:00',
    arrivalTime: '17:00',
    duration: '6 hours',
    seatsAvailable: 30,
    priceNaira: 17000,
  ),
  Schedule(
    busNumber: 'GB 3107 AB',
    routeType: 'Via Toll Road',
    departureTime: '14:00',
    arrivalTime: '20:00',
    duration: '6 hours',
    seatsAvailable: 40,
    priceNaira: 17000,
  ),
  Schedule(
    busNumber: 'GB 4502 KN',
    routeType: 'Via Express Direct',
    departureTime: '16:00',
    arrivalTime: '22:00',
    duration: '6 hours',
    seatsAvailable: 10,
    priceNaira: 19000,
  ),
  Schedule(
    busNumber: 'GB 2201 LG',
    routeType: 'Via Express Direct',
    departureTime: '07:00',
    arrivalTime: '13:00',
    duration: '6 hours',
    seatsAvailable: 20,
    priceNaira: 18500,
  ),
  Schedule(
    busNumber: 'GB 2201 LG',
    routeType: 'Via Express Direct',
    departureTime: '09:00',
    arrivalTime: '15:00',
    duration: '6 hours',
    seatsAvailable: 38,
    priceNaira: 18500,
  ),
  Schedule(
    busNumber: 'GB 3107 AB',
    routeType: 'Via Toll Road',
    departureTime: '11:00',
    arrivalTime: '17:00',
    duration: '6 hours',
    seatsAvailable: 30,
    priceNaira: 17000,
  ),
  Schedule(
    busNumber: 'GB 3107 AB',
    routeType: 'Via Toll Road',
    departureTime: '14:00',
    arrivalTime: '20:00',
    duration: '6 hours',
    seatsAvailable: 40,
    priceNaira: 17000,
  ),
  Schedule(
    busNumber: 'GB 4502 KN',
    routeType: 'Via Express Direct',
    departureTime: '16:00',
    arrivalTime: '22:00',
    duration: '6 hours',
    seatsAvailable: 10,
    priceNaira: 19000,
  )
];
