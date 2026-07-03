import jwt from "jsonwebtoken";
import bcrypt from "bcrypt";
import db from "../../config/db.js";

export const employeeLoginService=async(
  email,
  password
) =>{
  const [employeeRows]= await db.query(
    "select * from employees where email=?",[email]
  );
  if(employeeRows.length === 0){
    return{
      success:false,
      statusCode:404,
      message:"employee not found"
    };
  }
  const employee=employeeRows[0];

  const isPasswordMatch =await bcrypt.compare(
    password,
    employee.password_hash
  );

  if(!isPasswordMatch){
    return{
      success:false,
      statusCode:401,
      message:"invalid password"
    };
  }
  if(employee.employee_status !== 'active'){
   return{
    success:false,
    statusCode:403,
    message:"inactive employee"
   };
  }
  const token= jwt.sign(
    {
      employeeId:employee.employee_id,
      clientId:employee.client_id,
      role:employee.employee_role
      
    },
    process.env.JWT_SECRET,
    {
      expiresIn: "7d"

    }
  );

  return{
    success:true,
    token,
    employee:{
      employeeId:employee.employee_id,
      clientId:employee.client_id,
      name:employee.employee_name,
      role:employee.employee_role
    }
  };
};




export const agencyLoginService=async(
  email,
  password
)=>{
  const [userRows]=await db.query(
    "select * from agency_users where email=?",[email]
  );

  if(userRows.length===0){
    return{
      success:false,
      statusCode:404,
      message:"agency user not found"
    };
  }

  const user= userRows[0];

  const isPasswordMatch=await bcrypt.compare(
    password,
    user.passwords
  );
  if(!isPasswordMatch){
    return{
      success:false,
      statusCode:401,
      message:"Invalid password"
    };
  }

  if(user.user_status !== 'active'){
    return{
      success:false,
      statusCode:403,
      message:"inactive user"
    };
  }
  const token=jwt.sign(
    {
      userId:user.user_id,
      role:user.user_role
    },
    process.env.JWT_SECRET,
    {
      expiresIn:"7d"
    }
  );
  return{
    success:true,
    token,
    user:{
      userId:user.user_id,
      userName:user.user_name,
      userRole:user.user_role
    }
  };
}