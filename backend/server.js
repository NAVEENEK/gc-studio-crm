import express from "express";
const app = express();
import db from "./config/db.js";
import authRoutes from "./modules/auth/auth.routes.js"
import leadRoutes from "./modules/leads/lead.routes.js";

app.use(express.json());

app.use("/auth",authRoutes);

app.use("/leads",leadRoutes);

app.listen(process.env.PORT,()=>{
  console.log("server runing");
});