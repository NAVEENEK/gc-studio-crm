import db from "../../config/db.js"

export const createNoteService=async(
  leadId,
  employeeId,
  note
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

  const [assignRows]=await db.query(
    `select assign_id
    from lead_assign
    where lead_id=?
    and employee_id=?
    and unassign_at is NULL`,
    [leadId,employeeId]
  );
  if(assignRows.length===0){
    return{
      success:false,
      statusCode:403,
      message:"lead is not assign to you"
    };
  }

  await db.query(
    `insert into lead_notes 
    (lead_id,employee_id,note)
    values(?,?,?)`,
    [leadId,employeeId,note]
  );

  return{
    success:true,
    statusCode:200,
    message:"note created successfully"
  };
};

export const viewNoteService=async(
  leadId,
  employeeId
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

  const [assignRows]=await db.query(
    `select assign_id
    from lead_assign
    where lead_id=?
    and employee_id=?
    and unassign_at is NULL`,
    [leadId,employeeId]
  );
  if(assignRows.length===0){
    return{
      success:false,
      statusCode:403,
      message:"You are not the assigned employee"
    }
  }
  const [notes]=await db.query(
    `select 
    l.note,
    l.created_at,
    l.note_id,
    e.employee_name,
    e.employee_status
    from lead_notes as l
    inner join employees as e
    on l.employee_id=e.employee_id
    where l.lead_id=?
    order by l.created_at desc`,
    [leadId]
  );

  return{
    success:true,
    statusCode:200,
    message:"note fetched",
    notes
  };
};

export const updateNoteService=async(
  noteId,
  employeeId,
  note
)=>{
  const[noteRows]=await db.query(
    `select note_id,lead_id
    from lead_notes
    where note_id=?`,
    [noteId]
  );
  if(noteRows.length===0){
    return{
      success:false,
      statusCode:404,
      message:"Note not found"
    };
  }

  const {lead_id}=noteRows[0];

  const[assignRows]=await db.query(
    `select assign_id
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
      message:"only assigned employee can update lead"
    };
  }

  await db.query(
    `update lead_notes
    set note=?
    where note_id=? `,
    [note,noteId]
  );

  return{
    success:true,
    statusCode:200,
    message:"note updated successfully"
  };
}