import express from "express";
import { verifyToken } from "../../middleware/verifyToken.js";
import { allowRole } from "../../middleware/allowRole.js";
import { createClient, updateClient } from "./client.controller.js";

const router=express.Router();

router.post("/create",verifyToken,createClient);

router.patch("/update/:clientId",verifyToken,allowRole("manager"),updateClient);

export default router;