/* ==========================================================================
   KOP-V — animations.js
   Shared micro-animations, theme toggle, toast system.
   ========================================================================== */

/* ---------- Theme Toggle ---------- */

function toggleTheme() {
    const current = document.documentElement.getAttribute('data-theme') || 'light';
    const next = current === 'dark' ? 'light' : 'dark';
    document.documentElement.setAttribute('data-theme', next);
    localStorage.setItem('kop-v-theme', next);
}

/* ---------- FadeInUp on Scroll (IntersectionObserver) ---------- */

function initScrollAnimations() {
    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(function(entry) {
            if (entry.isIntersecting) {
                entry.target.style.animationPlayState = 'running';
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.animate-on-scroll').forEach(function(el) {
        el.style.animationPlayState = 'paused';
        observer.observe(el);
    });
}

/* ---------- Stagger Animation for Cards ---------- */

function initStaggerAnimation() {
    var cards = document.querySelectorAll('[data-stagger]');
    cards.forEach(function(card, index) {
        card.style.animationDelay = (index * 0.08) + 's';
    });
}

/* ---------- Animated Counters for Stat Values ---------- */

function animateCounters() {
    var counters = document.querySelectorAll('.stat-value[data-target]');
    counters.forEach(function(counter) {
        var target = parseInt(counter.getAttribute('data-target'), 10);
        if (isNaN(target)) return;

        var duration = 800;
        var startTime = null;

        function step(timestamp) {
            if (!startTime) startTime = timestamp;
            var progress = Math.min((timestamp - startTime) / duration, 1);
            var eased = 1 - Math.pow(1 - progress, 3); // easeOutCubic
            counter.textContent = Math.floor(eased * target).toLocaleString('fr-FR');
            if (progress < 1) {
                requestAnimationFrame(step);
            }
        }

        // Only animate when visible
        var observer = new IntersectionObserver(function(entries) {
            if (entries[0].isIntersecting) {
                requestAnimationFrame(step);
                observer.unobserve(counter);
            }
        }, { threshold: 0.5 });

        observer.observe(counter);
    });
}

/* ---------- Toast System ---------- */

function showToast(message, type, duration) {
    type = type || 'success';
    duration = duration || 3000;

    // Remove existing toast if any
    var existing = document.querySelector('.toast.show');
    if (existing) existing.classList.remove('show');

    // Create or reuse toast element
    var toast = document.getElementById('kop-v-toast');
    if (!toast) {
        toast = document.createElement('div');
        toast.id = 'kop-v-toast';
        toast.className = 'toast';
        document.body.appendChild(toast);
    }

    // Set icon based on type
    var icons = {
        success: 'fa-check-circle',
        error: 'fa-exclamation-circle',
        info: 'fa-info-circle',
        warning: 'fa-exclamation-triangle'
    };

    toast.className = 'toast toast-' + type;
    toast.innerHTML = '<i class="fas ' + (icons[type] || icons.success) + '"></i> ' + message;

    // Trigger animation
    requestAnimationFrame(function() {
        toast.classList.add('show');
    });

    // Auto-hide
    setTimeout(function() {
        toast.classList.remove('show');
    }, duration);
}

/* ---------- Modal System (replaces confirm/alert) ---------- */

function showModal(options) {
    var type = options.type || 'success';
    var title = options.title || '';
    var message = options.message || '';
    var onConfirm = options.onConfirm;
    var confirmText = options.confirmText || 'OK';
    var cancelText = options.cancelText || 'Annuler';
    var showCancel = options.showCancel !== undefined ? options.showCancel : false;

    // Create overlay
    var overlay = document.createElement('div');
    overlay.className = 'modal-overlay';
    overlay.innerHTML =
        '<div class="modal-content">' +
            '<div class="modal-icon ' + type + '">' +
                '<i class="fas ' + (type === 'success' ? 'fa-check' : 'fa-exclamation-triangle') + '"></i>' +
            '</div>' +
            '<h2>' + title + '</h2>' +
            '<p>' + message + '</p>' +
            '<div style="display:flex;gap:12px;justify-content:center;">' +
                (showCancel ? '<button class="btn btn-cancel modal-cancel">' + cancelText + '</button>' : '') +
                '<button class="btn btn-' + (type === 'error' ? 'danger' : 'primary') + ' modal-confirm">' + confirmText + '</button>' +
            '</div>' +
        '</div>';

    document.body.appendChild(overlay);

    // Animate in
    requestAnimationFrame(function() {
        overlay.classList.add('show');
    });

    // Event handlers
    function close() {
        overlay.classList.remove('show');
        setTimeout(function() { overlay.remove(); }, 300);
    }

    overlay.querySelector('.modal-confirm').addEventListener('click', function() {
        close();
        if (onConfirm) onConfirm();
    });

    if (showCancel) {
        overlay.querySelector('.modal-cancel').addEventListener('click', close);
    }

    // Close on backdrop click
    overlay.addEventListener('click', function(e) {
        if (e.target === overlay) close();
    });

    // Close on Escape
    function onKey(e) {
        if (e.key === 'Escape') { close(); document.removeEventListener('keydown', onKey); }
    }
    document.addEventListener('keydown', onKey);
}

/* ---------- Sidebar Toggle (Mobile) ---------- */

function toggleSidebar() {
    var sidebar = document.querySelector('.sidebar');
    if (sidebar) sidebar.classList.toggle('sidebar-open');
}

/* ---------- Init on DOM Ready ---------- */

document.addEventListener('DOMContentLoaded', function() {
    initScrollAnimations();
    initStaggerAnimation();
    animateCounters();
});
