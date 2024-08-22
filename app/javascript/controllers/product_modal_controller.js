import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product-modal"
export default class extends Controller {
  connect() {
    console.log("Product Modal Controller Connected")
  }
}
