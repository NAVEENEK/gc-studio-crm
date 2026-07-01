import bcrypt from "bcrypt";
const password="big0";
const hash=await bcrypt.hash(password,10);
console.log("password",hash);