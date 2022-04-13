public with sharing class EventSpeakerHandler {
    public static void checkDuplicateSpeakerOnEvents(List<Event_Speaker__c> eventSpeakers){
        // 	Eventt__c + Speaker__c (a068d000003jDG3AAM + a048d0000011oGhAAI )
        Map<String,Event_Speaker__c> eventSpeakersMap = new Map<String,Event_Speaker__c>();

        Set<Id> eventIds =  new Set<Id>();
        Set<Id> speakerIds =  new Set<Id>();
        
        for(Event_Speaker__c es : eventSpeakers){
            String uniqueKey = String.valueOf(es.Eventt__c) + String.valueOf(es.Speaker__c);
            eventSpeakersMap.put(uniqueKey, es);

            eventIds.add(es.Eventt__c);
            speakerIds.add(es.Speaker__c);
        }

        List<Event_Speaker__c> onSystenRecords = [SELECT Id, Eventt__c, Speaker__c
                                                  FROM Event_Speaker__c
                                                  WHERE Eventt__c IN: eventIds
                                                  AND Speaker__c IN: speakerIds
                                                  ];
        for(Event_Speaker__c sys : onSystenRecords){
            String uniqueKey = String.valueOf(sys.Eventt__c) + String.valueOf(sys.Speaker__c);

            Event_Speaker__c checkingObject = eventSpeakersMap.get(uniqueKey);
            if(checkingObject == null) continue;
            checkingObject.addError('Found a duplicate Event Speaker record on the system with id: ' + String.valueOf(sys.Id));
        }
    }
}
