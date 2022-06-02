trigger TriggerCase on Case (before insert, before update) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){
            CaseBO.setTempoDiasUteis(trigger.new, trigger.old, trigger.oldMap, trigger.newMap);

        }
        
        if(Trigger.isUpdate){
            CaseBO.setTempoDiasUteis(trigger.new, trigger.old, trigger.oldMap, trigger.newMap);
        }
        
    }
}