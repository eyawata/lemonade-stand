import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cart"
export default class extends Controller {
  static targets = ["showProductOrder"]
  connect() {
    console.log("Test")
  }

    show(event) {
      event.preventDefault();
      console.log(this)
      this.showProductOrderTarget.classList.toggle("d-none");

    }
}
