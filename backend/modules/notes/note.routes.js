import express from "express";
import { verifyToken } from "../../middleware/verifyToken.js";
import { allowRole } from "../../middleware/allowRole.js";
import { createNote, updateNote, viewNote } from "./note.controller.js";

const router=express.Router();

router.post("/create/:leadId",verifyToken,allowRole("employee"),createNote);
router.get("/view/:leadId",verifyToken,viewNote);
router.patch("/update/:noteId",verifyToken,allowRole("employee"),updateNote);

export default router;