global class InboundEmailHandler implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        String myPlainText= '';
        myPlainText = email.plainTextBody;
        system.debug('Email body --'+myPlainText);
        
        Task[] newTask = new Task[0];
        
        try {
            list<Contact> conList = [SELECT Id, Name, Email FROM Contact WHERE Email = :email.fromAddress ];
            if(conList.size() > 0){
                for(Contact con : conList){
                    // Add a new Task to the contact record we just found above.
                    newTask.add(new Task(Description =  myPlainText,
                                         Priority = 'Normal',
                                         Status = 'Inbound Email',
                                         Subject = 'EMAIL: '+email.subject,
                                         IsReminderSet = true,
                                         ReminderDateTime = System.now()+1,
                                         WhoId =  con.Id)); 
                }
                
                
            }else{
                for(Lead lead : [SELECT Id, Name, Email FROM Lead WHERE Email = :email.fromAddress ]){
                    // Add a new Task to the lead record we just found above.
                    newTask.add(new Task(Description =  myPlainText,
                                         Priority = 'Normal',
                                         Status = 'Inbound Email',
                                         Subject = 'EMAIL: '+email.subject,
                                         IsReminderSet = true,
                                         ReminderDateTime = System.now()+1,
                                         WhoId =  lead.Id)); 
                }
                
            }
            
            if(newTask.size() > 0){
                insert newTask;    
            }
            
            System.debug('New Task Object: ' + newTask );
            
        }
        // If an exception occurs when the query accesses 
        // the contact record, a QueryException is called.
        // The exception is written to the Apex debug log.
        catch (QueryException e) {
            System.debug('Query Issue: ' + e);
        }
        
        // Set the result to true. No need to send an email back to the user 
        // with an error message
        result.success = true;
        
        // Return the result for the Apex Email Service
        return result;
    }
}