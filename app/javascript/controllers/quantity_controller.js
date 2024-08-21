import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quantity"
export default class extends Controller {
  connect() {
    console.log("Welcome back Stimulus!")
  }
}
