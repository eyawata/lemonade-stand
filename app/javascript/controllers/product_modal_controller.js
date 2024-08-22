import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product-modal"
export default class extends Controller {
  connect() {
    console.log("Hello")
  }
  fetchProductData(productId){
    fetch
  }
}
