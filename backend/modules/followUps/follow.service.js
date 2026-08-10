import db from "../../config/db.js";

export const createFollowService = async (
  leadId,
  employeeId,
  followUpDate,
  task,
) => {
  const [leadRows] = await db.query(
    `select lead_id 
    from leads 
    where lead_id=?`,
    [leadId],
  );
  if (leadRows.length === 0) {
    return {
      success: false,
      statusCode: 404,
      message: "Lead not found",
    };
  }
  const [assignRows] = await db.query(
    `select employee_id
    from lead_assign
    where lead_id=?
    and employee_id=?
    and unassign_at is NULL `,
    [leadId, employeeId],
  );
  if (assignRows.length === 0) {
    return {
      success: false,
      statusCode: 403,
      message: "lead is not assigned to you",
    };
  }

  await db.query(
    `insert into follow_up(
    lead_id,
    employee_id,
    follow_up_date,
    task)
    values(?,?,?,?)`,
    [leadId, employeeId, followUpDate, task],
  );

  return {
    success: true,
    statusCode: 200,
    message: "Follow up created successfully",
  };
};

export const changeStatusService = async (
  followId,
  employeeId,
  followStatus,
) => {
  const [followRows] = await db.query(
    `select follow_id ,lead_id
    from follow_up
    where follow_id=?`,
    [followId],
  );
  if (followRows.length === 0) {
    return {
      success: false,
      statusCode: 404,
      message: "follow up not found",
    };
  }
  const { lead_id } = followRows[0];
  const [assignRows] = await db.query(
    `select assign_id
    from lead_assign
    where employee_id=?
    and lead_id=?
    and unassign_at is NULL`,
    [employeeId, lead_id],
  );
  if (assignRows.length === 0) {
    return {
      success: false,
      statusCode: 403,
      message: "lead is not assigned to you",
    };
  }
  await db.query(
    `update follow_up
    set follow_up_status=?
    where follow_id=?`,
    [followStatus, followId],
  );
  return {
    success: true,
    statusCode: 200,
    message: "Status updated successfully",
  };
};

export const updateFollowService = async (
  followId,
  employeeId,
  followUpDate,
  task,
) => {
  const [followRows] = await db.query(
    `select lead_id,follow_id
    from follow_up
    where follow_id=?`,
    [followId],
  );
  if (followRows.length === 0) {
    return {
      success: false,
      statusCode: 404,
      message: "follow up not found",
    };
  }
  const { lead_id } = followRows[0];

  const [assignRows] = await db.query(
    `select employee_id
    from lead_assign
    where lead_id=?
    and employee_id=?
    and unassign_at is NULL`,
    [lead_id, employeeId],
  );
  if (assignRows.length === 0) {
    return {
      success: false,
      statusCode: 403,
      message: "lead is not assigned to you ",
    };
  }
  await db.query(
    `update follow_up
    set follow_up_date=?,
    task=?
    where follow_id=? `,
    [followUpDate, task, followId],
  );

  return {
    success: true,
    statusCode: 200,
    message: "follow up updated successfully",
  };
};

export const viewFollowService=async({
  role,
  clientId,
  employeeId,
  selectedEmployeeId,
  leadId,
  leadName,
  status,
  filter
})=>{
  let query="";
  let value=[];

  if(role==="manager"){
    query=`
    select
    l.lead_name,
    e.employee_name,
    f.follow_id,
    f.task,
    f.follow_up_date,
    f.follow_up_status,
    f.created_at
    from follow_up as f
    inner join leads as l 
    on l.lead_id=f.lead_id
    inner join employees as e
    on f.employee_id=e.employee_id
    where l.client_id=?`;
    value.push(clientId);

    if(selectedEmployeeId){
      query += " and f.employee_id=?";
      value.push(selectedEmployeeId);
    }
    if(leadId){
      query += " and f.lead_id=?";
      value.push(leadId);
    }
    if(leadName){
      query += " and l.lead_name like ?";
      value.push(`%${leadName}%`);
    }
    if(status){
      query += " and f.follow_up_status = ?";
      value.push(status);
    }
    if(filter === "today"){
      query += " and date(f.follow_up_date)=curdate()";
    }
    if(filter==="overdue"){
      query += ` 
      and f.follow_up_status='pending'
      and date(f.follow_up_date)<curdate()`;
    }

    query += " order by f.follow_up_date asc";

  }else{
    query=`
    select 
    l.lead_name,
    f.follow_id,
    f.task,
    f.follow_up_date,
    f.follow_up_status,
    f.created_at
    from follow_up as f
    inner join leads as l
    on f.lead_id=l.lead_id
    inner join lead_assign as la
    on f.lead_id=la.lead_id
    where la.employee_id=?
    and la.unassign_at is null `;

    value.push(employeeId);

    if(leadId){
      query += " and f.lead_id=?";
      value.push(leadId);
    }
    if(leadName){
      query += " and l.lead_name like ?";
      value.push(`%${leadName}%`);
    }
    if(status){
      query += " and f.follow_up_status=?";
      value.push(status);
    }
    if(filter==="today"){
      query += " and date(f.follow_up_date)=curdate()";
    }
    if(filter==="overdue"){
      query += ` 
      and f.follow_up_status='pending'
      and date(f.follow_up_date)<curdate()`;
    }

    query += " order by f.follow_up_date asc";
    }

    const [result]=await db.query(query,value);

    return{
      success: true,
      statusCode:200,
      result
    };
  };

