import bcrypt from "bcrypt";
const password="marco";
const hash=await bcrypt.hash(password,10);
console.log("password",hash);
