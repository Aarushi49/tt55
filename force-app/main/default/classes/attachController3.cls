public class attachController3 {
   
    public List<Attachment> fileList {get; set;}
    public Attachment attach {get; set;}
        
    public attachController3() {
     
     attach = new Attachment();
     fileList = new List<Attachment>();
     fileList.add(attach);
     //AddAttachs();
    }
    
  
    
      public List<Attachment> getAttachments(){
      if(fileList == null) 
      fileList = new List<Attachment>();
        return fileList; 
     }
     
     public PageReference AddAttachs() {
        fileList.add(new Attachment());
        return null;
      }
  }