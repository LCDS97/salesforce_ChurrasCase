/**
 * @Descrição                : Trigger para objeto de Case
 * @Empresa:                 : Everymind LTDA.
 * @Ultima modificação em:   : [05, 06, 2022]
 * @Ultima modificação por:  : Lucas Conceição dos Santos / lucas.santos@everymind.com.br
**/
trigger TriggerCase on Case (before insert, before update) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){
            CaseBO.setTempoDiasUteis(trigger.new, trigger.oldMap);

        }
        
        if(Trigger.isUpdate){
            CaseBO.setTempoDiasUteis(trigger.new, trigger.oldMap);
        }
        
    }
}