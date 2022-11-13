({
    clonarAvaliacao : function (component, event, helper){
        this.showSpinner(component);
        var action = component.get("c.clonarOrcamentoChurrasComAnexos");
        action.setParams({recordId : component.get("v.recordId")})

        action.setCallback(this, function(response){

            var state = response.getState();
            console.log(state);
            if(state === 'SUCCESS'){

                this.showToast('Sucesso!', 'Clonagem gerada com sucesso!', 'success');

                var OrcamentoChurras = response.getReturnValue();
                console.log('OrcamentoChurras' + OrcamentoChurras.Id);
                var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                    "recordId": OrcamentoChurras.Id
                });
                navEvt.fire();
            
            } else if (state === 'ERROR'){
                var errors = response.getError();
                
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        this.showToast('Erro!', errors[0].message, 'error');
                        $A.get("e.force:closeQuickAction").fire();
                        
                    }
                }
            }
			this.hideSpinner(component);
        });
        $A.enqueueAction(action);
        
    },

    showSpinner: function (component) {
		var spinner = component.find("mySpinner");
		$A.util.removeClass(spinner, "slds-hide");
	},

	hideSpinner: function (component) {
		var spinner = component.find("mySpinner");
		$A.util.addClass(spinner, "slds-hide");
	},

    showToast: function(title, msg, type, mode) {
		var toastEvent = $A.get("e.force:showToast");
		if(toastEvent == null)
			return;

		toastEvent.setParams({
			'title': title,
			'message': msg,
			'type': type,
			'mode': mode ? mode : 'dismissible'
		});
		toastEvent.fire();
	}
    
})

/* ({
    clonarAvaliacao : function(component) {
        this.showSpinner
        let idAvaliacao = component.get('v.recordId');
        var action = component.get('c.clonarAvaliacaoComAnexos');

        action.setParams({recordId : idAvaliacao})

        action.setCallback(this, function(response){

            var state = response.getState();
            console.log(state);
            if(state === 'SUCCESS'){
                var toastEvent = $A.get("e.force:showToast");

                toastEvent.setParams({
                    title: 'Success',
                    message: $A.get("Sucesso"),
                    duration: '2000',
                    key: 'info_alt',
                    type: 'success',
                    mode: 'pester'
                });

                toastEvent.fire();

                var avaliacao = response.getReturnValue();
                console.log('avaliacao' + avaliacao.Id);
                var navService = component.find("navService");
                var pageReference = {
                    type: 'standard__recordPage',
                    attributes: {
                        "recordId": avaliacao.Id,
                        "objectApiName": 'Avaliacao__c',
                        "actionName": "edit"
                    }
                }
                navService.navigate(pageReference);
            
            } else if (state === 'ERROR'){
                var errors = response.getError();
                
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            "title": "Error!",
                            "message": errors[0].message
                        });
                        toastEvent.fire();
                        
                    }
                }
            }

        })
        $A.enqueueAction(action);

    },

    showSpinner: function (component) {
		var spinner = component.find("mySpinner");
		$A.util.removeClass(spinner, "slds-hide");
	},

	hideSpinner: function (component) {
		var spinner = component.find("mySpinner");
		$A.util.addClass(spinner, "slds-hide");
	}
})
 */