// Simple interactivity for the services index
document.addEventListener('DOMContentLoaded', () => {
  // Refresh button
  const refreshBtn = document.getElementById('refresh-btn');
  if (refreshBtn) refreshBtn.addEventListener('click', () => location.reload());

  // Keyboard support for cards (Enter / Space)
  document.querySelectorAll('.card').forEach(card => {
    card.addEventListener('keydown', (e) => {
      if (e.key === 'Enter' || e.key === ' ') card.click();
    });
  });
});