// script.js

document.addEventListener('DOMContentLoaded', () => {
  // Smooth scrolling for navigation links
  const navLinks = document.querySelectorAll('a[href^="#"]');

  navLinks.forEach(link => {
    link.addEventListener('click', function (e) {
      e.preventDefault();

      const targetId = this.getAttribute('href');
      const targetSection = document.querySelector(targetId);

      if (targetSection) {
        targetSection.scrollIntoView({
          behavior: 'smooth',
          block: 'start',
        });
      }
    });
  });

  // Add scroll effect to navigation
  const nav = document.querySelector('.nav');

  window.addEventListener('scroll', () => {
    if (window.scrollY > 100) {
      nav.style.boxShadow = '0 2px 10px rgba(0,0,0,0.1)';
    } else {
      nav.style.boxShadow = 'none';
    }
  });

  // Add animation to feature cards on scroll
  const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px',
  };

  const observer = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.style.opacity = '1';
        entry.target.style.transform = 'translateY(0)';
      }
    });
  }, observerOptions);

  // Observe all cards
  const cards = document.querySelectorAll('.feature-card, .repo-card, .doc-card');
  cards.forEach(card => {
    card.style.opacity = '0';
    card.style.transform = 'translateY(20px)';
    card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
    observer.observe(card);
  });

  // Mobile menu toggle (if needed)
  const navMenu = document.querySelector('.nav-menu');
  const navToggle = document.querySelector('.nav-toggle');

  if (navToggle) {
    navToggle.addEventListener('click', () => {
      navMenu.classList.toggle('active');
    });
  }

  // Update copyright year
  const currentYear = new Date().getFullYear();
  const copyrightElement = document.querySelector('.footer-bottom p');
  if (copyrightElement) {
    copyrightElement.textContent = `© ${currentYear} Tiation. All rights reserved.`;
  }

  // Add loading animation
  window.addEventListener('load', () => {
    document.body.style.opacity = '1';
  });
});

// Initialize page
document.body.style.opacity = '0';
document.body.style.transition = 'opacity 0.3s ease';
