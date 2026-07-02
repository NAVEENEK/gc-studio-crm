import db from "../../config/db.js";


//common lead creation 
//====================
const createLeadService =async(leadData)=>{
  const{
    clientId,
    campaignId,
    leadName,
    phoneNumber,
    email,
    interestedService
  }=leadData;

  const[result]=await db.query(
    `insert into leads
    (
    client_id,
    campaign_id,
    lead_name,
    phone_number,
    email,
    interested_service
    )
    values (?,?,?,?,?,?)`,
    [
      clientId,
      campaignId,
      leadName,
      phoneNumber,
      email,
      interestedService
    ]
  );
  return {
    success:true,
    message:"lead created successfully",
    leadId:result.insertId
  };
};

//manual lead creation 
//====================
export const manualLeadService= async(
  clientId,
  campaignId,
  leadName,
  phoneNumber,
  email,
  interestedService
)=>{
  const [campaignRow]= await db.query(
    "select campaign_id from campaign where campaign_id =?",
    [campaignId]
  );
  if(campaignRow.length === 0){
    return{
      success:false,
      message:"campaign not found"
    };
  }
  return await createLeadService({
    clientId,
    campaignId,
    leadName,
    phoneNumber,
    email,
    interestedService
  });
};

//meta lead creation 
//==================
export const metaLeadService = async(
  metaLead
)=>{
 //to be constructed 
};

export const viewLeadsService=async(
  employeeId,
  clientId,
  role
)=>{
  let query;
  let value=[];

  if(role === "manager"){
    query=
    `select leads.*,employees.employee_name 
    from leads
    inner join lead_assign
    on leads.lead_id=lead_assign.lead_id
    inner join employees
    on lead_assign.employee_id=employees.employee_id
    where leads.client_id=?`;
    value=[clientId];
  }
  else{
    query=
    `select leads.*
    from leads 
    inner join lead_assign
    on leads.lead_id=lead_assign.lead_id
    where leads.client_id=?
    and lead_assign.employee_id=? `;

    value=[clientId,employeeId];
  }

  const [row]=await db.query(query,value);

  return{
    success:true,
    message:"leads fetched successfully",
    data:row
  };
};
