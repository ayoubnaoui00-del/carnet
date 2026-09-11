import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import tripRoutes from './routes/trips.js';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;


app.use(cors());
app.use(express.json());


app.use('/api/trips', tripRoutes);


app.get('/health', (req, res) => {
  res.json({ status: 'API is running' });
});


app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});