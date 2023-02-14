import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="checkbox"
export default class extends Controller {
  connect() {
    const checkboxes = this.element.querySelectorAll('input[type="checkbox"]');
    checkboxes.forEach((checkbox) => {
      checkbox.addEventListener('click', this.saveState.bind(this));
      this.restoreState(checkbox);
    });
  }

  saveState(event) {
    const checkbox = event.currentTarget;
    sessionStorage.setItem(checkbox.id, checkbox.checked);
  }

  restoreState(checkbox) {
    const checked = sessionStorage.getItem(checkbox.id) === 'true';
    checkbox.checked = checked
  }
}
