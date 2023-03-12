//Import 
const cds = require('@sap/cds');

class RiskService extends cds.ApplicationService {
    //Initialization Method
    async init() {

        const { Risks } = this.entities ('riskmanagement');
        console.log(Risks);
        this.after('READ', Risks, (data)=>{
            console.log(data);
            const Risks = Array.isArray(data) ? data : [data];

            Risks.forEach((risk)=>{
                console.log(risk);
                if(risk.Impact >= 10000 ){
                    risk.criticality = 1;
                } else {
                    risk.criticality = 0;
                };
            });
        });

        await super.init();

    };
};

module.exports = { RiskService };