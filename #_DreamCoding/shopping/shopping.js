const $input = document.querySelector('.input');
const $contents = document.querySelector('.contents');
const $button = document.querySelector('.button');

// createElement를 통해 만들어진 태그는 이벤트리스너도 같이 등록을 해주어야한다.
// Refactoring : 여러가지 항목을 추가할려고 할때는 ul, li를 사용하여 넣어주는 것이 좋다.
// div를 묶어서 난사하는 일이 없도록 하자.
// 아이콘의 크기와 색을 변경하는 것은 css에서 구현해도 충분하다. hover를 사용하여 구현하도록 하자.


const createIndex = (content) => {
    const $index = document.createElement('div');
    const $span = document.createElement('span');
    const $check = document.createElement('i')
    const $bin = document.createElement('i')

    $index.setAttribute('class', 'index');
    $check.setAttribute('class', 'fas fa-check');
    $bin.setAttribute('class', 'fas fa-trash');
    $span.textContent = content;

    $index.appendChild($check);
    $index.appendChild($span);
    $index.appendChild($bin);
    $contents.appendChild($index);

    $input.value = null;
    $input.focus();
    $index.scrollIntoView({ block: 'center'});
}

$contents.addEventListener('click', (event) => {
    if(event.target.className === 'fas fa-trash'){
        event.target.parentNode.remove();
    }
});

$input.addEventListener('keydown', (event) => {
    if(event.key === 'Enter' && event.target.value !== '') {
        createIndex($input.value);
    }
});

$button.addEventListener('click', (event) => {
    if($input.value !== ''){
        createIndex($input.value);
    }
});