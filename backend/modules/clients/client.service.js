import db from "../../config/db.js";
import bcrypt from "bcrypt";
import { count } from "console";
import crypto from "crypto";
import { stat } from "fs";

//the agency user create client and a single manager 
export const createClientService = async ({
  userId,
  clientName,
  businessType,
  email,
  phoneNumber,
  whatsAppNumber,
  website,
  address,
  city,
  state,
  country,
  employeeName,
  empPhoneNumber,
  empEmail
}) => {
  const[userRows]=await db.query(
    `select user_id 
    from agency_users
    where user_id=?`,
    [userId]
  );
  if(userRows.length===0){
    return{
      success:false,
      statusCode:404,
      message:"agency user not found"
    };
  }
  const[emailRows]=await db.query(
    `select client_id
    from clients
    where email=?`,
    [email]
  );
  if(emailRows.length!==0){
    return{
      success:false,
      statusCode:409,
      message:"client email is already registered"
    };
  }
  const[empEmailRows]=await db.query(
    `select employee_id
    from employees
    where email=?`,
    [empEmail]
  );
  if(empEmailRows.length!==0){
    return{
      success:false,
      statusCode:409,
      message:"employee email is already registered"
    };
  }

  const connection=await db.getConnection();
  try{
    await connection.beginTransaction();

     const tempPassword=crypto.randomBytes(6).toString("hex");
  const passwordHash=await bcrypt.hash(tempPassword,10);

    const[clientResult]=await connection.query(
    `insert into 
    clients (
    client_name,
    business_type,
    email,
    phone_number,
    whatsapp_number,
    website,
    address,
    city,
    state,
    country
    )
    values(?,?,?,?,?,?,?,?,?,?)`,
    [
      clientName,
      businessType,
      email,
      phoneNumber,
      whatsAppNumber,
      website,
      address,
      city,
      state,
      country
    ]
  );

  const clientId=clientResult.insertId;

  await connection.query(
    `insert into 
    employees(
    client_id,
    employee_name,
    phone_number,
    email,
    password_hash,
    employee_role,
    is_primary_contact
    )values
    (?,?,?,?,?,?,?)`,
    [
      clientId,
      employeeName,
      empPhoneNumber,
      empEmail,
      passwordHash,
      "manager",
      true
    ]
  );

  await connection.commit();
  return{
    success:true,
    statusCode:201,
    message:"client and manager created successfully",
    temporaryPassword:tempPassword
  };

  }catch(error){
    await connection.rollback();
    throw error;
  }finally{
    connection.release();
  }
};

export const updateClientService=async({
  clientId,
  clientName,
  businessType,
  email,
  phoneNumber,
  whatsAppNumber,
  website,
  address,
  city,
  state,
  country
})=>{
  const[clientRows]=await db.query(
    `select client_id
    from clients
    where client_id=?`,
    [clientId]
  );
  if(clientRows.length === 0){
    return{
      success:false,
      statusCode:404,
      message:"client not found"
    };
  }
  const[emailRows]=await db.query(
    `select client_id
    from clients
    where email=?
    and client_id <> ?`,
    [email,clientId]
  );
  if(emailRows.length!==0){
    return{
      success:false,
      statusCode:409,
      message:"client email is already registered"
    };
  }
  await db.query(
    `update clients
    set 
    client_name=?,
    business_type=?,
    email=?,
    phone_number=?,
    whatsapp_number=?,
    website=?,
    address=?,
    city=?,
    state=?,
    country=?
    where client_id=?`,
    [
      clientName,
      businessType,
      email,
      phoneNumber,
      whatsAppNumber,
      website,
      address,
      city,
      state,
      country,
      clientId
    ]
  );
  return{
    success:true,
    statusCode:200,
    message:"client updated successfully"
  };
};