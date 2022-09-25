global class Accounts_Weekly_Report implements System.Schedulable {
    
    global void execute(SchedulableContext SC){
        scheduleJob();
    }
    
    
    @future(callout=true)
    private static void scheduleJob(){
        Report reportRec = [SELECT Id,DeveloperName FROM Report where DeveloperName = 'Contact_Mailing_List_Report' ];
        
        
        ApexPages.PageReference report = new ApexPages.PageReference('/' + reportRec.id + '?excel=1');
        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.setFileName('Accounts_Weekly_Report.csv');
        attachment.setBody(report.getContent());
        attachment.setContentType('text/csv');
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment } );
        message.setSubject('Accounts Weekly Report');
        message.setPlainTextBody('The report is attached.');
        message.setToAddresses( new String[] { 'aarushi@kcloudtechnologies.com' } );
        message.setCcAddresses(new String[] { 'aarushi.garg1994@gmail.com'});
        Messaging.sendEmail( new Messaging.SingleEmailMessage[] { message } );
        
    }
    
}