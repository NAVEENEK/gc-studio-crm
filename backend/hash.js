import bcrypt from "bcrypt";
const password="agency";
const hash=await bcrypt.hash(password,10);
console.log("password",hash);