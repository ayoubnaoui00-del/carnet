import { getAll, getById, create, deleteTrip } from '../models/trip.js';

// Get all trips
async function getAllTrips(req, res) {
  try {
    const trips = await getAll();
    res.json(trips);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch trips' });
  }
}

// Get trip by ID
async function getTripById(req, res) {
  try {
    const { id } = req.params;
    const trip = await getById(id);
    
    if (!trip) {
      return res.status(404).json({ error: 'Trip not found' });
    }
    
    res.json(trip);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch trip' });
  }
}

// Create trip
async function createTrip(req, res) {
  try {
    const { title, destination, startDate, endDate, notes, imageUrl } = req.body;
    
    if (!title || !destination || !startDate || !endDate) {
      return res.status(400).json({ error: 'Missing required fields' });
    }
    
    const newTrip = await create({
      title,
      destination,
      startDate,
      endDate,
      notes,
      imageUrl
    });
    
    res.status(201).json(newTrip);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to create trip' });
  }
}

// Delete trip
async function deleteATrip(req, res) {
  try {
    const { id } = req.params;
    const success = await deleteTrip(id);
    
    if (!success) {
      return res.status(404).json({ error: 'Trip not found' });
    }
    
    res.json({ message: 'Trip deleted successfully' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to delete trip' });
  }
}

export { getAllTrips, getTripById, createTrip, deleteATrip };