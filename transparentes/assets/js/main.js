$( document ).ready(function() {
    window.sr = ScrollReveal();
    var revealOptions = function (side) {
      return { origin: side, distance: '1em', duration: 600, delay: 100, easing: 'cubic-bezier(0.6, 0.2, 0.1, 1)' }
    }
    sr.reveal('.left', revealOptions('left'));
    sr.reveal('.right', revealOptions('right'));
});
