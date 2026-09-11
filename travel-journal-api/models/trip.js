import pool from '../config/db.js';

// Get all trips
async function getAll() {
  const query = 'SELECT * FROM trips ORDER BY created_at DESC';
  const result = await pool.query(query);
  return result.rows;
}

// Get trip by ID
async function getById(id) {
  const query = 'SELECT * FROM trips WHERE id = $1';
  const result = await pool.query(query, [id]);
  return result.rows[0];
}

// Create new trip
async function create(tripData) {
  const { title, destination, startDate, endDate, notes, imageUrl } = tripData;
  const query = `
    INSERT INTO trips (title, destination, start_date, end_date, notes, image_url)
    VALUES ($1, $2, $3, $4, $5, $6)
    RETURNING *
  `;
  const result = await pool.query(query, [title, destination, startDate, endDate, notes, imageUrl]);
  return result.rows[0];
}

// Delete trip
async function deleteTrip(id) {
  const query = 'DELETE FROM trips WHERE id = $1 RETURNING id';
  const result = await pool.query(query, [id]);
  return result.rowCount > 0;
}

export { getAll, getById, create, deleteTrip };