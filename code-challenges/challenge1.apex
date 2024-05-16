public virtual class AccountSelector {
    public virtual Account getAccountById(Id accountId) {
        return [SELECT Id, Name, Rating FROM Account WHERE Id = :accountId];
    }
}

public class OpportunityDiscountCalculator {
    private AccountSelector accountSelector;

    public OpportunityDiscountCalculator() {
        this(new AccountSelector());
    }

    public OpportunityDiscountCalculator(AccountSelector accountSelector) {
        this.accountSelector = accountSelector;
    }

    public Decimal calculateDiscount(Opportunity opp) {
        Account account = accountSelector.getAccountById(opp.AccountId);
        if (account.Rating == 'Hot') {
            return 0.2;
        } else {
            return 0.1;
        }
    }
}

@isTest
private class OpportunityDiscountCalculator_Test {
    // TODO: Write unit tests that will test this method's conditional behavior without inserting any data into the database.
}