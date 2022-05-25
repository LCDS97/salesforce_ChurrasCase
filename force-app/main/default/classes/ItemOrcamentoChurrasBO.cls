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

    public static void preencherValorAutomatico(List<ItemOrcamentoChurras__c> lstItensOrcamentosNovo){
        TabelaPrecosServicos__mdt valorChurrasqueiro = TabelaPrecosServicos__mdt.getInstance('ServicoChurrasqueiro');
        Decimal valorHoraChurrasqueiro = valorChurrasqueiro.ValorHoraServico__c;

        TabelaPrecosServicos__mdt valorGarcom = TabelaPrecosServicos__mdt.getInstance('ServicoGarcom');
        Decimal valorHoraGarcom = valorGarcom.ValorHoraServico__c;

        TabelaPrecosServicos__mdt valorLimpeza = TabelaPrecosServicos__mdt.getInstance('ServicoLimpeza');
        Decimal valorHoraLimpeza = valorLimpeza.ValorHoraServico__c;

        List<ItemOrcamentoChurras__c> lstItensComProduto = new List<ItemOrcamentoChurras__c>();
        List<Product2> lstProdutoTipoProduto = new List<Product2>();
        List<Product2> lstProdutoTipoServico = new List<Product2>();
        Set<Id> setIdsProdutos = new Set<Id>();

        for(ItemOrcamentoChurras__c item : lstItensOrcamentosNovo){
            if(item.Produto__c != null){
                lstItensComProduto.add(item);
                setIdsProdutos.add(item.Produto__c);
            }
        }
        System.debug('############ LST Itens com Produto' + lstItensComProduto);

        if(lstItensComProduto.isEmpty()) return;

        List<Product2> verificarTipoRegistroProduto = Product2DAO.buscarProdutosTipoRegistro(setIdsProdutos);
        
        for(Product2 produto : verificarTipoRegistroProduto){
            if(produto.RecordTypeId == '0128a000001ANe0AAG'){  // Record Type Id = Produto
                //lstProdutoTipoProduto.add(produto);
                for(ItemOrcamentoChurras__c itemOrcamento : lstItensComProduto){
                    System.debug('###### antes do soma Orcamento Nome: ' + itemOrcamento.Name);
                    System.debug('###### antes do soma Orcamento Item: ' + itemOrcamento.Valor__c);
                    if(itemOrcamento.Valor__c == null && itemOrcamento.Quantidade__c == null){
                        itemOrcamento.Valor__c = 0;
                        itemOrcamento.Quantidade__c = 0;
                        itemOrcamento.Valor__c = itemOrcamento.Quantidade__c * produto.Valor__c;
                    } else {
                        itemOrcamento.Valor__c = itemOrcamento.Quantidade__c * produto.Valor__c;
                    }
                    System.debug('###### Depois da soma Orcamento Item: ' + itemOrcamento.Valor__c);
                }

            }
            
            if(produto.RecordTypeId == '0128a000001ANcgAAG') lstProdutoTipoServico.add(produto); // Record Type Id = Serviço
        }
        

    }

}
