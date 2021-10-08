'use strict';

const $field = document.querySelector('.field');
const $timer = document.querySelector('.timer');
const $start = document.querySelector('.play_pause');
const $count = document.querySelector('.count');
const $icon = document.querySelector('.play_pause i');
const $gameOver = document.querySelector('.gameover');

// 시간 카운트 setInterval Id 저장함수
let timer = null;

// 시간 카운트 : 20초부터 --
let count = 20;

let carrots = 0;

const random = () => { // transform x y 좌표 랜덤 생성
    const left = Math.floor((Math.random() * 800) + 1); // width 랜덤좌표
    const top = Math.floor((Math.random() * 250) + 1); // top 랜덤좌표

    const data = [left, top];
    return data;
}

const startGame = () => {

    for(let i = 0; i<20; i++) {
        const $cloneBug = document.createElement('img');
        $cloneBug.setAttribute('src', 'img/bug.png');
        $cloneBug.setAttribute('class', 'bug');
        let coordinate = random();
        $cloneBug.style.transform = `translate(${coordinate[0]}px, ${coordinate[1]}px)`;
        $field.appendChild($cloneBug);
    }
    
    for(let i = 0; i<15; i++) {
        const $cloneCarrot = document.createElement('img');
        $cloneCarrot.setAttribute('src', 'img/carrot.png');
        $cloneCarrot.setAttribute('class', 'carrot');
        let coordinate = random();
        $cloneCarrot.style.transform = `translate(${coordinate[0]}px, ${coordinate[1]}px)`;
        $field.appendChild($cloneCarrot);
    };

    const $carrots = document.getElementsByClassName('carrot');
    carrots = $carrots.length;
    document.querySelector('.count').textContent = carrots;

    $timer.textContent = `${count}`;
    count--;
    timer = setInterval(() => {
        $timer.textContent = `${count}`;
        count--;

        if(count <= 4){
            $timer.style.color = 'red';
        }

        if(count === -1) {
            initialize();
        }
    }, 1000);
};

const initialize = () => {
    $icon.setAttribute('class', 'fas fa-play-circle');
    clearInterval(timer);
    $timer.textContent = 0;
    $count.textContent = 0;
    $field.querySelectorAll('img').forEach(value => value.remove());
    $timer.style.color = 'black';
    count = 20;
};


$start.addEventListener('click', () => {
    if($icon.className === 'fas fa-stop-circle') {
        initialize();
        return;
    }

    $icon.setAttribute('class', 'fas fa-stop-circle');
    $gameOver.style.visibility = 'hidden';

    startGame();
});

$field.addEventListener('click', (event) => {
    const $span = document.querySelector('.gameover span');
    if(event.target.className === 'carrot') {
        event.target.remove();
        carrots--;
        $count.textContent = carrots;
    }

    if(carrots === 0) {
        $span.textContent = 'YOU WIN!';
        $gameOver.style.visibility = 'visible';
        initialize();

    }

    if(event.target.className === 'bug') {
        if($span.textContent === 'YOU WIN!') {
            $span.textContent = 'GAME OVER';
        }
        $gameOver.style.visibility = 'visible';
        initialize();

    }

    if(event.target.tagName === 'BUTTON') {
        $gameOver.style.visibility = 'hidden';
        startGame();
    }
});





