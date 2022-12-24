const input = document.querySelector('#group_input');
const display = document.querySelector('#value_display');

input.addEventListener('input', () => {
  display.textContent = input.value;
});