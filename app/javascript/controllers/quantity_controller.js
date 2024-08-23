import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quantity"
export default class extends Controller {
  static targets = ["showProductQuantity","displayQuantity" ]

  // connect() {
  //   console.log("Welcome back Stimulus!")
  //   this.selectedQuantity = 0
  //   this.stockQuantity = parseInt(this.showProductQuantityTarget.innerText);
  //   this.displayQuantityTarget.innerText = parseInt("0");

  // }

  add(event) {
    event.preventDefault();
    console.log("Add button clicked");

    // if (this.selectedQuantity < this.stockQuantity) {
    //   this.selectedQuantity += 1
    //   this.showProductQuantityTarget.innerText = this.selectedQuantity
    // } else {
    //   console.log("No Item to add");
    //   }
    console.log(event.currentTarget.dataset)
    const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content");


      fetch(`/orders/${event.currentTarget.dataset.orderId}/order_products?product_id=${event.currentTarget.dataset.productId}&increment=true`, {
      method: "POST",
      headers: { Accept: "application/json", 'X-CSRF-Token': csrf },
      body: JSON.stringify({product_id: event.currentTarget.dataset.product_id}),
    })
      .then((response) => response.json())
      .then((data) => {
        console.log(data);
        document.querySelector("#show_order").innerHTML = data.total
        document.querySelector("#form").innerHTML = data.form
      });

  }

  subtract(event) {
    event.preventDefault();
    console.log("Subtract button clicked");
    const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content");


      fetch(`/orders/${event.currentTarget.dataset.orderId}/order_products?product_id=${event.currentTarget.dataset.productId}`, {
      method: "POST",
      headers: { Accept: "application/json", 'X-CSRF-Token': csrf },
      body: JSON.stringify({product_id: event.currentTarget.dataset.product_id}),
    })
      .then((response) => response.json())
      .then((data) => {
        console.log(data);
        document.querySelector("#show_order").innerHTML = data.total
        document.querySelector("#form").innerHTML = data.form
      });
    }

}
