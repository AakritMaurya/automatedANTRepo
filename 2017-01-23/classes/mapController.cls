public with sharing class mapController {
public String searchText {get;set;}
public List<Contact> contacts{get; private set;}

public static final String GEOCODING_URI_BASE = 'https://maps.googleapis.com/maps/api/geocode/json?sensor=false&address=';

// For purposes of this demo I'll geocode only couple of addresses server-side. Real code can use the commented out value.
public static final Integer MAX_CALLOUTS_FROM_APEX = 3; // Limits.getLimitCallouts()

public mapController(){
    searchText = ApexPages.currentPage().getParameters().get('q');
}

public void find() {
    if(searchText != null && searchText.length() > 1){
        List<List<SObject>> results = [FIND :('*' + searchText + '*') IN ALL FIELDS RETURNING 
            Contact (Id, Name, Email, Account.Name,
                MailingStreet, MailingCity, MailingPostalCode, MailingState, MailingCountry, 
                Location__Latitude__s, Location__Longitude__s)
            ];
        contacts = (List<Contact>)results[0];
        if(contacts.isEmpty()){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'No matches for "' + searchText + '"'));
        } else {
            serverSideGeocode();
        }
    } else {
        if(contacts != null) {
            contacts.clear();
        }
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Please provide at least 2 characters for the search.'));
    }
}

public void clearGeocodedData(){
    for(Contact c : contacts){
        c.Location__Latitude__s = c.Location__Longitude__s = null;
    }
    Database.update(contacts, false);
    contacts.clear();
}

public String getContactsJson(){
    return JSON.serialize(contacts);
}
public String getDebugContactsJson(){
    return JSON.serializePretty(contacts);
}

private void serverSideGeocode(){
    List<Contact> contactsToUpdate = new List<Contact>();
    Http h = new Http();  
    HttpRequest req = new HttpRequest();
    req.setMethod('GET'); 
    req.setTimeout(10000);

    for(Contact c : contacts){
        if((c.Location__Latitude__s == null || c.Location__Longitude__s == null)){
            String address = c.MailingStreet != null ? c.MailingStreet + ' ' : '' +
                c.MailingCity != null ? c.MailingCity + ' ' : '' +
                c.MailingState != null ? c.MailingState + ' ' : '' +
                c.MailingPostalCode != null ? c.MailingPostalCode + ' ' : '' +
                c.MailingCountry != null ? c.MailingCountry : '';
            if(address != ''){
                req.setEndpoint(GEOCODING_URI_BASE + EncodingUtil.urlEncode(address, 'UTF-8'));
                try{
                    HttpResponse res = h.send(req);
                    GResponse gr = (GResponse) JSON.deserialize(res.getBody(), mapController.GResponse.class);
                    if(gr.status == 'OK'){
                        LatLng ll = gr.results[0].geometry.location;
                        c.Location__Latitude__s = ll.lat;
                        c.Location__Longitude__s = ll.lng;
                        contactsToUpdate.add(c);
                    } else {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Geocoding of "' + address + '" failed:' + gr.status));
                    }
                }catch(Exception e){
                    ApexPages.addMessages(e);
                }
            }
            // Bail out if we've reached limit of callouts (not all contacts might have been processed).
            if(Limits.getCallouts() == MAX_CALLOUTS_FROM_APEX) {
                break;
            }
        }
    }
    if(!contactsToUpdate.isEmpty()) {
        Database.update(contactsToUpdate, false); // some data in Developer editions is invalid (on purpose I think).
        // If update fails because "j.davis@expressl&amp;t.net" is not a valid Email, I want the rest to succeed
    }
}

// Helper class - template into which results of lookup will be parsed. Some fields are skipped!
public class GResponse{
    public String status;
    public GComponents[] results;
}
public class GComponents{
   public String formatted_address;
   public GGeometry geometry;
}
public class GGeometry {
    public LatLng location;
}
public class LatLng{
    public Double lat, lng;
}
}