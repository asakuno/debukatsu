import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="signup"
export default class extends Controller {
  static targets = [
    "name",
    "email",
    "password",
    "password_confirmation",
    "submit",
    "error_name",
    "error_email",
    "error_password",
    "error_password_confirmation"
  ]

  nameValidation() { 
    const nameInput = this.nameTarget
    const nameError = this.error_nameTarget
    if(nameInput.value === ""){
      nameInput.style.border = "2px solid red"
      nameError.textContent = "ユーザー名を入力してください"
      nameError.style.color = "red"
    }else{
      nameInput.style.border = "2px solid lightgreen"
      nameError.textContent = ""
    }
  }
  
  emailValidation() {
    const emailInput = this.emailTarget
    const emailError = this.error_emailTarget
    const emailRegex = /^[a-zA-Z0-9_+-]+(\.[a-zA-Z0-9_+-]+)*@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}$/

    if(emailInput.value === "") {
      emailInput.style.border = "2px solid red"
      emailError.textContent = "メールアドレスを入力してください"
      emailError.style.color = "red"
    }else if(!emailRegex.test(emailInput.value)) {
      emailInput.style.border = "2px solid red"
      emailError.textContent = "有効なメールアドレスを入力してください"
      emailError.style.color = "red"
    }else{
      emailInput.style.border = "2px solid lightgreen"
      emailError.textContent = ""
    }
  }

  passwordValidation() {
    const passInput = this.passwordTarget
    const passConfirmInput = this.password_confirmationTarget
    const passError = this.error_passwordTarget
    const passConfirmError = this.error_password_confirmationTarget
    const passRegex = /^([a-zA-Z0-9]{3,})$/

    if(!passRegex.test(passInput.value)){
      if(passInput.value === ""){
        passInput.style.border = "2px solid red"
        passError.textContent = "パスワードを入力してください"
        passError.style.color = "red"
        passConfirmInput.style.border = "2px solid red"
        passConfirmError.textContent =  ""
      }else{
        passInput.style.border = "2px solid red"
        passError.textContent = "３文字以上の半角英数字で入力してください"
        passError.style.color = "red"
        passConfirmInput.style.border = "2px solid red"
        passConfirmError.textContent = "" 
      }
    }else{
      if(passConfirmInput.value === ""){
        passInput.style.border = "2px solid lightgreen"
        passError.textContent = ""
        passConfirmInput.style.border = "2px solid red"
        passConfirmError.textContent = "パスワード再確認を入力してください"
        passConfirmError.style.color = "red"
      }else if(passInput.value === passConfirmInput.value){
        passInput.style.border = "2px solid lightgreen"
        passError.textContent = ""
        passConfirmInput.style.border = "2px solid lightgreen"
        passConfirmError.textContent = ""
      }else{
        passInput.style.border = "2px solid ligthgreen"
        passError.textContent = ""
        passConfirmInput.style.border = "2px solid red"
        passConfirmError.textContent = "入力したパスワードと一致しません"
        passConfirmError.style.color = "red"
      }
    }
  }
}
