public with sharing class MultiAttachmentController 
{

public Id sobjId {get; set;}
public Attachment attachment = new Attachment();

public List<Attachment> newAttachments {get; set;}

// this constructor should probably be removed since you don't want to reference a 
// std controller in a component controller unless absolutely necessary (assumes will work w/o it)
public MultiAttachmentController(ApexPages.StandardController controller) {
    newAttachments = new List<Attachment>();
    newAttachments.add(attachment);
}

public MultiAttachmentController()
{  
    newAttachments = new List<Attachment>();
    newAttachments.add(attachment);
}   


public void addMore()
{
    Attachment newAttach = new Attachment();
    newAttachments.add(newAttach);

}    

// Save action method
public void save()
{
    List<Attachment> toInsert=new List<Attachment>();
    for (Attachment newAtt : newAttachments)
    {
        if (newAtt.Body!=null)
        {
            newAtt.parentId=sobjId;
            toInsert.add(newAtt);
        }
    }
    try{
        insert toInsert;
        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Inserted Attachments successfully'));
    }
    catch(Exception e){
        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Exception'));
    }

}
}