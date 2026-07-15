import express from "express";
import { verifyToken } from "../../middleware/verifyToken.js";
import { allowRole } from "../../middleware/allowRole.js";
import { changeStatus, clientDetails, createClient, updateClient, viewClients } from "./client.controller.js";

const router=express.Router();

router.post("/create",verifyToken,createClient);

router.patch("/update/:clientId",verifyToken,allowRole("manager"),updateClient);

router.patch("/status/:clientId",verifyToken,allowRole("user"),changeStatus);

router.get("/info/:clientId",verifyToken,clientDetails);

router.get("/view",verifyToken,viewClients);

export default router;