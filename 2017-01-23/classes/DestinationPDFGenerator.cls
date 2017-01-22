public with sharing class DestinationPDFGenerator
{
    
    public static final String FORM_HTML_START = '<HTML><BODY>';
    public static final String FORM_HTML_END = '</BODY></HTML>';

    public static void generateDestinationPDF(Destination__c Destination)
    {
        String pdfContent = '' + FORM_HTML_START;
        try
        {
            pdfContent = '' + FORM_HTML_START;
            pdfContent = pdfContent + '<H2>Destination Information in PDF</H2>';
            
            //Dynamically grab all the fields to store in the PDF
            Map<String, Schema.SObjectType> sobjectSchemaMap = Schema.getGlobalDescribe();
            Schema.DescribeSObjectResult objDescribe = sobjectSchemaMap.get('Destination__c').getDescribe();
            Map<String, Schema.SObjectField> fieldMap = objDescribe.fields.getMap();
            string query = 'SELECT ' + string.join(new List<string>(objDescribe.Fields.getMap().keySet()), ',') + ' FROM '+ Destination + ' LIMIT 100';
            sobject [] records = Database.query(query);
            
            //Append each Field to the PDF
            /*
            for(Schema.SObjectField fieldDef : fieldMap.values()) 
            {
                Schema.Describefieldresult fieldDescResult = fieldDef.getDescribe();
                String name = fieldDescResult.getName();
                pdfContent = pdfContent + '<P>' + name + ': ' + account.get(name) + '</P>';
            } */
            pdfContent = pdfContent + FORM_HTML_END;
        }
        
        catch(Exception e)
        {
            pdfContent = '' + FORM_HTML_START;
            pdfContent = pdfContent + '<P>THERE WAS AN ERROR GENERATING PDF: ' + e.getMessage() + '</P>';
            pdfContent = pdfContent + FORM_HTML_END;
        }
        attachPDF(Destination,pdfContent);
    }
    
    public static void attachPDF(Destination__c Destination, String pdfContent)
    {
        try
        {
            Attachment attachmentPDF = new Attachment();
            attachmentPDF.parentId = Destination.Id;
            attachmentPDF.Name = Destination.Name + '.pdf';
            attachmentPDF.body = Blob.toPDF(pdfContent); //This creates the PDF content
            insert attachmentPDF;
        }catch(Exception e)
        {
            Destination.addError(e.getMessage());
        }
    }
    
}