import { changeStatusService, clientDetailsService, createClientService, updateClientService, viewClientLeadsService, viewClientsService } from "./client.service.js";

export const createClient = async (req, res) => {
  try {
    const result = await createClientService({
      ...req.body,
      userId: req.user.userId
    });
    return res.status(result.statusCode).json(result);
  } catch (error) {
    console.error("Error in creating client:", error);

    return res.status(500).json({
      success: false,
      message: "Internal server error"
    });
  }
};

export const updateClient = async (req, res) => {
  try {
    const result = await updateClientService({
      ...req.body,
      clientId: req.params.clientId
    });
    return res.status(result.statusCode).json(result);
  } catch (error) {
    console.error("Error in updating client:", error);

    return res.status(500).json({
      success: false,
      message: "Internal Server error"
    });
  }
};

export const changeStatus = async (req, res) => {
  try {
    const { clientStatus } = req.body;
    const { clientId } = req.params;
    const result = await changeStatusService(
      clientId,
      clientStatus
    );
    return res.status(result.statusCode).json(result);
  } catch (error) {
    console.error("Error in changin status:", error);

    return res.status(500).json({
      success: false,
      message: "Internal Server error"
    });
  }
};

export const clientDetails = async (req, res) => {
  try {
    const { clientId } = req.params;
    const result = await clientDetailsService(clientId);

    return res.status(result.statusCode).json(result);
  } catch (error) {
    console.error("Error in fetching client info:", error);

    return res.status(500).json({
      success: false,
      message: "Internal server error"
    });
  }
};

export const viewClients = async (req, res) => {
  try {
    const result = await viewClientsService();
    return res.status(result.statusCode).json(result);
  } catch (error) {
    console.error("Error in fetching clients:", error);

    return res.status(500).json({
      success: false,
      message: "Internal server error"
    });
  }
};

export const viewClientLeads = async (req, res) => {
  try {
    const { clientId } = req.params;
    const result = await viewClientLeadsService(clientId);

    return res.status(result.statusCode).json(result);
  } catch (error) {
    console.error("Error in Fetching leads:", error);

    return res.status(500).json({
      success: false,
      message: "Internal server error"
    });
  }
};