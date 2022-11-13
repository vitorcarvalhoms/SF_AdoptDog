public with sharing class MarksAdopterWarning {
    public static List<Adoption__c> adoptionFilter(List<Adoption__c> listAdp) {
        
        List<Adoption__c> filteredAdoptions = new List<Adoption__c>();
        
        for (Adoption__c adp : listAdp){
            if (adp.flag__c == 'Red'){
                filteredAdoptions.add(adp);
            }
        }    
        return filteredAdoptions;            
    }
    
    public static void marksAdopterWarning(List<Adoption__c> listAdp){
        
        List<Id> adoptersIds = new List<Id>();

        for (Adoption__c adoption : listAdp){
            adoptersIds.add(adoption.Adopter__c);
        }

        List<Adopter__c> adoptersList = [SELECT Warning__c FROM Adopter__c WHERE Id IN :adoptersIds];
        List<Adopter__c> adoptersToUpdate = new List<Adopter__c>();

        for (Adopter__c adopter : adoptersList){
            adopter.Warning__c = true;
            adoptersToUpdate.add(adopter);
        }
        
        update adoptersToUpdate;
    }

    public static void run(List<Adoption__c> listAdp){
        List<Adoption__c> runAdoptions = adoptionFilter(listAdp);
        marksAdopterWarning(runAdoptions);
    }

}