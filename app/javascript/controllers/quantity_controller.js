import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quantity"
export default class extends Controller {
  static targets = ["productQuantity", "showProductQuantity"]

  connect() {
    console.log("Welcome back Stimulus!")
  }

  add(event) {
    event.preventDefault();
    console.log("Add button clicked");

    let quantity = parseInt(this.productQuantityTarget.innerText);
    let orderProductQuantity = parseInt(this.showProductQuantityTarget.innerText);

    if (orderProductQuantity < quantity) {
      this.showProductQuantityTarget.innerText = orderProductQuantity + 1;
    } else {
      console.log("No Item to add");
      }
  }

  subtract(event) {
    event.preventDefault();
    console.log("Subtract button clicked");

     let orderProductQuantity = parseInt(this.showProductQuantityTarget.innerText);

    if (orderProductQuantity > 0) {
      this.showProductQuantityTarget.innerText = orderProductQuantity - 1;
      } else {
      console.log("No Item to subtract");
      }
    }
}
