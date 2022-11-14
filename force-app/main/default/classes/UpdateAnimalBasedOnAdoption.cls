public with sharing class UpdateAnimalBasedOnAdoption {
    
    //Filters the adoptions that are checked as Adopted
    public static List<Adoption__c> adoptionFilter(List<Adoption__c> listAdp, String stage) {
        
        List<Adoption__c> filteredAdoptions = new List<Adoption__c>();
        
        for (Adoption__c adp : listAdp){
            if (adp.Stage__c == stage){
                filteredAdoptions.add(adp);
            }
        }    
        System.debug('filteredAdoptions: ' + filteredAdoptions);
        return filteredAdoptions;            
    }

    // Updates the Stage field on the Animal object according to the Adoption Stage
    public static void updatesAnimalStage(List<Adoption__c> listAdp, String stage){
        
        List<Id> animalsIds = new List<Id>();

        for (Adoption__c adoption : listAdp){
            animalsIds.add(adoption.Animal__c);
        }
        System.debug('animalsIds: ' + animalsIds);
        List<Animal__c> animalsList = [SELECT Stage__c FROM Animal__c WHERE Id IN :animalsIds];
        List<Animal__c> animalsToUpdate = new List<Animal__c>();
        System.debug('animalsList: ' + animalsList);
        for (Animal__c animal : animalsList){
            animal.Stage__c = stage;
            animalsToUpdate.add(animal);
        }
        System.debug('animalsToUpdate: ' + animalsToUpdate);
        update animalsToUpdate;
    }

     // Runs the class
     public static void run(List<Adoption__c> listAdp, String filter, String flag){

        List<Adoption__c> runAdopted = adoptionFilter(listAdp, 'Adopted');
        updatesAnimalStage(runAdopted, 'Adopted');

        List<Adoption__c> runBackToShelter = adoptionFilter(listAdp, 'Back To Shelter');
        updatesAnimalStage(runBackToShelter, 'Ready For Adoption');
    }
}
