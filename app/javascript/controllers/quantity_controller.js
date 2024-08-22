import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quantity"
export default class extends Controller {
  static targets = ["showProductQuantity"]

  connect() {
    console.log("Welcome back Stimulus!")
    this.selectedQuantity = parseInt(this.showProductQuantityTarget.innerText)
    this.stockQuantity = parseInt(this.showProductQuantityTarget.innerText);
  }

  add(event) {
    event.preventDefault();
    console.log("Add button clicked");

    if (this.selectedQuantity < this.stockQuantity) {
      this.selectedQuantity += 1
      this.showProductQuantityTarget.innerText = this.selectedQuantity
    } else {
      console.log("No Item to add");
      }
  }

  subtract(event) {
    event.preventDefault();
    console.log("Subtract button clicked");
    console.log(this.selectedQuantity)

    if (this.selectedQuantity > 0) {
      this.selectedQuantity -= 1
      this.showProductQuantityTarget.innerText = this.selectedQuantity
      } else {
      console.log("No Item to subtract");
      }
    }
}
