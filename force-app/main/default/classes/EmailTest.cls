public class EmailTest {
    
    public static void testmethodQQ(){
        // First, reserve email capacity for the current Apex transaction to ensure
            // that we won't exceed our daily email limits when sending email after
            // the current transaction is committed.
            Messaging.reserveSingleEmailCapacity(2);
        
        // Processes and actions involved in the Apex transaction occur next,
        // which conclude with sending a single email.
        
        // Now create a new single email message object
        // that will send out a single email to the addresses in the To, CC & BCC list.
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        // Strings to hold the email addresses to which you are sending the email.
        String[] toAddresses = new String[] {'aarushi.garg1994@gmail.com'}; 
                
                
       	// Assign the addresses for the To and CC lists to the mail object.
        mail.setToAddresses(toAddresses);
        
        // Specify the address used when the recipients reply to the email. 
        mail.setReplyTo('support@acme.com');
        mail.setTemplateId('00X0o000002Jmgs');
        mail.setTargetObjectId('0030o00003LZbjgAAD');
        // Specify the name used as the display name.
        mail.setSenderDisplayName('Salesforce Support');
        
        // Specify the subject line for your email address.
        mail.setSubject('New Case Created : ');
        
        // Set to True if you want to BCC yourself on the email.
        mail.setBccSender(false);
        
        // Optionally append the salesforce.com email signature to the email.
        // The email address of the user executing the Apex Code will be used.
        mail.setUseSignature(false);
        // Specify the text content of the email.
        mail.setPlainTextBody('Your Case: has been created.');
        
        //mail.setHtmlBody('Your case:<b> 0030o00003LZbjg </b>has been created.<p>'+
                       //  'To view your case <a href=https://yourInstance.salesforce.com/0030o00003LZbjg'+'>click here.</a>');
        mail.setHtmlBody('<img src="https://growth-all-dev-ed--c.documentforce.com/sfc/dist/version/renditionDownload?rendition=ORIGINAL_Jpg&versionId=0680o00000HfzJW&operationContext=DELIVERY&contentId=05T0o00000qxJmK&page=0&d=/a/0o000000Eq7F/PZ_9LvU2DV8o_EX_P2rqHH03ecKzOi4gWnqSfmCLrU0&oid=00D0o000001Anrz&dpt=null&viewId="/>');
        // Send the email you have created.
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    
}