import pool from '../config/db.js';

const seedTrips = [
  {
    title: 'Road trip in Provence',
    destination: 'Marseille & Luberon, France',
    start_date: '2024-09-05',
    end_date: '2024-09-12',
    notes: 'Amazing lavender fields and wine tastings through scenic villages.',
    image_url: 'https://images.unsplash.com/photo-1499002238440-d264edd596ec?auto=format&fit=crop&w=3840&q=85'
  },
  {
    title: 'Wanderlust in Spain',
    destination: 'Segovia & Ávila, Spain',
    start_date: '2024-08-14',
    end_date: '2024-08-20',
    notes: 'Explored medieval walled cities with incredible architecture.',
    image_url: 'https://images.unsplash.com/photo-1511527661048-7fe73d85e9a4?auto=format&fit=crop&w=3840&q=85'
  },
  {
    title: 'Highlands Adventure',
    destination: 'Isle of Skye, Scotland',
    start_date: '2024-07-01',
    end_date: '2024-07-08',
    notes: 'Dramatic landscapes, moody skies, and rugged coastlines.',
    image_url: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=3840&q=85'
  },
  {
    title: 'Aegean Coastal Escape',
    destination: 'Aegean Islands, Greece',
    start_date: '2024-06-20',
    end_date: '2024-07-10',
    notes: 'Island hopping through the Aegean was magical.',
    image_url: 'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?auto=format&fit=crop&w=3840&q=85'
  }
];

async function updateImages() {
  try {
    console.log('Updating images in database...');

    for (const trip of seedTrips) {
      await pool.query(
        `UPDATE trips SET image_url = $1 WHERE title = $2`,
        [trip.image_url, trip.title]
      );
    }

    const result = await pool.query('SELECT id, title, destination, image_url FROM trips ORDER BY id ASC');
    console.log('Updated database trips:');
    console.log(result.rows);

    await pool.end();
    process.exit(0);
  } catch (err) {
    console.error('Error updating images:', err);
    process.exit(1);
  }
}

updateImages();