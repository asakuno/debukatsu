import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="newgroups"
export default class extends Controller {
  static targets = [
    "group_name",
    "maximum_amount",
    "checkbox",
    "error_group_name",
    "error_maximum_amount",
    "error_checkbox"
  ]

  group_nameValidation() {
    const group_nameInput = this.group_nameTarget
    const group_nameError = this.error_group_nameTarget

    if(group_nameInput.value === ""){
      group_nameInput.style.border = "2px solid red"
      group_nameError.textContent = "名前を入力してください"
      group_nameError.style.color = "red"
    }else{
      group_nameInput.style.border = "2px solid lightgreen"
      group_nameError.textContent = ""
    }
  }

  maximum_amountValidation() {
    const maximum_amountInput = this.maximum_amountTarget
    const maximum_amountError = this.error_maximum_amountTarget

    if(maximum_amountInput.value === "") {
      maximum_amountInput.style.border = "2px solid red"
      maximum_amountError.textContent = "上限金額を入力してください"
      maximum_amountError.style.color = "red"
    }else {
      maximum_amountInput.style.border = "2px solid lightgreen"
      maximum_amountError.textContent = ""
    }
  }

  checkboxValidation() {
    const checkboxInput = this.checkboxTargets
    const checkboxError = this.error_checkboxTarget

    if(checkboxInput.some(checkbox => checkbox.checked)) {
      checkboxError.textContent = ""
    }else{
      checkboxError.textContent = "チェックをつけてください"
      checkboxError.style.color = "red"
    }
  }
}
