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
    statusCode:200,
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
      statusCode:404,
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
  else if(role==="employee"){
    query=
    `select leads.*
    from leads 
    inner join lead_assign
    on leads.lead_id=lead_assign.lead_id
    where leads.client_id=?
    and lead_assign.employee_id=? `;

    value=[clientId,employeeId];
  }else{
    return{
      success:false,
      statusCode:403,
      message:"Unautherised access"
    };
  }

  const [rows]=await db.query(query,value);

  if(row.length===0){
    return{
      success:false,
      statusCode:404,
      message:"leads not found"
    };
  }

  return{
    success:true,
    statusCode:200,
    message:"leads fetched successfully",
    data:rows[0]
  };
};

export const leadInfoService=async(
  leadId,
  clientId,
  employeeId,
  role
)=>{
    let query;
    let value=[];

    if(role === "manager"){
      query=
      `select l.*,
      la.*,
      e.employee_name,e.phone_number,
      e.email
      from leads as l
      inner join lead_assign as la
      on l.lead_id=la.lead_id
      inner join employees as e
      on la.employee_id=e.employee_id
      where l.client_id=?
      and l.lead_id=?
      `;
      value=[clientId,leadId];
    }else if(role==="employee"){
      query=
      `
      select 
      l.*
      from leads as l
      inner join lead_assign as la
      on l.lead_id=la.lead_id
      where la.employee_id=? 
      and l.lead_id=?
      and l.client_id=?
      `;
      value=[employeeId,leadId,clientId];
    }else{
      return{
        success:false,
        statusCode:403,
        message:"Unauthorized access"
      };
    }
    const [rows]=await db.query(query,value);

    if(rows.length===0){
      return{
        success:false,
        statusCode:404,
        message:"lead not found"
      };
    }

    return{
      success:true,
      statusCode:200,
      lead:rows[0]
    };
};

export const changeStatusService=async(
  leadId,
  employeeId,
  status
)=>{

  const [leadRows]=await db.query(
    `select lead_id
    from leads
    where lead_id=?`,
    [leadId]
  );
  if(leadRows.length===0){
    return{
      success:false,
      statusCode:404,
      message:"lead not found"
    };
  }

  const [employeeRows]=await db.query(
    `select employee_id 
    from lead_assign 
    where lead_id=?
    and employee_id=?
    and unassign_at is NULL `,
    [leadId,employeeId]
  );
  if(employeeRows.length===0){
    return{
      success:false,
      statusCode:403,
      message:"only assigned employee can change status"
    };
  }

  const [result]=await db.query(
    `update leads
    set lead_status=?
    where lead_id=?`,
    [status,leadId]
  );
  if (result.affectedRows === 0) {
  return {
    success: false,
    statusCode: 500,
    message: "Failed to update lead status"
  };
}

  return{
    success:true,
    statusCode:200,
    message:"lead status updated"
  };
};

export const updateLeadService=async(
  employeeId,
  leadId,
  leadName,
  phoneNumber,
  email,
  interestedService,
)=>{
  //validate the lead exist
  const [leadRows]= await db.query(
    `select lead_id
    from leads
    where lead_id=?`,
    [leadId]
  );
  if(leadRows.length===0){
    return{
      success:false,
      statusCode:404,
      message:"lead not found"
    };
  }

  //valide the lead update requested employee, whether he is assigned one or not  
  const [employeeRows]=await db.query(
    `
    select employee_id 
    from lead_assign
    where employee_id=?
    and lead_id=?
    and unassign_at is NULL
    `,
    [employeeId,leadId]
  );

  if(employeeRows.length===0){
    return{
      success:false,
      statusCode:403,
      message:"you are not assigned to this lead"
    };
  }

  const [result]=await db.query(
    `
    update leads 
    set 
    lead_name =?,
    phone_number =?,
    email =?,
    interested_service =?
    where lead_id=?`,
    [leadName,phoneNumber,email,interestedService,leadId]
  );
  if (result.affectedRows === 0) {
  return {
    success: false,
    statusCode: 500,
    message: "Failed to update lead"
  };
}

  return{
    success:true,
    statusCode:200,
    message:"lead updated successfully"
  };

};

export const assignEmployeeService=async(
  leadId,
  employeeId,
)=>{
  //validate lead exists
  const [leadRows]=await db.query(
    `select lead_id,client_id
    from leads
    where lead_id=?`,
    [leadId]
  );

  if(leadRows.length===0){
    return{
      success:false,
      statusCode:404,
      message:"Lead not found"
    };
  }
  const clientId=leadRows[0].client_id;

  //validate employee exists and belong to same client
  const[employeeRows]=await db.query(
    `select employee_id,client_id
    from employees
    where employee_id=?
    and client_id=?
    and employee_role="employee"`,
    [employeeId,clientId]
  );

  if(employeeRows.length===0){
    return{
      success:false,
      statusCode:404,
      message:"Employee not found"
    };
  }
   // check current active assignment
  const [assignedRows]= await db.query(
    `select employee_id 
    from lead_assign
    where lead_id=?
    and unassign_at is NULL`,
    [leadId]
  );
  if(assignedRows.length>0 &&
    assignedRows[0].employee_id === employeeId){
    return{
      success:false,
      statusCode:409,
      message:"Lead is already assigned to this employee"
  };
}

  const connection= await db.getConnection();

  try{
    await connection.beginTransaction();

    //close the current active assignment if any
    if(assignedRows.length>0){
      await connection.query(
      `update lead_assign
      set unassign_at = now()
      where lead_id =?
      and unassign_at is null`,
      [leadId]
    );
    }
    

    //create the new assignment 
    await connection.query(
      `insert into lead_assign
      (lead_id,employee_id)
      values (?,?)`,
      [leadId,employeeId]
    );

    //update the lead status if its first assignment
      await connection.query(
      `update leads
      set lead_status ='assigned'
      where lead_id=?
      and lead_status='new'`,
      [leadId]
    );
    
    await connection.commit();

    return{
      success:true,
      statusCode:200,
      message:
      assignedRows.length===0 
      ? "lead assigned successfully"
      : "lead reassigned successfully"
    };
  }catch(error){
    await connection.rollback();
    throw error;
  }finally{
    connection.release();
  }
};



