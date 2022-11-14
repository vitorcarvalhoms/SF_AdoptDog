public with sharing class MarksAdopterWarning {
    
    //Filters the adoptions that are Red flagged
    public static List<Adoption__c> adoptionFilter(List<Adoption__c> listAdp, String flag) {
        
        List<Adoption__c> filteredAdoptions = new List<Adoption__c>();
        
        for (Adoption__c adp : listAdp){
            if (adp.flag__c == flag){
                filteredAdoptions.add(adp);
            }
        }    
        return filteredAdoptions;            
    }
    
    // Updates the Warning field on the Adopter object according to the Adoption Stage
    public static void marksAdopterWarning(List<Adoption__c> listAdp, boolean flag){
        
        List<Id> adoptersIds = new List<Id>();

        for (Adoption__c adoption : listAdp){
            adoptersIds.add(adoption.Adopter__c);
        }

        List<Adopter__c> adoptersList = [SELECT Warning__c FROM Adopter__c WHERE Id IN :adoptersIds];
        List<Adopter__c> adoptersToUpdate = new List<Adopter__c>();

        for (Adopter__c adopter : adoptersList){
            adopter.Warning__c = flag;
            adoptersToUpdate.add(adopter);
        }
        
        update adoptersToUpdate;
    }

    // Runs the class
    public static void run(List<Adoption__c> listAdp, String filter, boolean flag){

        List<Adoption__c> runAdoptions = adoptionFilter(listAdp, filter);
        marksAdopterWarning(runAdoptions, flag);
    }

}