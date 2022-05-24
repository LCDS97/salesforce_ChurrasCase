trigger TriggerItensOrcamento on ItemOrcamentoChurras__c (before insert) {

        if(Trigger.operationType == TriggerOperation.BEFORE_INSERT) {
            ItemOrcamentoChurrasBO.validarSePossuiItemDuplicado(Trigger.new);
        }

}