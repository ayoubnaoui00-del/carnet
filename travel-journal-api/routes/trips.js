import express from 'express';
import { getAllTrips, getTripById, createTrip, deleteATrip } from '../controllers/tripController.js';

const router = express.Router();

router.get('/', getAllTrips);
router.get('/:id', getTripById);
router.post('/', createTrip);
router.delete('/:id', deleteATrip);

export default router;