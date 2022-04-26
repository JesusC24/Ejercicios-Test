@iSTest
public with sharing class TestFlightBookingIntegration {
    @isTest static void testCheckModify() {
        List<FlightBookings__c> flights = TestFlightBookingFactory.createFlightBooking(2);

        Test.startTest();

        flights[0].Destination__c = 'Rome';
        upsert flights[0];

        Database.UpsertResult result = Database.upsert(flights[0]);

        Test.stopTest();
        
        //comparamos si el flightbooking que ha sido insertado, tiene marcado la casilla modified
        System.assertEquals(true, [select Modified__c from FlightBookings__c where Id = :flights[0].Id].get(0).Modified__c ,'Is correct that is check Modyfy');
        
    }
}
