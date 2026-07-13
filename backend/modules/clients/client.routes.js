import express from "express";
import { verifyToken } from "../../middleware/verifyToken.js";
import { allowRole } from "../../middleware/allowRole.js";
import { createClient } from "./client.controller.js";

const router=express.Router();

router.post("/create",verifyToken,createClient);

export default router;