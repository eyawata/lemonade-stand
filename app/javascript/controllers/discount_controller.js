import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="discount"
export default class extends Controller {
static targets = ["discount", "subtotal", "total"];

  updateTotal() {
    let subtotal = parseFloat(this.subtotalTarget.textContent.replace('¥', ''));
    let discountPercentage = parseFloat(this.discountTarget.value) / 100;
    let discountedAmount = subtotal * discountPercentage;
    let newTotal = subtotal - discountedAmount;

    this.totalTarget.textContent = `¥${newTotal.toFixed(2)}`;
  }
}
