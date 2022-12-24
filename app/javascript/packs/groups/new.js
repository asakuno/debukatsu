// スクロールバーと数値の取得
const input = document.querySelector('#maximum_amount_input');
const text_input = document.querySelector('#maximum_amount_value');
const display = document.querySelector('#value_display');

input.addEventListener('input', () => {
  text_input.value = input.value;
  display.textContent = input.value;
});

text_input.addEventListener('input', () => {
  input.value = text_input.value;
  display.textContent = text_input.value;
});