({
    fetchAccounts: function(component) {
        var action = component.get("c.getAccounts");
        var pageNumber = component.get("v.currentPage");
        var pageSize = 10;

        action.setParams({
            pageNumber: pageNumber,
            pageSize: pageSize
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.accounts", response.getReturnValue());
                this.fetchAccountCount(component);
            }
        });
        $A.enqueueAction(action);
    },
    fetchContacts: function(component, accountId) {
        var action = component.get("c.getContacts");
        action.setParams({ accountId: accountId });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.contacts", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    fetchAccountCount: function(component) {
        var action = component.get("c.getAccountCount");

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var totalAccounts = response.getReturnValue();
                var pageSize = 10;
                component.set("v.totalPages", Math.ceil(totalAccounts / pageSize));
            }
        });
        $A.enqueueAction(action);
    },
    searchAccounts: function(component, searchTerm) {
        var action = component.get("c.searchAccounts");
        action.setParams({
            searchTerm: searchTerm
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.accounts", result.accounts);
                component.set("v.totalPages", result.totalPages);
            }
        });
        $A.enqueueAction(action);
    }
})