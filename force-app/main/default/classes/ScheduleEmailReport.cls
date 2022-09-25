global with sharing class ScheduleEmailReport implements schedulable {
    global void execute(SchedulableContext SC){
        scheduleJob();
    }
    
    @future(callout=true)
    private static void scheduleJob(){
        list<String> reportNames = new list<string>{'Contact_Mailing_List_Report','Contact_Mailing_List_Report_2'};
            
            List <Report> reportList = [SELECT Id,DeveloperName,Name FROM Report where DeveloperName IN: reportNames ];
        System.debug(reportList);
        List<Messaging.SingleEmailMessage> lstEmail = new List<Messaging.SingleEmailMessage>();
        String[] reportId = new String[reportList.size()];
        String[] reportname = new String[reportList.size()];
        
        for(Integer i=0;i < reportList.size();i++){
            
            //Getting record on the basis of Report Id and putting it into Excel as attachment.
            reportId[i] = (String)reportList.get(i).get('Id');
            reportname[i] = (String)reportList.get(i).get('Name');
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            List< Messaging.EmailFileAttachment> lstAttachment = new List< Messaging.EmailFileAttachment>();
            
            ApexPages.PageReference report = new ApexPages.PageReference( '/' + reportId[i] + '?excel=1'); // or csv=1
            Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
            System.debug('---report--'+ report);
            
            
            attachment.setFileName(reportname[i] + '.xls');
            Blob content = !Test.isRunningTest() ? report.getContent() : Blob.valueOf('Test');
            attachment.setBody(content);
            attachment.setContentType('application/vnd.ms-excel'); //  or text/csv
            lstAttachment.add(attachment);
            
            message.setFileAttachments(lstAttachment);
            message.setSubject('Report: ' + reportname[i] +' report run at '+ System.Now().format());
            message.setHtmlBody(content.toString());
            //message.setHtmlBody('Reports are attached as an attachment');
            
            message.setToAddresses( new String[] {'aarushi@kcloudtechnologies.com'} );
            System.debug('Send --'+ message);   
            lstEmail.add(message); 
        }         
        
        
        
        if(!lstEmail.isEmpty()){
            Messaging.sendEmail(lstEmail ); 
        }
    }
}