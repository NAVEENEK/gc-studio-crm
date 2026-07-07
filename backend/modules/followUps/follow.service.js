import db from "../../config/db.js";

export const createFollowService=async(
  leadId,
  employeeId,
  followUpDate,
  task,
)=>{
  const[leadRows]=await db.query(
    `select lead_id 
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
  const[assignRows]=await db.query(
    `select employee_id
    from lead_assign
    where lead_id=?
    and employee_id=?
    and unassign_at is NULL `,
    [leadId,employeeId]
  );
  if(assignRows.length===0){
    return{
      success:false,
      statusCode:403,
      message:"lead is not assigned to you"
    };
  }

  await db.query(
    `insert into follow_up(
    lead_id,
    employee_id,
    follow_up_date,
    task)
    values(?,?,?,?)`,
    [leadId,employeeId,followUpDate,task]
  );

  return{
    success:true,
    statusCode:200,
    message:"Follow up created successfully"
  };
};

export const changeStatusService=async(
  followId,
  employeeId,
  followStatus
)=>{
  const [followRows]=await db.query(
    `select follow_id ,lead_id
    from follow_up
    where follow_id=?`,
    [followId]
  );
  if(followRows.length===0){
    return{
      success:false,
      statusCode:404,
      message:"follow up not found"
    };
  }
  const{lead_id}=followRows[0];
  const [assignRows]=await db.query(
    `select assign_id
    from lead_assign
    where employee_id=?
    and lead_id=?
    and unassign_at is NULL`,
    [employeeId,lead_id]
  );
  if(assignRows.length===0){
    return{
      success:false,
      statusCode:403,
      message:"lead is not assigned to you"
    };
  }
  await db.query(
    `update follow_up
    set follow_up_status=?
    where follow_id=?`,
    [followStatus,followId]
  );
  return{
    success:true,
    statusCode:200,
    message:"Status updated successfully"
  };
};

export const updateFollowService=async(
  followId,
  employeeId,
  followUpDate,
  task
)=>{
  const[followRows]=await db.query(
    `select lead_id,follow_id
    from follow_up
    where follow_id=?`,
    [followId]
  );
  if(followRows.length===0){
    return{
      success:false,
      statusCode:404,
      message:"follow up not found"
    };
  }
  const{lead_id}=followRows[0];

  const[assignRows]=await db.query(
    `select employee_id
    from lead_assign
    where lead_id=?
    and employee_id=?
    and unassign_at is NULL`,
    [lead_id,employeeId]
  );
  if(assignRows.length===0){
    return{
      success:false,
      statusCode:403,
      message:"lead is not assigned to you "
    };
  }
  await db.query(
    `update follow_up
    set follow_up_date=?,
    task=?
    where follow_id=? `,
    [followUpDate,task,followId]
  );

  return{
    success:true,
    statusCode:200,
    message:"follow up updated successfully"
  };
}