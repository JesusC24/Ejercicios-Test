@isTest
/**
 * Clase que crea diferentes registros del objecto para poder usarlos en los test
 */
public with sharing class TestFlightBookingFactory {
    public static List<FlightBookings__c> createFlightBooking(Integer veces) {
        List<FlightBookings__c> flights = new List<FlightBookings__c>();

        //se crean vuelos de ejemplo para el test
        for(Integer i=0; i<veces; i++) {
            FlightBookings__c flight = new FlightBookings__c(Origin__c = 'Paris', Destination__c = 'London', DepartureDate__c = Datetime.now().addDays(10));
            flights.add(flight);
        }

        insert flights;
        return flights;
    }
}
