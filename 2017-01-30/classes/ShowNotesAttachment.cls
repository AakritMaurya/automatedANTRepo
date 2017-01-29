public class ShowNotesAttachment {
    public List<Attachment> atts {get;set;}
    private Id AccoundId ;
    public string pdfurl{get;set;}
    public string attachmentid1{get;set;}

    public ShowNotesAttachment(Apexpages.Standardcontroller controller)
    {

    AccoundId = Apexpages.currentPage().getParameters().get('Id');
    atts = [Select Id, Body, Name from Attachment WHERE ParentId=:AccoundId];
    system.debug('@@@@@@@' +atts.size() );
    }

    public void call()
    {
    AccoundId = Apexpages.currentPage().getParameters().get('Id');
    atts = [Select Id, Body, Name from Attachment WHERE ParentId='0019000000Rw45m'];
    system.debug('@@@@@@@' +atts.size() );
    }
    public void assignid()
    {
        system.debug('@@@@@@@' +attachmentid1 );
        pdfurl='/servlet/servlet.FileDownload?file='+attachmentid1;
    }
}