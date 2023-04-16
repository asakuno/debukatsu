// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.



import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import '@fortawesome/fontawesome-free/js/all'
import "stylesheets/application.css"
import "jquery"
import "@vueform/multiselect"
import "vue"
import "./tags.js"
import "../calendar"
import 'chartkick'
import 'chart.js'

Rails.start()
Turbolinks.start()
ActiveStorage.start()
import "controllers"

