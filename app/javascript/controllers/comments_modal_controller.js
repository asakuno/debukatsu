import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comments-modal"
export default class extends Controller {
  static targets = [ "content" ]
  static classes = [ "open" ]

  open() {
    this.element.classList.add(this.openClass)
  }

  close() {
    this.element.classList.remove(this.openClass)
  }
}