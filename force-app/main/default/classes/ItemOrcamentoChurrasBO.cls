public with sharing class ItemOrcamentoChurrasBO {
    
    public static void validarSePossuiItemDuplicado(List<ItemOrcamentoChurras__c> lstItensOrcamentosNovo){
        Set<Id> setOrcamentosId = new Set<Id>();
        Set<Id> setProdutosItemOrcamentoId = new Set<Id>();
        List<ItemOrcamentoChurras__c> lstItensOrcamentosComProduto = new List<ItemOrcamentoChurras__c>();

        for(ItemOrcamentoChurras__c item : lstItensOrcamentosNovo){
            if(item.Produto__c != null){
                setProdutosItemOrcamentoId.add(item.Produto__c);
                setOrcamentosId.add(item.OrcamentoChurras__c);
                lstItensOrcamentosComProduto.add(item);
            }
        }

        if(lstItensOrcamentosNovo.isEmpty()) return;

        List<ItemOrcamentoChurras__c> lstProdutoRepetidoItemOrcamento = ItemOrcamentoChurrasDAO.buscarItemOrcamentoPorIdEProduto(setOrcamentosId,setProdutosItemOrcamentoId);

        for(ItemOrcamentoChurras__c produto : lstItensOrcamentosComProduto){
            if(lstProdutoRepetidoItemOrcamento.size() > 1){
                produto.Produto__c.addError('Não é possível cadastrar esse produto, pois ele ja consta em um Item de Orçamento');
            }
        }

    }
}
