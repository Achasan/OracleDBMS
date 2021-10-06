const $body = document.querySelector('body');
const $img = document.querySelector('.image');
const $text = document.querySelector('.text');
const $horizontal = document.querySelector('.horizontal');
const $vertical = document.querySelector('.vertical');

$body.addEventListener('mousemove', (event) => {
    $text.innerHTML = `${event.clientX}px, ${event.clientY}px`;
    $text.style.transform = `translate(${event.clientX + 15}px, ${event.clientY + 15}px)`;
    $img.style.transform = `translate(${event.clientX - 35}px, ${event.clientY - 35}px)`;
    $horizontal.style.transform = `translate(0, ${event.clientY}px`;
    $vertical.style.transform = `translate(${event.clientX}px)`;
});