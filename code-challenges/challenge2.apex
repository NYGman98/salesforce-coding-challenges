public virtual class DmlService {
    public virtual SObject doInsert(SObject record) {
        return doInsert(new List<SObject>{ record });
    }

    public virtual SObject doInsert(List<SObject> records) {
        Database.insert(records, true, AccessLevel.USER_MODE);
        return records;
    }
}

public class LongevityCampaignCreator {
    private DmlService dmlService;

    public LongevityCampaignCreator() {
        this(new DmlService());
    }

    public LongevityCampaignCreator(DmlService dmlService) {
        this.dmlService = dmlService;
    }

    public List<CampaignMembers> createLongevityCampaignWithMembers(List<Contact> contacts, String campaignName) {
        Campaign longevityCampaign = new Campaign(Name = campaignName);
        longevityCampaign = (Campaign) dmlService.doInsert(longevityCampaign);

        List<CampaignMember> campaignMembers = new List<CampaignMember>();
        for (Contact contact : contacts) {
            campaignMembers.add(new CampaignMember(CampaignId = campaign.Id, ContactId = contact.Id));
        }
        campaignMembers = dmlService.doInsert(campaignMembers);

        return campaignMembers;
    }
}

@isTest
private class LongevityCampaignCreator_Test {
    // TODO: write unit tests that test LongevityCampaignCreator.createLongevityCampaignWithMembers without actually inserting any records in the database.
    // Assert that the inserted campaign members have the correct campaign ID.
}
