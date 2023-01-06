import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="newfoods"
export default class extends Controller {
  static targets = [
    "food_name",
    "calorie",
    "price",
    "submit",
    "error_food_name",
    "error_calorie",
    "error_price"
  ]

  food_nameValidation() {
    const food_nameInput = this.food_nameTarget
    const food_nameError = this.error_food_nameTarget

    if(food_nameInput.value === "") {
      food_nameInput.style.border = "2px solid red"
      food_nameError.textContent = "食品名を入力してください"
      food_nameError.style.color = "red"
    }else{
      food_nameInput.style.border = "2px solid lightgreen"
      food_nameError.textContent = ""
    }
  }

  calorieValidation() {
    const calorieInput = this.calorieTarget
    const calorieError = this.error_calorieTarget

    if(calorieInput.value < 0 || calorieInput.value === "" ) {
      calorieInput.style.border = "2px solid red"
      calorieError.textContent = "カロリーを入力してください"
      calorieError.style.color = "red"
    }else{
      calorieInput.style.border = "2px solid lightgreen"
      calorieError.textContent = ""
    }
  }

  priceValidation() {
    const priceInput = this.priceTarget
    const priceError = this.error_priceTarget

    if(priceInput.value === "") {
      priceInput.style.border = "2px solid red"
      priceError.textContent = "値段を入力してください"
      priceError.style.color = "red"
    }else{
      priceInput.style.border = "2px solid lightgreen"
      priceError.textContent = ""
    }
  }

  validSubmit() {
    const submitBtn = this.submitTarget

    if((this.food_nameTarget.value !== "") && (this.calorieTarget.value !== "") && (this.priceTarget.value !== "")){
      if((this.error_food_nameTarget.textContent === "") && (this.error_calorieTarget.textContent === "") && (this.error_priceTarget.textContent === "")){
        submitBtn.disabled = false
      }else{
        submitBtn.disabled = true
      }
    }else{
      submitBtn.disabled = true
    }
  }
}
