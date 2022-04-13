@isTest
private class TestEventSpeakerHandler {
   @TestSetup
   static void prepareData(){
    Event_Organizer__c organizer = new 	Event_Organizer__c(Name = 'Organizar 1',
                                                            Email__c = 'testorganizer1@test.com',
                                                            Phone__c =  '987654321');

    insert organizer;
    Eventt__c event = new Eventt__c(Event_Organizer__c = organizer.Id,
                                    Name__c = 'Test Event',
                                    Status__c = 'In Progress',
                                    Start_Date_Time__c = Datetime.now().addDays(-14),
                                    End_Date_Time__c = Datetime.now().addDays(14),
                                    Max_Seats__c = 10,
                                    Event_Type__c = 'Virtual',
                                    Live__c = true
                                    );
    
    insert event;

    Speaker__c speaker1 = new Speaker__c(Name = 'Sertug',
                                        Email__c = 'canturkdk@gmail.com',
                                        Phone__c = '+447465764845');
       
    Speaker__c speaker2 = new Speaker__c(Name = 'Aysegul',
                                        Email__c = 'canturk@gmail.com',
                                        Phone__c = '+447465764835');
       
     insert new List<Speaker__c>{speaker1, speaker2};
     insert new Event_Speaker__c(Eventt__c = event.Id, Speaker__c = speaker1.Id);
   }
   @isTest
   static void testPositive(){
    Event_Speaker__c eventSpeaker = [SELECT Id, Eventt__c, Speaker__c FROM Event_Speaker__c LIMIT 1 ];

    Boolean isFailed =false;
   try {
    Event_Speaker__c newRecord = new Event_Speaker__c(Eventt__c =eventSpeaker.Eventt__c, Speaker__c = eventSpeaker.Speaker__c);
    insert newRecord;
   } catch (Exception exc) {
       isFailed = true;
   }
   System.assert(isFailed);
   }

   @isTest
   static void testNegative(){
       Eventt__c event =[SELECT Id FROM Eventt__c WHERE Name__c = 'Test Event' LIMIT 1];
       Speaker__c speaker2 =[SELECT Id FROM Speaker__c WHERE Name = 'Aysegul' LIMIT 1];

       Event_Speaker__c newRecord = new Event_Speaker__c(Eventt__c =event.Id, Speaker__c = speaker2.Id);
       insert newRecord;

       System.assertNotEquals(newRecord.Id, null);
   }


}
