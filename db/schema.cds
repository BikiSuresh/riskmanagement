namespace riskmanagement;
using { managed } from '@sap/cds/common';


entity Risks : managed {
    key ID        : UUID @(Core.Computed);
    Title         : String(100);
    Owner         : String;
    Priority      : String(5);
    Description   : String;
    Impact        : Integer;
    criticality   : Integer;
    to_Mitigation : Association to Mitigations;
};

entity Mitigations : managed {
    key ID       : UUID @(Core.Computed);
    Description  : String;
    Owner        : String;
    Timeline      : String;
    to_Risks     : Association to many Risks on to_Risks.to_Mitigation = $self;
};