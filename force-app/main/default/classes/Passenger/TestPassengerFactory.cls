@isTest
public with sharing class TestPassengerFactory {
    public static List<Passenger__c> createPassenger(Integer veces, Boolean errorNif) {
        List<Passenger__c> passengers = new List<Passenger__c>();
        //Es obligatio que cada pasajero tenga un vuelo
        FlightBookings__c bookingExample = TestFlightBookingFactory.createFlightBooking(1).get(0);

        for(Integer i=0; i<veces; i++) {
            Passenger__c passenger = new Passenger__c(PassengerName__c = 'Test ' + i, Booking__c = bookingExample.Id);

            if(errorNif) {
                passenger.IDCard__c = '12345678A'; //NIF ERRONEO
            } else {
                passenger.IDCard__c = '12345678Z'; //NIF BUENO
            }
            
            passengers.add(passenger);
        }

        return passengers;
    }

    public static Passenger__c createPassengerWithNifInContact(String nif) {
        FlightBookings__c bookingExample = TestFlightBookingFactory.createFlightBooking(1).get(0);
        Passenger__c passenger = new Passenger__c(PassengerName__c = 'Test 0', Booking__c = bookingExample.Id, IDCard__c = nif);

        Contact contact = new Contact(LastName = 'Test 0', NIF__c = nif); //contacto con el mismo nif que el pasajero
        insert contact;

        return passenger;
    }
}
