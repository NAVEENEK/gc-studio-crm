import bcrypt from "bcrypt";
const password="small0";
const hash=await bcrypt.hash(password,10);
console.log("password",hash);