public with sharing class closingChecklistController {
    @AuraEnabled
    public static String getUserName() {
        return UserInfo.getName();
    }

    @AuraEnabled( cacheable = true )
    public static Map<String,List<Task>> fetchTasks(String offeringId) {
        Map<String,List<Task>> taskMap = new Map<String,List<Task>>();
        for( Task tsk:[SELECT Id, Closing_Checklist_Category__c, Applicable__c, Subject, Status, Description FROM Task WHERE whatId =:offeringId ORDER BY Closing_Checklist_Category__c desc] ){
            if( !taskMap.containsKey( tsk.Closing_Checklist_Category__c ) ){
                taskMap.put( tsk.Closing_Checklist_Category__c, new List<Task>() );
                taskMap.get( tsk.Closing_Checklist_Category__c ).add( tsk );
            }
            else{
                taskMap.get( tsk.Closing_Checklist_Category__c ).add( tsk );
            }
        }
        return taskMap;
         
    }

    @AuraEnabled        
    public static Map<String,Map<String,String>> getPicklistValues(String objectAPIName, String[] fieldAPINames){
        Map<String,Map<String,String>> pickListValuesMap = new Map<String,Map<String,String>>();
        Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get(objectAPIName);
        Schema.DescribeSObjectResult descResult = convertToObj.getDescribe();
        
        for (String fieldAPIName : fieldAPINames) {
            pickListValuesMap.put(fieldAPIName, new Map<String, String>{});
            Schema.DescribeFieldResult fieldResult = descResult.fields.getMap().get(fieldAPIName).getDescribe();
            Boolean isFieldNotRequired = fieldResult.isNillable();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            for(Schema.PicklistEntry pickListVal : ple){
                // if(isFieldNotRequired)
                //     pickListValuesMap.get(fieldAPIName).put('--None--', '');
                if(pickListVal.isActive())
                    pickListValuesMap.get(fieldAPIName).put(pickListVal.getLabel(), pickListVal.getValue());
            }
        }

        return pickListValuesMap;
    }

    @AuraEnabled
    public static List<Task> updateRecords(String jsonString){
        try{
            List<Task> records = (List<Task>) JSON.deserialize(jsonString, List<Task>.class);
            system.debug(records);
            system.debug(jsonString);

            update records;

            return records;
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
}