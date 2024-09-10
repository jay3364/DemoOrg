({
    doInit: function(component, event, helper) {
        helper.fetchAccounts(component);
    },
    previousPage: function(component, event, helper) {
        var currentPage = component.get("v.currentPage");
        component.set("v.currentPage", currentPage - 1);
        helper.fetchAccounts(component);
    },
    nextPage: function(component, event, helper) {
        var currentPage = component.get("v.currentPage");
        component.set("v.currentPage", currentPage + 1);
        helper.fetchAccounts(component);
    },
    searchHandle: function(component, event, helper) {
        helper.searchAccounts(component, event.getSource().get("v.value"));
    },
    selectAccount: function(component, event, helper) {
        var accountId = event.currentTarget.dataset.id;
        component.set("v.selectedAccountId", accountId);
        helper.fetchContacts(component, accountId);
    }
})