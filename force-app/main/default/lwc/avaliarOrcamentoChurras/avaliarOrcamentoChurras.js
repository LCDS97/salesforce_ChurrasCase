import { LightningElement, api, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord, getFieldValue, getRecordNotifyChange } from 'lightning/uiRecordApi';

import buscarAvaliacoesPorOrcamentoService from '@salesforce/apex/AvaliarChurrasController.buscarAvaliacoesPorOrcamentoChurras';

const FIELDS = [
    'OrcamentoChurras__c.Contato__c'
];

export default class AvaliarOrcamentoChurras extends LightningElement {

    @api recordId;

     @wire(getRecord, { recordId: '$recordId', fields: FIELDS})  orcamento;


    get avaliadorAtual(){
        return getFieldValue(this.orcamento.data, FIELDS[0]);
    }

    @track lstAvaliacoes = [];
    @track lstAvaliacoesFiltradas = [];
    @track apresentarAvaliacoes = true;

    connectedCallback(){
        this.carregarAvaliacoes(this.recordId);
        getRecordNotifyChange([{recordId: this.recordId}]);
    }

    carregarAvaliacoes(idOrcamentoChurras){
        buscarAvaliacoesPorOrcamentoService({ idOrcamentoChurras })
            .then(response => {
                if(!response.sucesso || response.lstObject.length == 0){
                    this.apresentarAvaliacoes = false;

                }

                this.lstAvaliacoes = response.lstAvaliacoes;
                this.lstAvaliacoesFiltradas = response.lstObject;

            })
            .catch(error => {
                console.log(error);
            })
            

            
    }

    handleSuccess(event){
        this.showToast();
        this.handleReset();
        this.atualizarTela();
        
        

    }

    handleReset(event) {
        const inputFields = this.template.querySelectorAll(
            '.avaliacaoResetar'
        );
        if (inputFields) {
            inputFields.forEach(field => {
                field.reset();
            });
        }
    }

    showToast() {
        const event = new ShowToastEvent({
            title: 'Sucesso!',
            message: 'Sua avaliação foi inserida com sucesso!',
            variant: 'success'
        });
        this.dispatchEvent(event);
    }

    atualizarTela() {
        eval("$A.get('e.force:refreshView').fire()");
    }


}