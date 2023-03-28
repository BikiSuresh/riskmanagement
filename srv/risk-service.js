//Import 
const cds = require('@sap/cds');

class RiskService extends cds.ApplicationService {
    //Initialization Method
    async init() {


        this.after('READ', 'Risks', (data)=>{
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

        //Connect to remote service
        const bpSrv = await cds.connect.to('API_BUSINESS_PARTNER');

        const { BusinessPartners , Risks} = this.entities;

        this.on('READ', BusinessPartners, async (req) => {

            req.query.where("LastName <> '' AND FirstName <> ''");
            req.query.limit(100);

            return await bpSrv.tx(req).send({
                query: req.query,
                headers : {
                    APIKey : process.env.apikey,
                }
            });

        });


        
        //On event Handller 
        this.on("READ", Risks, async (req, next,res)=>{

            if ( !req.query.SELECT.columns ) return next();

            const expandIndex = req.query.SELECT.columns.findIndex(
                ({expand, ref})=> expand && ref[0] === "to_BP"
            );

            console.log(req.query.SELECT.columns);

            if (expandIndex < 0 ) return next();

            req.query.SELECT.columns.splice(expandIndex, 1);

            if (
                !req.query.SELECT.columns.find((column) => 
                column.ref.find((ref) => ref == "to_BP_BusinessPartner"))
            ) {
                req.query.SELECT.columns.push({ref : ["to_BP_BusinessPartner"]});

            }

            try {
                res = await next();
                res = Array.isArray(res) ? res : [res];

                await Promise.all(
                    res.map(
                        async (risk) => {
                            const bp = await bpSrv.tx(req).send({
                                query : SELECT.one(this.entities.BusinessPartners)
                                .where({BusinessPartner : risk.to_BP_BusinessPartner})
                                .columns(["BusinessPartner", "LastName", "FirstName"]),
                                headers : {
                                    APIKey: process.env.apikey,
                                },
                            });
                            risk.to_BP = bp;
                        }
                    )
                );
            } catch (error) {
                console.log(error);
            }

        });

        await super.init();

    };
};

module.exports = { RiskService };