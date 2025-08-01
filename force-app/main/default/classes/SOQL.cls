/**
 * The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
 * It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
 *
 * This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
 * a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
 * records, and manage data volume using the LIMIT keyword.
 *
 * Topics covered in this class include:
 * - Understanding the structure of a SOQL query.
 * - Crafting basic SELECT statements in SOQL.
 * - Applying filters using the WHERE clause in SOQL.
 * - Fetching related records using Relationship queries.
 * - Controlling the amount of data retrieved using the LIMIT keyword.
 *
 * Users of this class can expect to gain a solid understanding of SOQL in Apex and
 * be prepared to handle data retrieval tasks in Salesforce development.
 *
 * @author Hallie Vanderhoof
 */

public with sharing class SOQL {
	/**
	 * Question 1
	 * Update/Uncomment the template code to create a method
	 * Returns all leads from Salesforce Org
	 * @return List of all leads with Id, LastName, Company, Phone, Email
	 * Update the corresponding test class and testGetAllLeads method to cover this method
	 */
	/**
	 * Question 1
	 * Update/Uncomment the template code to create a method
	 * Returns all leads from Salesforce Org
	 * @return List of all leads with Id, LastName, Company, Phone, Email
	 * Update the corresponding test class and testGetAllLeads method to cover this method
	 */
	public static List<Lead> getAllLeads() {
	return [SELECT Id, LastName, Company, Phone, Email FROM Lead WITH SECURITY_ENFORCED];
	}


	/**
	 * Question 2
	 * Update/Uncomment the template code to create a method
	 * Returns all contacts with first name of John.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByFirstName method to cover this method
	 */
	public static List<Contact> getContactByFirstName() {
	return [SELECT Id, FirstName, Name FROM Contact WHERE FirstName = 'John' WITH SECURITY_ENFORCED];
	}

	/**
	 * Question 3
	 * Update/Uncomment the template code to create a method
	 * Returns the Contact Id for all contacts with last name of Smith or Jones
	 * @return A list of Contact Ids.
	 * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
	 */
	public static List<Id> getContactIdsByLastName() {
		List<Contact> contacts = [
			SELECT Id
			FROM Contact
			WHERE LastName IN ('Smith', 'Jones')
			WITH SECURITY_ENFORCED
		];
		Set<Id> contactIdSet = new Map<Id, Contact>(contacts).keySet();
		return new List<Id>(contactIdSet);
	}

	/**
	 * Question 4
	 * Update/Uncomment the template code to create a method
	 * Returns List of closed won opportunities for a specific Account.
	 * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Opportunities with important opportunities fields
	 * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
	 */
	public static List<Opportunity> getClosedWonOpportunityCountByAccount(Id accountId) {
		return [
			SELECT Id, Name, StageName, CloseDate, Amount, AccountId
			FROM Opportunity
			WHERE AccountId = :accountId And StageName = 'Closed Won'
			WITH SECURITY_ENFORCED
		];
	}

	/**
	 * Question 5
	 * Update/Uncomment the template code to create a method
	 * Returns the total count of Account records.
	 * @return The Integer count of Account records.
	 * Update the corresponding test class and testGetAccountCount method to cover this method
	 */
	public static Integer getAccountCount() {
		return [ 
			SELECT COUNT()
			FROM Account
			WITH SECURITY_ENFORCED
		];
	}

	/**
	 * Question 6
	 * Update/Uncomment the template code to create a method
	 * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
	 * @return A map of Task Ids to Task records.
	 * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
	 */
	public static Map<Id, Task> getTasksDueNextWeek() {
		List<Task> tasks = [
			SELECT Id
			FROM Task
			WHERE ActivityDate = NEXT_N_DAYS: 7
			WITH SECURITY_ENFORCED
		];
		return new Map<Id, Task>(tasks);
	}

	/**
	 * Question 7
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Contacts that have a example.com domain in their Email.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
	 */
	public static List<Contact> getContactByEmailDomain() {
		return [
			SELECT Name, Email
			FROM Contact
			WHERE Email LIKE '%example.com'
			WITH SECURITY_ENFORCED
		];
	}

	/**
	 * Question 8
	 * Retrieves all Opportunities that have a specific keyword in their Name.
	 * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
	 * @param keyword The keyword to search for in the Opportunity Name.
	 * @return A list of Opportunity records.
	 */
	public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
		String search = '%' + keyword + '%';
		return [
			SELECT Id, Name, StageName, CloseDate
			FROM Opportunity
			WHERE Name LIKE :search
			WITH SECURITY_ENFORCED
		]; 
	}

	/**
	 * Question 9
	 * Retrieves all Cases that Case Origin is not Web or Email or Blank
	 * @return A list of Case records.
	 */
	public static List<Case> getFilterCaseOrigins() {
		return [
			SELECT AccountId, Status, Origin
			FROM Case
			WHERE Origin NOT IN ('Web', 'Email') AND Origin != null
			WITH SECURITY_ENFORCED
		]; 
	}

	/**
	 * Question 10
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
	 * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
	 * @param leadSource The Lead Source to search for.
	 * @param keyword The keyword to search for in the Lead Title.
	 * @return A list of Lead records.
	 * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
	 */
	public static List<Lead> getLeadBySourceOrTitle(String leadSource, String keyword) {
		String titleKeyword = '%' + keyword + '%';
		return [
			SELECT LastName, Company, Phone, Email, LeadSource, Title
			FROM Lead
			WHERE LeadSource = :leadSource OR Title LIKE :titleKeyword
			WITH SECURITY_ENFORCED
		];
	}

	/**
	 * Question 11
	 * Returns the names of all Contacts associated with an Account.
	 * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Contact LastName.
	 */
	public static List<String> getContactNamesByAccount(Id accountId) {
		// Create a list to hold the Contact LastNames
		List<String> contactLastName = new List<String>();
		// Query the Contacts
		List<Contact> contactName = [
			SELECT Id, LastName
			FROM Contact
			WHERE AccountId = :accountId
			WITH SECURITY_ENFORCED
		];
		// Loop through each Contact and add the LastName to the list
		for (Contact c : contactName) {
			contactLastName.add(c.lastName);
		}

		// Return the list of Contact LastNames
		return contactLastName; 
	}

	/**
	 * Question 12
	 * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
	 * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for the found opportunities
	 * @param stage The Stage value to filter Opportunities.
	 * @return The total revenue.
	 */
	public static Decimal getTotalRevenueByStage(String stage) {
		// Use AggregateQuery to get the total revenue
		AggregateResult[] results = [
			SELECT SUM(Amount) totalAmount
			FROM Opportunity
			WHERE StageName = :stage OR Amount > 10000
			WITH SECURITY_ENFORCED
		];
		// Return the total revenue
		Decimal totalRevenue = (Decimal) results[0].get('totalAmount');
		return totalRevenue != null ? totalRevenue : 0;
	}

	/**
	 * Question 13
	 * Retrieves the first 10 Accounts ordered by Name.
	 * @return A list of the first 10 Accounts ordered by Name.
	 */
	public static List<Account> getFirstTenAccounts() {
		List<Account> firstTenAccts = [SELECT Name FROM Account ORDER BY Name LIMIT 10];
		return firstTenAccts; 
	}

	/**
	 * Question 14
	 * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 */
	public static List<Opportunity> getHighValueOpportunities() {
		List<Opportunity> oppver100K = [SELECT AccountId, Amount, CloseDate FROM Opportunity WHERE amount > 100000 ORDER BY CloseDate LIMIT 5];
		return oppver100K; 
	}

	/**
	 * Question 15
	 * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
	 * @return A list of Contacts
	 */
	public static List<Contact> getBirthdateContacts() {
		List<Contact> contactBirthdate = [SELECT Birthdate FROM Contact ORDER BY Birthdate DESC LIMiT 3];
		return contactBirthdate; 
	}

	/**
	 * Question 16
	 * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
	 * @return A list of Cases
	 */
	public static List<Case> getCasesWithStatus() {
		List<Case> openedCases = [SELECT Status, CreatedDate FROM Case ORDER BY CreatedDate LIMIT 10 OFFSET 5];
		return openedCases; 
	}

	/**
	 * Question 17
	 * Returns Set of Case Ids for a specific Account.
	 * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A set of Case Ids.
	 */
	public static Set<Id> getCaseIdsByAccount(Id accountId) {
		// Create a set to hold the Case Ids
		Set<Id> caseIds = new Set<Id>();
		// Query the Cases
		List<Case> caseList = [SELECT Id FROM Case WHERE AccountId = :accountId ];
		// Loop through each Case and add the Id to the set
		for (Case c : caseList) {
			caseIds.add(c.Id);
		}

		return caseIds; 
	}

	/**
	 * Question 18
	 * Return Map of Account Ids to Account Names Not in a specific Country.
	 * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
	 * @param country The country to filter Accounts.
	 * @return A map of Account Ids to Account Names.
	 */
	public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
		// Create a map to hold the Account Ids to Account Names
		Map<Id, String> accountIdsToNames = new Map<Id, String>();

		// Query the Accounts 
		List<Account> acctList = [SELECT Id, Name FROM Account WHERE BillingCountry != :country];
		// Loop through each Account and add the Id and Name to the map
		for (Account a : acctList){
			accountIdsToNames.put(a.Id, a.Name);
		}

		return accountIdsToNames; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 19
	 * Retrieves the Account Name for a given Contact.
	 * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
	 * @param contactId The Id of the Contact.
	 * @return The Account Name of the Contact.
	 */
	public static String getAccountNameForContact(String contactId) {
		Contact c = [SELECT Account.Name FROM Contact Where Id = :contactId];
		if (c.Account != null) {
			return c.Account.Name;
		} else {
			return null; 
    }
		
	}

	/**
	 * Question 20
	 * Returns single Account that has related opportunities in the same query
	 * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
	 * @param accountId The ID of the Account.
	 * @return An Account record with related Opportunities.
	 */
	public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
		Account a = [
        SELECT Id, Name, 
               (SELECT Id, Name, StageName, CloseDate FROM Opportunities)
        FROM Account 
        WHERE Id = :accountId
        LIMIT 1
    ];
    
    return a;
	}

	/**
	 * Question 21
	 * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
	 * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts 
	 * that have the same Mailing State as the Account with the Id
	 * @param Account Id
	 * @return List of contacts with the same Mailing State as the Account Billing State
	 */
	public static List<Contact> getAccountsWithContactsByState(Id accountId) {
		// Query the Account
		Account a = [SELECT BillingState FROM Account WHERE Id = :accountId LIMIT 1];
		// Store the Account's BillingState
		String billingState = a.billingState;
		// Query the Contacts
		List<Contact> contact = [SELECT Name, MailingState FROM Contact WHERE MailingState = :billingState];
		return contact; 
	}

	/**
 * Question 22
 * Extracts email domains from the leads, then finds Accounts with matching website domains
 * If Lead Email = test@test.com return account with website = www.test.com
 * @param leadIds A set of Lead Ids.
 * @return A list of Accounts with matching email domains.
 */
public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
	// Query the Leads
	List<Lead> leadsEmail = [SELECT Email FROM Lead WHERE Id IN :leadIds];

	// Create a set of email domains from the Leads
	Set<String> emailDomains = new Set<String>();
	for (Lead l : leadsEmail) {
		if (l.Email != null && l.Email.contains('@')) {
			String domain = l.Email.split('@')[1].toLowerCase();
			emailDomains.add(domain);
		}
	}

	// Prepare list to collect matching Accounts
	List<Account> matchingAccts = new List<Account>();

	// For each domain, query matching accounts
	for (String domain : emailDomains) {
		List<Account> accounts = [
			SELECT Id, Name, Website
			FROM Account
			WHERE Website != null AND Website LIKE :('%' + domain + '%')
		];
		matchingAccts.addAll(accounts);
	}

	return matchingAccts;
}

	public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
	// Query the original Opportunity Line Items
	List<OpportunityLineItem> originalLineItems = [
		SELECT Quantity, UnitPrice, PricebookEntryId
		FROM OpportunityLineItem
		WHERE OpportunityId = :origOppId
	];

	List<OpportunityLineItem> newLineItems = new List<OpportunityLineItem>();

	// Loop through each cloned Opportunity Id
	for (Id cloneOppId : cloneOppIds) {
		// Loop through each original line item
		for (OpportunityLineItem oli : originalLineItems) {
			// Generate a random number between 1 and 3
			Integer randomAdd = Math.mod(Crypto.getRandomInteger(), 3) + 1;

			// Clone the original line item
			OpportunityLineItem newOli = new OpportunityLineItem(
				OpportunityId = cloneOppId,
				Quantity = oli.Quantity + randomAdd,
				UnitPrice = oli.UnitPrice,
				PricebookEntryId = oli.PricebookEntryId
			);

			newLineItems.add(newOli);
		}
	}

	// Insert the new line items
	if (!newLineItems.isEmpty()) {
		insert newLineItems;
	}
}


	/**
	 * Question 24
	 * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
	 * @return A list of filtered Opportunity
	 */
	public static List<Opportunity> getOpportunityDetailsForClosedWon() {
		List<Opportunity> closedWonOpps = [SELECT Name, Account.Name, Owner.Name FROM Opportunity Where StageName = 'Closed Won'];
		return closedWonOpps; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 25
	 * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to the Contact on the associated Account 
	 * with the alphabetically first first name.
	 * Example: if there are two Contacts on the Account, "Billy" and "Abby," the 'Primary_Contact__c' will be set to "Abby."
	 */
	public static void setPrimaryContact() {
    // Get Closed Won Opportunities
    List<Opportunity> closedWonOpps = getOpportunityDetailsForClosedWon();

    // Create a set of Account Ids from the Opportunities
    Set<Id> accountIds = new Set<Id>();
    for (Opportunity opp : closedWonOpps) {
        if (opp.AccountId != null) {
            accountIds.add(opp.AccountId);
        }
    }

    // Query the Contacts on those Accounts
    List<Contact> contacts = [
        SELECT Id, FirstName, AccountId
        FROM Contact
        WHERE AccountId IN :accountIds
    ];

    // Map to store the alphabetically first contact per Account
    Map<Id, Contact> accountToContactMap = new Map<Id, Contact>();

    for (Contact c : contacts) {
        if (c.FirstName == null) continue;
        if (!accountToContactMap.containsKey(c.AccountId)) {
            accountToContactMap.put(c.AccountId, c);
        } else {
            Contact existing = accountToContactMap.get(c.AccountId);
            if (c.FirstName.toLowerCase() < existing.FirstName.toLowerCase()) {
                accountToContactMap.put(c.AccountId, c);
            }
        }
    }

    // Set the Primary_Contact__c field for each Opportunity
    for (Opportunity opp : closedWonOpps) {
        Contact primaryContact = accountToContactMap.get(opp.AccountId);
        if (primaryContact != null) {
            opp.Primary_Contact__c = primaryContact.Id;
        }
    }

    // Update the Opportunities
    update closedWonOpps;
}

}
