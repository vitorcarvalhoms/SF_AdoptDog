trigger AdoptionTrigger on Adoption__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    if(Trigger.isExecuting && Trigger.isBefore && Trigger.isInsert) {

    } else if(Trigger.isExecuting && Trigger.isBefore && Trigger.isUpdate){

    } else if(Trigger.isExecuting && Trigger.isBefore && Trigger.isDelete){

    } else if(Trigger.isExecuting && Trigger.isAfter && Trigger.isInsert){

        
    } else if(Trigger.isExecuting && Trigger.isAfter && Trigger.isUpdate){
        
        MarksAdopterWarning.run(Trigger.new, 'Red', true);
        UpdateAnimalBasedOnAdoption.run(Trigger.new, 'Adopted', 'Adopted');
        UpdateAnimalBasedOnAdoption.run(Trigger.new, 'Back To Shelter', 'Ready For Adoption');

    } else if(Trigger.isExecuting && Trigger.isAfter && Trigger.isDelete){

    } else if(Trigger.isExecuting && Trigger.isAfter && Trigger.isUndelete){
      
    }

}