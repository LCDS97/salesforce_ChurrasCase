trigger TriggerItensOrcamento on ItemOrcamentoChurras__c (before insert, before update) {

        
        if(Trigger.isBefore){
            if(Trigger.isInsert){
                ItemOrcamentoChurrasBO.validarSePossuiItemDuplicado(Trigger.new);
                ItemOrcamentoChurrasBO.preencherValorAutomatico(Trigger.new);
            }
            
            if(Trigger.isUpdate){
                ItemOrcamentoChurrasBO.preencherValorAutomatico(Trigger.new);
            }
            
        }

}