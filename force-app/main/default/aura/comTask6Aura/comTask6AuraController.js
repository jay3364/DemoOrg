({
    navigateHome: function(component, event, helper) {
        window.location.href = component.get("v.homeUrl");
    },
    navigateProfile: function(component, event, helper) {
        window.location.href = component.get("v.profileUrl");
    },
    navigateLogout: function(component, event, helper) {
        window.location.href = component.get("v.logoutUrl");
    }
})