import express from "express";
const app = express();
import db from "./config/db.js";
import authRoutes from "./modules/auth/auth.routes.js"
import leadRoutes from "./modules/leads/lead.routes.js";
import noteRoutes from "./modules/notes/note.routes.js";
import followRoutes from "./modules/followUps/follow.routes.js";

app.use(express.json());

app.use("/auth",authRoutes);

app.use("/leads",leadRoutes);

app.use("/notes",noteRoutes);

app.use("/follow",followRoutes);

app.listen(process.env.PORT,()=>{
  console.log("server runing");
});