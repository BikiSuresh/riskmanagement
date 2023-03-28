namespace riskmanagement;

using { managed } from '@sap/cds/common';

using { API_BUSINESS_PARTNER as external } from '../srv/external/API_BUSINESS_PARTNER.csn';

entity Risks : managed
{
    key ID : UUID
        @Core.Computed;
    Title : String(100);
    Owner : String;
    Priority : String(5);
    Description : String;
    Impact : Integer;
    criticality : Integer;
    to_BP : Association to BusinessPartners;
    to_Mitigation : Association to one Mitigations;
}

entity Mitigations : managed
{
    key ID : UUID
        @Core.Computed;
    Description : String;
    Owner : String;
    Timeline : String;
    to_Risks : Association to many Risks on to_Risks.to_Mitigation = $self;
};

entity BusinessPartners as projection on external.A_BusinessPartner {
    key BusinessPartner,
        FirstName,
        LastName
}